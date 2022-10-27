import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:under_control_v2/features/assets/presentation/cubits/cubit/asset_internal_number_cubit.dart';
import 'package:under_control_v2/features/core/utils/get_cached_firebase_storage_file.dart';

import '../../../core/presentation/pages/loading_page.dart';
import '../../../core/presentation/widgets/creator_bottom_navigation.dart';
import '../../../core/presentation/widgets/keep_alive_page.dart';
import '../../../core/utils/duration_unit.dart';
import '../../../core/utils/show_snack_bar.dart';
import '../../../user_profile/presentation/blocs/user_profile/user_profile_bloc.dart';
import '../../data/models/asset_model.dart';
import '../../domain/entities/asset.dart';
import '../../utils/asset_status.dart';
import '../blocs/asset/asset_bloc.dart';
import '../blocs/asset_management/asset_management_bloc.dart';
import '../widgets/add_asset_card.dart';
import '../widgets/add_asset_data_card.dart';
import '../widgets/add_asset_documents.dart';
import '../widgets/add_asset_images_card.dart';
import '../widgets/add_asset_instructions.dart';
import '../widgets/add_asset_is_in_use_card.dart';
import '../widgets/add_asset_is_spare_part.dart';
import '../widgets/add_asset_location_card.dart';
import '../widgets/add_asset_spare_parts.dart';
import '../widgets/add_asset_status_card.dart';
import '../widgets/add_asset_summary_card.dart';

class AddAssetPage extends StatefulWidget {
  const AddAssetPage({Key? key}) : super(key: key);

  static const routeName = '/assets/add-asset';

  @override
  State<AddAssetPage> createState() => _AddAssetPageState();
}

class _AddAssetPageState extends State<AddAssetPage> {
  Asset? _asset;
  late String _userId;
  late String _companyId;

  bool _loadingImages = false;
  bool _loadingDocuments = false;

  bool _isCodeAvailable = false;

  // pageview
  List<Widget> _pages = [];
  final _pageController = PageController();

  final _formKey = GlobalKey<FormState>();

  final _producerTextEditingController = TextEditingController();
  final _modelTextEditingController = TextEditingController();
  final _descriptionTextEditingController = TextEditingController();
  final _internalCodeTextEditingController = TextEditingController();
  final _barCodeTextEditingController = TextEditingController();

  String _categoryId = '';
  String _locationId = '';
  String _currentParentId = '';

  final _priceTextEditingController = TextEditingController();

  bool _isInUse = true;
  bool _isSparePart = false;

  bool _isAddAssetVisible = false;
  bool _isAddInventoryVisible = false;
  bool _isAddInstructionsVisible = false;

  DateTime _addDate = DateTime.now();
  DateTime _lastInspectionDate = DateTime.now();
  String _assetStatus = '';
  String _durationUnit = '';
  int _duration = 0;

  List<File> _images = [];
  List<File> _documents = [];
  List<String> _spareParts = [];
  List<String> _instructions = [];

  _addNewAsset(BuildContext context) {
    String errorMessage = '';
    double price = 0;
    if (!_formKey.currentState!.validate()) {
      if (_producerTextEditingController.text.trim().length < 2) {
        errorMessage =
            '${AppLocalizations.of(context)!.item_producer} - ${AppLocalizations.of(context)!.validation_min_two_characters}';
      } else if (_modelTextEditingController.text.trim().length < 2) {
        errorMessage =
            '${AppLocalizations.of(context)!.item_name} - ${AppLocalizations.of(context)!.validation_min_two_characters}';
      } else if (_internalCodeTextEditingController.text.trim().length < 2) {
        errorMessage =
            '${AppLocalizations.of(context)!.item_internal_code} - ${AppLocalizations.of(context)!.validation_min_two_characters}';
      }
    } else {
      // allowed same internal code only while editing asset
      if (!_isCodeAvailable &&
          ((_asset == null || _asset!.id.isEmpty) ||
              (_asset != null &&
                  _asset!.internalCode.toLowerCase() !=
                      _internalCodeTextEditingController.text
                          .trim()
                          .toLowerCase()))) {
        errorMessage = 'ten sam kod';
      }
      // category selection validation
      if (errorMessage.isEmpty && _categoryId.isEmpty) {
        errorMessage =
            AppLocalizations.of(context)!.item_add_error_category_not_selected;

        // price validation
      }
      if (errorMessage.isEmpty &&
          _priceTextEditingController.text.trim().isNotEmpty) {
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
      // location validation
      if (errorMessage.isEmpty && _locationId.isEmpty) {
        errorMessage =
            AppLocalizations.of(context)!.validation_location_not_selected;
      }
      // asset status
      if (errorMessage.isEmpty && _assetStatus.isEmpty) {
        errorMessage = AppLocalizations.of(context)!.asset_status_not_selected;
      }
      // duration unit and duration
      if (errorMessage.isEmpty && (_duration == 0 || _durationUnit.isEmpty)) {
        errorMessage = AppLocalizations.of(context)!.asset_next_inspection_tip;
      }
      // parent asset validation
      if (errorMessage.isEmpty &&
          _currentParentId.isEmpty &&
          _isSparePart &&
          _isInUse) {
        errorMessage = AppLocalizations.of(context)!.asset_parent_select;
      }
    }

    // shows SnackBar if validation error occures
    if (errorMessage.isNotEmpty) {
      showSnackBar(
        context: context,
        message: errorMessage,
        isErrorMessage: true,
      );
      // saves instruction to DB if no error
    } else {
      final newAsset = AssetModel(
        id: _asset != null ? _asset!.id : '',
        producer: _asset != null
            ? _asset!.producer
            : _producerTextEditingController.text,
        model:
            _asset != null ? _asset!.model : _modelTextEditingController.text,
        description: _asset != null
            ? _asset!.description
            : _descriptionTextEditingController.text,
        categoryId: _asset != null ? _asset!.categoryId : _categoryId,
        locationId: _asset != null ? _asset!.locationId : _locationId,
        internalCode: _asset != null
            ? _asset!.internalCode
            : _internalCodeTextEditingController.text,
        barCode: _asset != null
            ? _asset!.barCode
            : _barCodeTextEditingController.text,
        price: price,
        isInUse: _asset != null ? _asset!.isInUse : _isInUse,
        addDate: _asset != null ? _asset!.addDate : _addDate,
        currentStatus: _asset != null
            ? _asset!.currentStatus
            : AssetStatus.fromString(_assetStatus),
        lastInspection:
            _asset != null ? _asset!.lastInspection : _lastInspectionDate,
        durationUnit: _asset != null
            ? _asset!.durationUnit
            : DurationUnit.fromString(_durationUnit),
        duration: _asset != null ? _asset!.duration : _duration,
        images: _asset != null ? _asset!.images : const [],
        documents: _asset != null ? _asset!.documents : const [],
        instructions: _asset != null ? _asset!.instructions : _instructions,
        spareParts: _asset != null ? _asset!.spareParts : _spareParts,
        currentParentId:
            _asset != null ? _asset!.currentParentId : _currentParentId,
        isSparePart: _asset != null ? _asset!.isSparePart : _isSparePart,
      );

      // add new asset
      // if (_asset == null) {
      //   context.read<AssetManagementBloc>().add(
      //         AddAssetEvent(
      //           asset: newAsset,
      //           documents: _documents,
      //           images: _images,
      //         ),
      //       );
      // } else {
      //   context.read<AssetManagementBloc>().add(
      //         UpdateAssetEvent(
      //           asset: newAsset,
      //           documents: _documents,
      //           images: _images,
      //         ),
      //       );
      // }

      // Navigator.pop(context);
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

  void _addImage(File image) {
    setState(() {
      _images.add(image);
    });
  }

  void _removeImage(File image) {
    setState(() {
      _images.remove(image);
    });
  }

  void _toggleAddAssetVisibility() {
    setState(() {
      _isAddAssetVisible = !_isAddAssetVisible;
    });
  }

  void _toggleAddInventoryVisibility() {
    setState(() {
      _isAddInventoryVisible = !_isAddInventoryVisible;
    });
  }

  void _toggleAddInstructionsVisibility() {
    setState(() {
      _isAddInstructionsVisible = !_isAddInstructionsVisible;
    });
  }

  void _toggleSparePartSelection(String sparePartId) {
    if (!_spareParts.contains(sparePartId)) {
      setState(() {
        _spareParts.add(sparePartId);
      });
    } else {
      setState(() {
        _spareParts.remove(sparePartId);
      });
    }
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

  void _setParentAsset(String parentAssetId) {
    setState(() {
      _currentParentId = parentAssetId;
    });
  }

  void _setIsInUse(bool value) {
    setState(() {
      _isInUse = value;
    });
  }

  void _setAssetStatus(String value) {
    setState(() {
      _assetStatus = value;
    });
  }

  void _setDuration(String value) {
    setState(() {
      _duration = int.parse(value);
    });
  }

  void _setDurationUnit(String value) {
    setState(() {
      _durationUnit = value;
      _duration = 0;
    });
  }

  void _setCategory(String value) {
    setState(() {
      _categoryId = value;
    });
  }

  void _setDate(DateTime date) {
    setState(() {
      _addDate = date;
    });
  }

  void _setLastInspectionDate(DateTime date) {
    setState(() {
      _lastInspectionDate = date;
    });
  }

  void _setIsSparePart(bool value) {
    setState(() {
      _isSparePart = value;
    });
  }

  void _setLocation(String location) async {
    setState(() {
      _locationId = location;
    });
    await Future.delayed(
      const Duration(milliseconds: 500),
    );
    _pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeIn,
    );
  }

  void fetchImages(List<String> urls) async {
    setState(() {
      _loadingImages = true;
    });
    List<File> result = [];
    for (var url in urls) {
      final image = await getCachedFirebaseStorageFile(url);
      if (image != null) {
        result.add(image);
      }
    }
    setState(() {
      _images = result;
      _loadingImages = false;
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
      if (_isAddAssetVisible) {
        _toggleAddAssetVisibility();
      } else if (_isAddInventoryVisible) {
        _toggleAddInventoryVisibility();
      } else if (_isAddInstructionsVisible) {
        _toggleAddInstructionsVisibility();
      }
    });
    _internalCodeTextEditingController.addListener(() {
      context.read<AssetInternalNumberCubit>().checkAssetCodeAvailability(
            code: _internalCodeTextEditingController.text.trim(),
            companyId: _companyId,
          );
    });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    final arguments = ModalRoute.of(context)!.settings.arguments;

    final userState = context.watch<UserProfileBloc>().state;
    if (userState is Approved) {
      _userId = userState.userProfile.id;
      _companyId = userState.userProfile.companyId;
    }

    final internalNumberState = context.watch<AssetInternalNumberCubit>().state;
    if (internalNumberState is AssetInternalNumberLoadedState) {
      _isCodeAvailable = internalNumberState.isCodeAvailable;
    } else {
      _isCodeAvailable = false;
    }

    if (arguments != null && arguments is AssetModel && _asset == null) {
      _asset = arguments.deepCopy();

      if (_asset!.images.isNotEmpty) {
        fetchImages(_asset!.images);
      }

      if (_asset!.documents.isNotEmpty) {
        fetchDocuments(_asset!.documents);
      }

      _producerTextEditingController.text = _asset!.producer;
      _modelTextEditingController.text = _asset!.model;
      _descriptionTextEditingController.text = _asset!.description;
      _internalCodeTextEditingController.text = _asset!.internalCode;
      _barCodeTextEditingController.text = _asset!.barCode;

      _categoryId = _asset!.categoryId;
      _locationId = _asset!.locationId;
      _currentParentId = _asset!.currentParentId;
      _isInUse = _asset!.isInUse;
      _isSparePart = _asset!.isSparePart;
      _lastInspectionDate = _asset!.lastInspection;
      _assetStatus = _asset!.currentStatus.name;
      _durationUnit = _asset!.durationUnit.name;
      _duration = _asset!.duration;
      _priceTextEditingController.text = _asset!.price.toString();
      _addDate = _asset!.addDate;

      _spareParts = _asset!.spareParts;
      _instructions = _asset!.instructions;
    }

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _producerTextEditingController.dispose();
    _modelTextEditingController.dispose();
    _descriptionTextEditingController.dispose();
    _internalCodeTextEditingController.dispose();
    _barCodeTextEditingController.dispose();
    _priceTextEditingController.dispose();
    super.dispose();
  }

  // TODO
  // finish copy mode and internal code validation

  @override
  Widget build(BuildContext context) {
    _pages = [
      KeepAlivePage(
        child: AddAssetCard(
          isCopyMode: _asset != null && _asset!.id.isEmpty,
          isEditMode: _asset != null,
          producerTextEditingController: _producerTextEditingController,
          modelTextEditingController: _modelTextEditingController,
          descriptionTextEditingController: _descriptionTextEditingController,
        ),
      ),
      KeepAlivePage(
        child: AddAssetDataCard(
          category: _categoryId,
          setCategory: _setCategory,
          priceTextEditingController: _priceTextEditingController,
          codeTextEditingController: _internalCodeTextEditingController,
          barCodeTextEditingController: _barCodeTextEditingController,
          dateTime: _addDate,
          setDate: _setDate,
        ),
      ),
      KeepAlivePage(
        child: AddAssetLocationCard(
          selectedLocation: _locationId,
          setLocation: _setLocation,
        ),
      ),
      KeepAlivePage(
        child: AddAssetStatusCard(
          lastInspectionDate: _lastInspectionDate,
          setLastInspectionDate: _setLastInspectionDate,
          durationUnit: _durationUnit,
          setDurationUnit: _setDurationUnit,
          assetStatus: _assetStatus,
          setAssetStatus: _setAssetStatus,
          duration: _duration,
          setDuration: _setDuration,
        ),
      ),
      AddAssetIsSparePartCard(
        setIsSparePart: _setIsSparePart,
        isSparePart: _isSparePart,
        setParentAsset: _setParentAsset,
      ),
      AddAssetIsInUseCard(
        setIsInUse: _setIsInUse,
        isInUse: _isInUse,
        setParentAsset: _setParentAsset,
        isSparePart: _isSparePart,
        setLocation: _setLocation,
        currentParentId: _currentParentId,
      ),
      AddAssetSparePartCard(
        toggleSelection: _toggleSparePartSelection,
        spareParts: _spareParts,
        isAddAssetVisible: _isAddAssetVisible,
        isAddInventoryVisible: _isAddInventoryVisible,
        toggleAddAssetVisibility: _toggleAddAssetVisibility,
        toggleAddInventoryVisibility: _toggleAddInventoryVisibility,
      ),
      AddAssetInstructionsCard(
        toggleSelection: _toggleInstructionSelection,
        toggleAddInstructionsVisibility: _toggleAddInstructionsVisibility,
        instructions: _instructions,
        isAddInstructionsVisible: _isAddInstructionsVisible,
      ),
      AddAssetImagesCard(
        addImage: _addImage,
        removeImage: _removeImage,
        images: _images,
        loading: _loadingImages,
      ),
      AddAssetDocumentsCard(
        addDocument: _addDocument,
        removeDocument: _removeDocument,
        documents: _documents,
        loading: _loadingDocuments,
      ),
      AddAssetSummaryCard(
        pageController: _pageController,
        producerTextEditingController: _producerTextEditingController,
        modelTextEditingController: _modelTextEditingController,
        descriptionTextEditingController: _descriptionTextEditingController,
        category: _categoryId,
        priceTextEditingController: _priceTextEditingController,
        internalCodeTextEditingController: _internalCodeTextEditingController,
        barCodeTextEditingController: _barCodeTextEditingController,
        addDate: _addDate,
        selectedLocation: _locationId,
        lastInspectionDate: _lastInspectionDate,
        assetStatus: _assetStatus,
        durationUnit: _durationUnit,
        duration: _duration,
        isSparePart: _isSparePart,
        isInUse: _isInUse,
        parentId: _currentParentId,
        spareParts: _spareParts,
        instructions: _instructions,
        images: _images,
        documents: _documents,
      ),
    ];

    DateTime preBackpress = DateTime.now();

    return WillPopScope(
      onWillPop: () async {
        if (_isAddAssetVisible) {
          _toggleAddAssetVisibility();
          return false;
        }
        if (_isAddInventoryVisible) {
          _toggleAddInventoryVisibility();
          return false;
        }
        if (_isAddInstructionsVisible) {
          _toggleAddInstructionsVisibility();
          return false;
        }
        // double click to exit the app
        final timegap = DateTime.now().difference(preBackpress);
        final cantExit = timegap >= const Duration(seconds: 2);
        preBackpress = DateTime.now();
        if (cantExit) {
          showSnackBar(
            context: context,
            message: _asset != null
                ? AppLocalizations.of(context)!.back_to_exit_edit
                : AppLocalizations.of(context)!.back_to_exit_creator,
            isErrorMessage: true,
          );
          return false;
        } else {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          return true;
        }
      },
      child: Scaffold(
        body: BlocBuilder<AssetBloc, AssetState>(
          builder: (context, state) {
            if (state is AssetLoadingState) {
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
                    lastPageForwardButtonFunction: () => _addNewAsset(context),
                    pages: _pages,
                    pageController: _pageController,
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
