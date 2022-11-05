import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:under_control_v2/features/assets/utils/asset_status.dart';
import 'package:under_control_v2/features/tasks/presentation/widgets/set_task_status.dart';

import '../../../assets/presentation/widgets/add_asset_images_card.dart';
import '../../../assets/presentation/widgets/add_asset_location_card.dart';
import '../../../core/presentation/pages/loading_page.dart';
import '../../../core/presentation/widgets/creator_bottom_navigation.dart';
import '../../../core/presentation/widgets/keep_alive_page.dart';
import '../../../core/utils/get_cached_firebase_storage_file.dart';
import '../../../core/utils/show_snack_bar.dart';
import '../../../user_profile/presentation/blocs/user_profile/user_profile_bloc.dart';
import '../../data/models/work_order/work_order_model.dart';
import '../../domain/entities/task_priority.dart';
import '../../domain/entities/work_order/work_order.dart';
import '../blocs/work_order/work_order_bloc.dart';
import '../blocs/work_order_management/work_order_management_bloc.dart';
import '../widgets/add_video_card.dart';
import '../widgets/add_work_order/add_work_order_card.dart';
import '../widgets/add_work_order/add_work_order_set_asset_card.dart';
import '../widgets/add_work_order/add_work_order_summary_card.dart';
import '../widgets/set_priority_card.dart';

class AddWorkOrderPage extends StatefulWidget {
  const AddWorkOrderPage({Key? key}) : super(key: key);

  static const routeName = '/tasks/add-work-order';

  @override
  State<AddWorkOrderPage> createState() => _AddWorkOrderPageState();
}

class _AddWorkOrderPageState extends State<AddWorkOrderPage> {
  WorkOrder? _workOrder;

  bool _loadingImages = false;

  // pageview
  List<Widget> _pages = [];
  final _pageController = PageController();

  final _formKey = GlobalKey<FormState>();

  final _titleTextEditingController = TextEditingController();
  final _descriptionTextEditingController = TextEditingController();

  String _locationId = '';
  String _userId = '';
  String _assetId = '';
  String _priority = TaskPriority.low.name;
  String _assetStatus = '';

  bool _isAddAssetVisible = false;
  bool _isConnectedToAsset = false;

  DateTime _date = DateTime.now();

  List<File> _images = [];

  File? _videoFile;

  _addNewWorkOrder(BuildContext context) {
    String errorMessage = '';
    if (!_formKey.currentState!.validate()) {
      if (_titleTextEditingController.text.trim().length < 2) {
        errorMessage =
            '${AppLocalizations.of(context)!.title} - ${AppLocalizations.of(context)!.validation_min_two_characters}';
      }
    } else {
      // asset selection validation
      if (errorMessage.isEmpty && _isConnectedToAsset && _assetId.isEmpty) {
        errorMessage =
            AppLocalizations.of(context)!.task_connected_asset_select;
      }
      // location validation
      if (errorMessage.isEmpty && _locationId.isEmpty) {
        errorMessage =
            AppLocalizations.of(context)!.validation_location_not_selected;
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
      final newWorkOrder = WorkOrderModel(
        id: _workOrder != null ? _workOrder!.id : '',
        title: _titleTextEditingController.text,
        description: _descriptionTextEditingController.text,
        date: _date,
        locationId: _locationId,
        userId: _userId,
        assetId: _assetId,
        images: const [],
        video: '',
        priority: TaskPriority.fromString(_priority),
        count: _workOrder != null ? _workOrder!.count : 0,
        taskId: '',
        cancelled: false,
      );

      // add new work order
      if (_workOrder == null || _workOrder!.id.isEmpty) {
        context.read<WorkOrderManagementBloc>().add(
              AddWorkOrderEvent(
                workOrder: newWorkOrder,
                images: _images,
                video: _videoFile,
              ),
            );
        // update work order
      } else {
        context.read<WorkOrderManagementBloc>().add(
              UpdateWorkOrderEvent(
                workOrder: newWorkOrder,
                images: _images,
                video: _videoFile,
              ),
            );
      }

      Navigator.pop(context);
    }
  }

  void _setVideo(File? video) {
    setState(() {
      _videoFile = video;
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

  void _setPriority(String value) {
    setState(() {
      _priority = value;
    });
  }

  void _setAssetStatus(String value) {
    setState(() {
      _assetStatus = value;
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
        _locationId = '';
      });
    } else {
      setState(() {
        _isConnectedToAsset = false;
        _assetId = '';
        _locationId = '';
      });
    }
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
    if (mounted) {
      setState(() {
        _images = result;
        _loadingImages = false;
      });
    }
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
      _userId = userState.userProfile.id;
    }

    if (arguments != null && arguments is WorkOrder && _workOrder == null) {
      _workOrder = WorkOrderModel.fromWorkOrder(arguments).deepCopy();

      if (_workOrder!.images.isNotEmpty) {
        fetchImages(_workOrder!.images);
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
      if (_isConnectedToAsset)
        SetAssetStatusCard(
          setStatus: _setAssetStatus,
          assetStatus: _assetStatus,
        ),
      if (!_isConnectedToAsset)
        KeepAlivePage(
          child: AddAssetLocationCard(
            selectedLocation: _locationId,
            setLocation: _setLocation,
          ),
        ),
      AddAssetImagesCard(
        addImage: _addImage,
        removeImage: _removeImage,
        images: _images,
        loading: _loadingImages,
      ),
      KeepAlivePage(
        child: AddVideoCard(
          videoFile: _videoFile,
          videoUrl: _workOrder?.video,
          updateVideo: _setVideo,
        ),
      ),
      SetPriorityCard(
        setPriority: _setPriority,
        priority: _priority,
      ),
      AddWorkOrderSummaryCard(
        pageController: _pageController,
        titleTextEditingController: _titleTextEditingController,
        descriptionTextEditingController: _descriptionTextEditingController,
        date: _date,
        locationId: _locationId,
        assetId: _assetId,
        priority: _priority,
        isConnectedToAsset: _isConnectedToAsset,
        images: _images,
      ),
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
