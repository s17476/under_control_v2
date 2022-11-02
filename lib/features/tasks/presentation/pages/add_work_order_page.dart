import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:under_control_v2/features/tasks/data/models/work_order/work_order_model.dart';
import 'package:under_control_v2/features/tasks/presentation/widgets/add_work_order/add_work_order_set_asset_card.dart';

import '../../../core/presentation/pages/loading_page.dart';
import '../../../core/presentation/widgets/creator_bottom_navigation.dart';
import '../../../core/presentation/widgets/keep_alive_page.dart';
import '../../../core/utils/duration_unit.dart';
import '../../../core/utils/get_cached_firebase_storage_file.dart';
import '../../../core/utils/show_snack_bar.dart';
import '../../../user_profile/presentation/blocs/user_profile/user_profile_bloc.dart';
import '../../domain/entities/work_order/work_order.dart';
import '../blocs/work_order/work_order_bloc.dart';
import '../widgets/add_work_order/add_work_order_card.dart';

class AddWorkOrderPage extends StatefulWidget {
  const AddWorkOrderPage({Key? key}) : super(key: key);

  static const routeName = '/tasks/add-work-order';

  @override
  State<AddWorkOrderPage> createState() => _AddWorkOrderPageState();
}

class _AddWorkOrderPageState extends State<AddWorkOrderPage> {
  WorkOrder? _workOrder;

  late String _companyId;

  bool _loadingImages = false;
  bool _loadingVideo = false;

  // pageview
  List<Widget> _pages = [];
  final _pageController = PageController();

  final _formKey = GlobalKey<FormState>();

  final _titleTextEditingController = TextEditingController();
  final _descriptionTextEditingController = TextEditingController();

  String _locationId = '';
  String _userId = '';
  String _assetId = '';
  String _priority = '';

  bool _isAddAssetVisible = false;
  bool _isConnectedToAsset = false;

  DateTime _date = DateTime.now();

  List<File> _images = [];

  File? _videoFile;

  _addNewWorkOrder(BuildContext context) {
    // String errorMessage = '';
    // double price = 0;
    // if (!_formKey.currentState!.validate()) {
    //   if (_titleTextEditingController.text.trim().length < 2) {
    //     errorMessage =
    //         '${AppLocalizations.of(context)!.item_producer} - ${AppLocalizations.of(context)!.validation_min_two_characters}';
    //   } else if (_modelTextEditingController.text.trim().length < 2) {
    //     errorMessage =
    //         '${AppLocalizations.of(context)!.item_name} - ${AppLocalizations.of(context)!.validation_min_two_characters}';
    //   } else if (_internalCodeTextEditingController.text.trim().length < 2) {
    //     errorMessage =
    //         '${AppLocalizations.of(context)!.item_internal_code} - ${AppLocalizations.of(context)!.validation_min_two_characters}';
    //   }
    // } else {
    //   // allowed same internal code only while editing asset
    //   if (!_isCodeAvailable &&
    //       ((_asset == null || _asset!.id.isEmpty) ||
    //           (_asset != null &&
    //               _asset!.internalCode.toLowerCase() !=
    //                   _internalCodeTextEditingController.text
    //                       .trim()
    //                       .toLowerCase()))) {
    //     errorMessage = AppLocalizations.of(context)!.asset_msg_code_exists;
    //   }
    //   // category selection validation
    //   if (errorMessage.isEmpty && _categoryId.isEmpty) {
    //     errorMessage =
    //         AppLocalizations.of(context)!.item_add_error_category_not_selected;

    //     // price validation
    //   }
    //   if (errorMessage.isEmpty &&
    //       _priceTextEditingController.text.trim().isNotEmpty) {
    //     try {
    //       price = double.parse(_priceTextEditingController.text.trim());
    //       if (price < 0) {
    //         errorMessage =
    //             AppLocalizations.of(context)!.incorrect_price_to_small;
    //       }
    //     } catch (e) {
    //       errorMessage = AppLocalizations.of(context)!.incorrect_price_format;
    //     }
    //   }
    //   // location validation
    //   if (errorMessage.isEmpty && _locationId.isEmpty) {
    //     errorMessage =
    //         AppLocalizations.of(context)!.validation_location_not_selected;
    //   }
    //   // asset status
    //   if (errorMessage.isEmpty && _priority.isEmpty) {
    //     errorMessage = AppLocalizations.of(context)!.asset_status_not_selected;
    //   }
    //   // duration unit and duration
    //   if (errorMessage.isEmpty && (_duration == 0 || _durationUnit.isEmpty)) {
    //     errorMessage = AppLocalizations.of(context)!.asset_next_inspection_tip;
    //   }
    //   // parent asset validation
    //   if (errorMessage.isEmpty &&
    //       _currentParentId.isEmpty &&
    //       _isSparePart &&
    //       _isInUse) {
    //     errorMessage = AppLocalizations.of(context)!.asset_parent_select;
    //   }
    // }

    // // shows SnackBar if validation error occures
    // if (errorMessage.isNotEmpty) {
    //   showSnackBar(
    //     context: context,
    //     message: errorMessage,
    //     isErrorMessage: true,
    //   );
    //   // saves instruction to DB if no error
    // } else {
    //   final newAsset = AssetModel(
    //     id: _asset != null ? _asset!.id : '',
    //     producer: _titleTextEditingController.text,
    //     model: _modelTextEditingController.text,
    //     description: _descriptionTextEditingController.text,
    //     categoryId: _categoryId,
    //     locationId: _locationId,
    //     internalCode: _internalCodeTextEditingController.text,
    //     barCode: _barCodeTextEditingController.text,
    //     price: price,
    //     isInUse: _isInUse,
    //     addDate: _date,
    //     currentStatus: AssetStatus.fromString(_priority),
    //     lastInspection: _lastInspectionDate,
    //     durationUnit: DurationUnit.fromString(_durationUnit),
    //     duration: _duration,
    //     images: const [],
    //     documents: const [],
    //     instructions: _instructions,
    //     spareParts: _spareParts,
    //     currentParentId: _currentParentId,
    //     isSparePart: _isSparePart,
    //   );

    //   // add new asset
    //   if (_asset == null || _asset!.id.isEmpty) {
    //     context.read<AssetManagementBloc>().add(
    //           AddAssetEvent(
    //             asset: newAsset,
    //             documents: _documents,
    //             images: _images,
    //           ),
    //         );
    //   } else {
    //     context.read<AssetManagementBloc>().add(
    //           UpdateAssetEvent(
    //             asset: newAsset,
    //             documents: _documents,
    //             images: _images,
    //           ),
    //         );
    //   }

    //   Navigator.pop(context);
    // }
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

  void _setTaskPriority(String value) {
    setState(() {
      _priority = value;
    });
  }

  void _setAssetId(String assetId) {
    setState(() {
      _assetId = assetId;
    });
  }

  void _setIsConnectedToAsset(bool value) {
    if (value) {
      setState(() {
        _isConnectedToAsset = true;
      });
    } else {
      setState(() {
        _isConnectedToAsset = false;
        _assetId = '';
      });
    }
  }

  void _setDate(DateTime date) {
    setState(() {
      _date = date;
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

  void fetchVideo(String videoUrl) async {
    setState(() {
      _loadingVideo = true;
    });
    final videoFile = await getCachedFirebaseStorageFile(videoUrl);
    setState(() {
      _videoFile = videoFile;
      _loadingVideo = false;
    });
  }

  @override
  void initState() {
    _pageController.addListener(() {
      FocusScope.of(context).unfocus();
      if (_isAddAssetVisible) {
        _toggleAddAssetVisibility();
      }
    });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    final arguments = ModalRoute.of(context)!.settings.arguments;

    final userState = context.watch<UserProfileBloc>().state;
    if (userState is Approved) {
      _companyId = userState.userProfile.companyId;
      _userId = userState.userProfile.id;
    }

    if (arguments != null && arguments is WorkOrder && _workOrder == null) {
      _workOrder = WorkOrderModel.fromWorkOrder(arguments).deepCopy();

      if (_workOrder!.images.isNotEmpty) {
        fetchImages(_workOrder!.images);
      }

      if (_workOrder!.video.isEmpty) {
        fetchVideo(_workOrder!.video);
      }

      _titleTextEditingController.text = _workOrder!.title;
      _descriptionTextEditingController.text = _workOrder!.description;
      _locationId = _workOrder!.locationId;
      _priority = _workOrder!.priority.name;
      _date = _workOrder!.date;
      _assetId = _workOrder!.assetId;
    }

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _titleTextEditingController.dispose();
    _descriptionTextEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _pages = [
      KeepAlivePage(
        child: AddWorkOrderCard(
          isEditMode: _workOrder != null,
          titleTextEditingController: _titleTextEditingController,
          descriptionTextEditingController: _descriptionTextEditingController,
        ),
      ),
      AddWorkOrderSetAssetCard(
        setIsConnectedToAsset: _setIsConnectedToAsset,
        isConnectedToAsset: _isConnectedToAsset,
        setAssetId: _setAssetId,
        setLocation: _setLocation,
        assetId: _assetId,
      ),
      // KeepAlivePage(
      //   child: AddAssetDataCard(
      //     category: _categoryId,
      //     setCategory: _setCategory,
      //     priceTextEditingController: _priceTextEditingController,
      //     codeTextEditingController: _internalCodeTextEditingController,
      //     barCodeTextEditingController: _barCodeTextEditingController,
      //     dateTime: _date,
      //     setDate: _setDate,
      //   ),
      // ),
      // KeepAlivePage(
      //   child: AddAssetLocationCard(
      //     selectedLocation: _locationId,
      //     setLocation: _setLocation,
      //   ),
      // ),
      // KeepAlivePage(
      //   child: AddAssetStatusCard(
      //     lastInspectionDate: _lastInspectionDate,
      //     setLastInspectionDate: _setLastInspectionDate,
      //     durationUnit: _durationUnit,
      //     setDurationUnit: _setDurationUnit,
      //     assetStatus: _priority,
      //     setAssetStatus: _setTaskPriority,
      //     duration: _duration,
      //     setDuration: _setDuration,
      //   ),
      // ),
      // AddAssetIsSparePartCard(
      //   setIsSparePart: _setIsSparePart,
      //   isSparePart: _isSparePart,
      //   setParentAsset: _setParentAsset,
      // ),
      // AddAssetIsInUseCard(
      //   setIsInUse: _setIsInUse,
      //   isInUse: _isInUse,
      //   setParentAsset: _setParentAsset,
      //   isSparePart: _isSparePart,
      //   setLocation: _setLocation,
      //   currentParentId: _currentParentId,
      // ),
      // AddAssetSparePartCard(
      //   toggleSelection: _toggleSparePartSelection,
      //   spareParts: _spareParts,
      //   isAddAssetVisible: _isAddAssetVisible,
      //   isAddInventoryVisible: _isAddInventoryVisible,
      //   toggleAddAssetVisibility: _toggleAddAssetVisibility,
      //   toggleAddInventoryVisibility: _toggleAddInventoryVisibility,
      // ),
      // AddAssetInstructionsCard(
      //   toggleSelection: _toggleInstructionSelection,
      //   toggleAddInstructionsVisibility: _toggleAddInstructionsVisibility,
      //   instructions: _instructions,
      //   isAddInstructionsVisible: _isAddInstructionsVisible,
      // ),
      // AddAssetImagesCard(
      //   addImage: _addImage,
      //   removeImage: _removeImage,
      //   images: _images,
      //   loading: _loadingImages,
      // ),
      // AddAssetDocumentsCard(
      //   addDocument: _addDocument,
      //   removeDocument: _removeDocument,
      //   documents: _documents,
      //   loading: _loadingDocuments,
      // ),
      // AddAssetSummaryCard(
      //   asset: _asset,
      //   pageController: _pageController,
      //   producerTextEditingController: _titleTextEditingController,
      //   modelTextEditingController: _modelTextEditingController,
      //   descriptionTextEditingController: _descriptionTextEditingController,
      //   category: _categoryId,
      //   priceTextEditingController: _priceTextEditingController,
      //   internalCodeTextEditingController: _internalCodeTextEditingController,
      //   barCodeTextEditingController: _barCodeTextEditingController,
      //   addDate: _date,
      //   selectedLocation: _locationId,
      //   lastInspectionDate: _lastInspectionDate,
      //   assetStatus: _priority,
      //   durationUnit: _durationUnit,
      //   duration: _duration,
      //   isSparePart: _isSparePart,
      //   isInUse: _isInUse,
      //   parentId: _currentParentId,
      //   spareParts: _spareParts,
      //   instructions: _instructions,
      //   images: _images,
      //   documents: _documents,
      //   isCodeAvailable: _isCodeAvailable,
      // ),
    ];

    DateTime preBackpress = DateTime.now();

    return WillPopScope(
      onWillPop: () async {
        if (_isAddAssetVisible) {
          _toggleAddAssetVisibility();
          return false;
        }
        // double click to exit the app
        final timegap = DateTime.now().difference(preBackpress);
        final cantExit = timegap >= const Duration(seconds: 2);
        preBackpress = DateTime.now();
        if (cantExit) {
          showSnackBar(
            context: context,
            message: _workOrder != null
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
        body: BlocBuilder<WorkOrderBloc, WorkOrderState>(
          builder: (context, state) {
            if (state is WorkOrderLoadingState) {
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
                    lastPageForwardButtonFunction: () =>
                        _addNewWorkOrder(context),
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
