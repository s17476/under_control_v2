import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/presentation/pages/loading_page.dart';
import '../../../core/presentation/widgets/creator_bottom_navigation.dart';
import '../../../core/presentation/widgets/keep_alive_page.dart';
import '../../../core/utils/show_snack_bar.dart';
import '../../data/models/item_model.dart';
import '../../domain/entities/item.dart';
import '../blocs/items/items_bloc.dart';
import '../blocs/items_management/items_management_bloc.dart';
import '../widgets/add_item/add_item_card.dart';
import '../widgets/add_item/add_item_data_card.dart';
import '../widgets/add_item/add_item_photo_card.dart';
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
        itemCode: _codeTextEditingController.text.trim(),
        itemBarCode: _barCodeTextEditingController.text.trim(),
        itemPhoto: _item != null ? _item!.itemPhoto : '',
        itemUnit: ItemUnit.fromString(_itemUnit),
        amountInLocations: _item != null ? _item!.amountInLocations : const [],
        locations: _item != null ? _item!.locations : const [],
        sparePartFor: const [],
      );

      if (_item != null) {
        context.read<ItemsManagementBloc>().add(UpdateItemEvent(
              item: newItem,
              itemPhoto: _itemImage,
            ));
      } else {
        context.read<ItemsManagementBloc>().add(
              AddItemEvent(
                item: newItem,
                itemPhoto: _itemImage,
              ),
            );
      }

      Navigator.pop(context);
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

  @override
  void initState() {
    _pageController.addListener(() {
      FocusScope.of(context).unfocus();
    });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    final arguments = ModalRoute.of(context)!.settings.arguments;

    if (arguments != null && arguments is ItemModel && _item == null) {
      _item = arguments.deepCopy();

      _producerTextEditingController.text = _item!.producer;
      _nameTextEditingController.text = _item!.name;
      _descriptionTextEditingController.text = _item!.description;
      _codeTextEditingController.text = _item!.itemCode;
      _barCodeTextEditingController.text = _item!.itemBarCode;
      _priceTextEditingController.text = _item!.price.toString();
      _category = _item!.category;
      _itemUnit = _item!.itemUnit.name;
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
        child: AddItemPhotoCard(
          setImage: _setImage,
          deleteImage: _deleteImage,
          image: _itemImage,
          imageUrl: _item?.itemPhoto,
        ),
      ),
      AddItemSummaryCard(
        pageController: _pageController,
        producerTextEditingController: _producerTextEditingController,
        titleTextEditingController: _nameTextEditingController,
        descriptionTextEditingController: _descriptionTextEditingController,
        barCodeTextEditingController: _barCodeTextEditingController,
        codeTextEditingController: _codeTextEditingController,
        priceTextEditingController: _priceTextEditingController,
        category: _category,
        itemUnit: _itemUnit,
        itemImage: _itemImage,
      ),
    ];

    DateTime preBackpress = DateTime.now();

    return WillPopScope(
      onWillPop: () async {
        // double click to exit the app
        final timegap = DateTime.now().difference(preBackpress);
        final cantExit = timegap >= const Duration(seconds: 2);
        preBackpress = DateTime.now();
        if (cantExit) {
          ScaffoldMessenger.of(context)
            ..removeCurrentSnackBar()
            ..showSnackBar(SnackBar(
              content: Text(
                AppLocalizations.of(context)!.back_to_exit_creator,
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
              duration: const Duration(seconds: 2),
              backgroundColor: Theme.of(context).errorColor,
            ));
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
