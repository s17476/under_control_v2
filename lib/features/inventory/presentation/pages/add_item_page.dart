import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/presentation/pages/loading_page.dart';
import '../../../core/presentation/widgets/creator_bottom_navigation.dart';
import '../../../core/presentation/widgets/keep_alive_page.dart';
import '../../../core/utils/get_cached_firebase_storage_file.dart';
import '../../../core/utils/show_snack_bar.dart';
import '../../data/models/item_model.dart';
import '../../domain/entities/item.dart';
import '../blocs/items/items_bloc.dart';
import '../blocs/items_management/items_management_bloc.dart';
import '../widgets/add_alert_quantity_card.dart';
import '../widgets/add_item/add_item_additional.dart';
import '../widgets/add_item/add_item_card.dart';
import '../widgets/add_item/add_item_data_card.dart';
import '../widgets/add_item/add_item_summary_card.dart';

class AddItemPage extends StatefulWidget {
  const AddItemPage({
    Key? key,
  }) : super(key: key);

  static const routeName = '/inventory/add-item';

  @override
  State<AddItemPage> createState() => _AddItemPageState();
}

class _AddItemPageState extends State<AddItemPage> {
  Item? _item;

  List<Widget> _pages = [];

  final _formKey = GlobalKey<FormState>();

  final _pageController = PageController();

  final _producerTextEditingController = TextEditingController();
  final _nameTextEditingController = TextEditingController();
  final _descriptionTextEditingController = TextEditingController();
  final _codeTextEditingController = TextEditingController();
  final _barCodeTextEditingController = TextEditingController();
  final _priceTextEditingController = TextEditingController();
  final _alertQuantityTextEditingController = TextEditingController(text: '0');

  List<File> _documents = [];
  List<String> _instructions = [];

  bool _isAlertQuantitySet = false;
  bool _isAddInstructionsVisible = false;
  bool _isAddAdditionalVisible = false;
  bool _loadingDocuments = false;

  String _category = '';
  String _itemUnit = '';

  File? _itemImage;

  void _setImage(ImageSource souruce) async {
    final picker = ImagePicker();

    try {
      final pickedFile = await picker.pickImage(
        source: souruce,
        imageQuality: 100,
        maxHeight: 2000,
        maxWidth: 2000,
      );
      if (pickedFile != null) {
        setState(() {
          _itemImage = File(pickedFile.path);
        });
      }
    } catch (e) {
      showSnackBar(
        context: context,
        message: AppLocalizations.of(context)!
            .user_profile_add_user_image_pisker_error,
      );
    }
  }

  void _deleteImage() {
    setState(() {
      _itemImage = null;
    });
  }

  void _addNewItem(BuildContext context) {
    String errorMessage = '';
    double price = 0;
    double? alertQuantity;
    // item name validation
    if (!_formKey.currentState!.validate()) {
      errorMessage = AppLocalizations.of(context)!.item_add_error_name_to_short;
    } else {
      // price validation
      if (_priceTextEditingController.text.trim().isNotEmpty) {
        try {
          price = double.parse(_priceTextEditingController.text.trim());
          if (price < 0) {
            errorMessage =
                AppLocalizations.of(context)!.incorrect_price_to_small;
          }
        } catch (e) {
          errorMessage = AppLocalizations.of(context)!.incorrect_price_format;
        }
      }
      // category selection validation
      if (_category.isEmpty) {
        errorMessage =
            AppLocalizations.of(context)!.item_add_error_category_not_selected;
      } else {
        // item unit selection validation

        if (_itemUnit.isEmpty) {
          errorMessage =
              AppLocalizations.of(context)!.item_add_error_unit_not_selected;
        } else if (_item == null) {
          final currentState = context.read<ItemsBloc>().state;
          if (currentState is ItemsLoadedState) {
            final tmpItems = currentState.allItems.allItems
                .where((i) => i.name == _nameTextEditingController.text.trim());
            if (tmpItems.isNotEmpty) {
              errorMessage = AppLocalizations.of(context)!
                  .group_management_add_error_name_exists;
            }
          }
        }

        // alert quantity validation
        if (errorMessage.isEmpty) {
          try {
            if (_isAlertQuantitySet) {
              alertQuantity =
                  double.parse(_alertQuantityTextEditingController.text);
              if (alertQuantity < 0) {
                errorMessage = AppLocalizations.of(context)!.quantity_to_small;
              }
            } else {
              alertQuantity = -1;
            }
          } catch (e) {
            errorMessage = AppLocalizations.of(context)!.quantity_format_error;
          }
        }
      }
    }

    // shows SnackBar if validation error occures
    if (errorMessage.isNotEmpty) {
      showSnackBar(
        context: context,
        message: errorMessage,
        isErrorMessage: true,
      );
      // saves group to DB if no error
    } else {
      final newItem = ItemModel(
        id: _item != null ? _item!.id : '',
        producer: _producerTextEditingController.text.trim(),
        name: _nameTextEditingController.text.trim(),
        description: _descriptionTextEditingController.text.trim(),
        category: _category,
        price: price,
        alertQuantity: alertQuantity,
        itemCode: _codeTextEditingController.text.trim(),
        itemBarCode: _barCodeTextEditingController.text.trim(),
        itemPhoto: _item != null ? _item!.itemPhoto : '',
        itemUnit: ItemUnit.fromString(_itemUnit),
        amountInLocations: _item != null ? _item!.amountInLocations : const [],
        locations: _item != null ? _item!.locations : const [],
        sparePartFor: const [],
        instructions: _instructions,
        documents: const [],
      );

      if (_item != null) {
        context.read<ItemsManagementBloc>().add(UpdateItemEvent(
              item: newItem,
              itemPhoto: _itemImage,
              documents: _documents,
            ));
      } else {
        context.read<ItemsManagementBloc>().add(
              AddItemEvent(
                item: newItem,
                itemPhoto: _itemImage,
                documents: _documents,
              ),
            );
      }

      Navigator.pop(context);
    }
  }

  void _addDocument(File doc) {
    setState(() {
      _documents.add(doc);
    });
  }

  void _removeDocument(File doc) {
    setState(() {
      _documents.remove(doc);
    });
  }

  void _toggleInstructionSelection(String instruction) {
    if (!_instructions.contains(instruction)) {
      setState(() {
        _instructions.add(instruction);
      });
    } else {
      setState(() {
        _instructions.remove(instruction);
      });
    }
  }

  void _setCategory(String value) {
    setState(() {
      _category = value;
    });
  }

  void _setItemUnit(String value) {
    setState(() {
      _itemUnit = value;
    });
  }

  void _toggleIsAlertQuantitySet(bool value) {
    setState(() {
      _isAlertQuantitySet = value;
    });
  }

  void _toggleAddInstructionsVisibility() {
    setState(() {
      _isAddInstructionsVisible = !_isAddInstructionsVisible;
    });
  }

  void _toggleAddAdditionalVisibility() {
    setState(() {
      _isAddAdditionalVisible = !_isAddAdditionalVisible;
    });
  }

  void fetchDocuments(List<String> urls) async {
    setState(() {
      _loadingDocuments = true;
    });
    List<File> result = [];
    for (var url in urls) {
      final doc = await getCachedFirebaseStorageFile(url);
      if (doc != null) {
        result.add(doc);
      }
    }
    setState(() {
      _documents = result;
      _loadingDocuments = false;
    });
  }

  @override
  void initState() {
    _pageController.addListener(() {
      FocusScope.of(context).unfocus();
      if (_isAddInstructionsVisible) {
        _toggleAddInstructionsVisibility();
      }
      if (_isAddAdditionalVisible) {
        _toggleAddAdditionalVisibility();
      }
    });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    final arguments = ModalRoute.of(context)!.settings.arguments;

    if (arguments != null && arguments is ItemModel && _item == null) {
      _item = arguments.deepCopy();

      if (_item!.documents.isNotEmpty) {
        fetchDocuments(_item!.documents);
      }

      _producerTextEditingController.text = _item!.producer;
      _nameTextEditingController.text = _item!.name;
      _descriptionTextEditingController.text = _item!.description;
      _codeTextEditingController.text = _item!.itemCode;
      _barCodeTextEditingController.text = _item!.itemBarCode;
      _priceTextEditingController.text = _item!.price.toString();
      if (_item!.alertQuantity != null && _item!.alertQuantity! >= 0) {
        _alertQuantityTextEditingController.text =
            _item!.alertQuantity.toString();
        _isAlertQuantitySet = true;
      } else {
        _isAlertQuantitySet = false;
      }
      _category = _item!.category;
      _itemUnit = _item!.itemUnit.name;
      _instructions = _item!.instructions;
    }
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _producerTextEditingController.dispose();
    _nameTextEditingController.dispose();
    _descriptionTextEditingController.dispose();
    _codeTextEditingController.dispose();
    _barCodeTextEditingController.dispose();
    _priceTextEditingController.dispose();
    _alertQuantityTextEditingController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _pages = [
      KeepAlivePage(
        child: AddItemCard(
          isEditMode: _item != null,
          producerTextEditingController: _producerTextEditingController,
          nameTextEditingController: _nameTextEditingController,
          descriptionTextEditingController: _descriptionTextEditingController,
        ),
      ),
      KeepAlivePage(
        child: AddItemDataCard(
          isEditMode: _item != null,
          priceTextEditingController: _priceTextEditingController,
          codeTextEditingController: _codeTextEditingController,
          barCodeTextEditingController: _barCodeTextEditingController,
          category: _category,
          itemUnit: _itemUnit,
          setCategory: _setCategory,
          setItemUnit: _setItemUnit,
        ),
      ),
      KeepAlivePage(
        child: AddAlertQuantityCard(
          quantityTextEditingController: _alertQuantityTextEditingController,
          isAlertQuantitySet: _isAlertQuantitySet,
          toggleIsAlertQuantitySet: _toggleIsAlertQuantitySet,
          itemUnit: _itemUnit,
        ),
      ),
      AddItemAdditional(
        documents: _documents,
        addDocument: _addDocument,
        removeDocument: _removeDocument,
        loadingDocuments: _loadingDocuments,
        instructions: _instructions,
        toggleInstructionSelection: _toggleInstructionSelection,
        isAddInstructionsVisible: _isAddInstructionsVisible,
        toggleAddInstructionsVisibility: _toggleAddInstructionsVisibility,
        itemImage: _itemImage,
        itemImageUrl: _item?.itemPhoto,
        addImage: _setImage,
        removeImage: _deleteImage,
        isAddAdditionalVisible: _isAddAdditionalVisible,
        toggleAddAdditionalVisibility: _toggleAddAdditionalVisibility,
      ),
      // KeepAlivePage(
      //   child: AddItemPhotoCard(
      //     setImage: _setImage,
      //     deleteImage: _deleteImage,
      //     image: _itemImage,
      //     imageUrl: _item?.itemPhoto,
      //   ),
      // ),
      // AddAssetInstructionsCard(
      //   toggleSelection: _toggleInstructionSelection,
      //   toggleAddInstructionsVisibility: _toggleAddInstructionsVisibility,
      //   instructions: _instructions,
      //   isAddInstructionsVisible: _isAddInstructionsVisible,
      // ),
      // AddAssetDocumentsCard(
      //   addDocument: _addDocument,
      //   removeDocument: _removeDocument,
      //   documents: _documents,
      //   loading: _loadingDocuments,
      // ),
      AddItemSummaryCard(
        pageController: _pageController,
        producerTextEditingController: _producerTextEditingController,
        titleTextEditingController: _nameTextEditingController,
        descriptionTextEditingController: _descriptionTextEditingController,
        barCodeTextEditingController: _barCodeTextEditingController,
        codeTextEditingController: _codeTextEditingController,
        priceTextEditingController: _priceTextEditingController,
        alertQuantityTextEditingController: _alertQuantityTextEditingController,
        isAlertQuantitySet: _isAlertQuantitySet,
        category: _category,
        itemUnit: _itemUnit,
        itemImage: _itemImage,
        instructions: _instructions,
        documents: _documents,
      ),
    ];

    DateTime preBackpress = DateTime.now();

    return WillPopScope(
      onWillPop: () async {
        if (_isAddInstructionsVisible) {
          _toggleAddInstructionsVisibility();
          return false;
        }
        if (_isAddAdditionalVisible) {
          _toggleAddAdditionalVisibility();
          return false;
        }
        // double click to exit the app
        final timegap = DateTime.now().difference(preBackpress);
        final cantExit = timegap >= const Duration(seconds: 2);
        preBackpress = DateTime.now();

        if (cantExit) {
          showSnackBar(
            context: context,
            message: AppLocalizations.of(context)!.back_to_exit_creator,
            isErrorMessage: true,
            showExitButton: true,
          );
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(body: BlocBuilder<ItemsBloc, ItemsState>(
        builder: (context, state) {
          if (state is ItemsLoadingState) {
            return const LoadingPage();
          } else {
            return Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Form(
                  key: _formKey,
                  child: PageView(
                    controller: _pageController,
                    children: _pages,
                  ),
                ),
                CreatorBottomNavigation(
                  lastPageForwardButtonFunction: () => _addNewItem(context),
                  pages: _pages,
                  pageController: _pageController,
                ),
              ],
            );
          }
        },
      )),
    );
  }
}
