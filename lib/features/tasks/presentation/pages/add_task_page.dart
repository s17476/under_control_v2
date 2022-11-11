import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:under_control_v2/features/core/utils/show_snack_bar.dart';
import 'package:under_control_v2/features/tasks/data/models/task/task_model.dart';
import 'package:under_control_v2/features/tasks/domain/entities/task/task.dart';
import 'package:under_control_v2/features/tasks/presentation/widgets/add_task/add_task_type_card.dart';

import '../../../assets/presentation/widgets/add_asset_images_card.dart';
import '../../../assets/presentation/widgets/add_asset_instructions.dart';
import '../../../assets/presentation/widgets/add_asset_location_card.dart';
import '../../../core/presentation/pages/loading_page.dart';
import '../../../core/presentation/widgets/creator_bottom_navigation.dart';
import '../../../core/presentation/widgets/keep_alive_page.dart';
import '../../../core/utils/get_cached_firebase_storage_file.dart';
import '../../../user_profile/presentation/blocs/user_profile/user_profile_bloc.dart';
import '../../data/models/work_request/work_request_model.dart';
import '../../domain/entities/task_priority.dart';
import '../../domain/entities/work_request/work_request.dart';
import '../blocs/task/task_bloc.dart';
import '../widgets/add_task/add_task_card.dart';
import '../widgets/add_task/add_task_summary_card.dart';
import '../widgets/add_video_card.dart';
import '../widgets/add_work_request/add_work_request_set_asset_card.dart';
import '../widgets/set_asset_status_card.dart';
import '../widgets/set_priority_card.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({Key? key}) : super(key: key);

  static const routeName = '/tasks/add-task';

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  WorkRequest? _workRequest;
  Task? _task;

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
  String _taskType = '';

  bool _isAddAssetVisible = false;
  bool _isConnectedToAsset = false;
  bool _isAddInstructionsVisible = false;

  DateTime _date = DateTime.now();

  List<File> _images = [];
  List<String> _instructions = [];

  File? _videoFile;

  _addNewTask(BuildContext context) {
    showSnackBar(context: context, message: 'save');
    // String errorMessage = '';
    // if (!_formKey.currentState!.validate()) {
    //   if (_titleTextEditingController.text.trim().length < 2) {
    //     errorMessage =
    //         '${AppLocalizations.of(context)!.title} - ${AppLocalizations.of(context)!.validation_min_two_characters}';
    //   }
    // } else {
    //   // asset selection validation
    //   if (errorMessage.isEmpty && _isConnectedToAsset && _assetId.isEmpty) {
    //     errorMessage =
    //         AppLocalizations.of(context)!.task_connected_asset_select;
    //   }
    //   // asset selection validation
    //   if (errorMessage.isEmpty && _isConnectedToAsset && _assetStatus.isEmpty) {
    //     errorMessage = AppLocalizations.of(context)!.asset_status_not_selected;
    //   }
    //   // location validation
    //   if (errorMessage.isEmpty && _locationId.isEmpty) {
    //     errorMessage =
    //         AppLocalizations.of(context)!.validation_location_not_selected;
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
    //   final newWorkRequest = WorkRequestModel(
    //     id: _workRequest != null ? _workRequest!.id : '',
    //     title: _titleTextEditingController.text,
    //     description: _descriptionTextEditingController.text,
    //     date: _date,
    //     locationId: _locationId,
    //     userId: _userId,
    //     assetId: _assetId,
    //     images: const [],
    //     video: '',
    //     priority: TaskPriority.fromString(_priority),
    //     count: _workRequest != null ? _workRequest!.count : 0,
    //     taskId: '',
    //     assetStatus: AssetStatus.fromString(_assetStatus),
    //     cancelled: false,
    //   );

    //   // add new work order
    //   if (_workRequest == null || _workRequest!.id.isEmpty) {
    //     context.read<WorkRequestManagementBloc>().add(
    //           AddWorkRequestEvent(
    //             workRequest: newWorkRequest,
    //             images: _images,
    //             video: _videoFile,
    //           ),
    //         );
    //     // update work order
    //   } else {
    //     context.read<WorkRequestManagementBloc>().add(
    //           UpdateWorkRequestEvent(
    //             workRequest: newWorkRequest,
    //             images: _images,
    //             video: _videoFile,
    //           ),
    //         );
    //   }

    //   Navigator.pop(context);
    // }
  }

  void _toggleAddInstructionsVisibility() {
    setState(() {
      _isAddInstructionsVisible = !_isAddInstructionsVisible;
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

  void _setTaskType(String value) {
    setState(() {
      _taskType = value;
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
      _assetStatus = '';
    });
  }

  void _setIsConnectedToAsset(bool value) {
    if (value) {
      setState(() {
        _isConnectedToAsset = true;
        _locationId = '';
        _assetStatus = '';
      });
    } else {
      setState(() {
        _isConnectedToAsset = false;
        _assetId = '';
        _locationId = '';
        _assetStatus = '';
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
      } else if (_isAddInstructionsVisible) {
        _toggleAddInstructionsVisibility();
      }
    });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    final userState = context.watch<UserProfileBloc>().state;
    if (userState is Approved) {
      _userId = userState.userProfile.id;
    }

    final arguments = ModalRoute.of(context)!.settings.arguments;

    // conversion from Work Request
    if (arguments != null && arguments is WorkRequest && _workRequest == null) {
      _workRequest = WorkRequestModel.fromWorkRequest(arguments).deepCopy();

      if (_workRequest!.images.isNotEmpty) {
        fetchImages(_workRequest!.images);
      }
      _titleTextEditingController.text = _workRequest!.title;
      _descriptionTextEditingController.text = _workRequest!.description;
      _locationId = _workRequest!.locationId;
      _priority = _workRequest!.priority.name;
      _date = _workRequest!.date;
      _assetId = _workRequest!.assetId;
      _assetStatus = _workRequest!.assetStatus.name;
      _isConnectedToAsset = _workRequest!.assetId.isNotEmpty;
    }

    // task edit mode
    if (arguments != null && arguments is Task && _task == null) {
      _task = TaskModel.fromTask(arguments).deepCopy();

      if (_task!.images.isNotEmpty) {
        fetchImages(_task!.images);
      }
      _titleTextEditingController.text = _task!.title;
      _descriptionTextEditingController.text = _task!.description;
      _locationId = _task!.locationId;
      _priority = _task!.priority.name;
      _date = _task!.date;
      _assetId = _task!.assetId;
      _assetStatus = _task!.assetStatus.name;
      _isConnectedToAsset = _task!.assetId.isNotEmpty;
      _taskType = _task!.type.name;
      _instructions = _task!.instructions;
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
        child: AddTaskCard(
          isEditMode: _task != null,
          isConvertMode: _workRequest != null,
          titleTextEditingController: _titleTextEditingController,
          descriptionTextEditingController: _descriptionTextEditingController,
        ),
      ),
      AddTaskTypeCard(
        setTaskType: _setTaskType,
        taskType: _taskType,
      ),
      AddWorkRequestSetAssetCard(
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
          videoUrl: (_workRequest != null && _workRequest!.video.isNotEmpty)
              ? _workRequest!.video
              : null,
          updateVideo: _setVideo,
        ),
      ),
      AddAssetInstructionsCard(
        toggleSelection: _toggleInstructionSelection,
        toggleAddInstructionsVisibility: _toggleAddInstructionsVisibility,
        instructions: _instructions,
        isAddInstructionsVisible: _isAddInstructionsVisible,
      ),
      SetPriorityCard(
        setPriority: _setPriority,
        priority: _priority,
      ),
      AddTaskSummaryCard(
        pageController: _pageController,
        titleTextEditingController: _titleTextEditingController,
        descriptionTextEditingController: _descriptionTextEditingController,
        date: _date,
        locationId: _locationId,
        assetId: _assetId,
        priority: _priority,
        assetStatus: _assetStatus,
        isConnectedToAsset: _isConnectedToAsset,
        images: _images,
        type: _taskType,
      ),
    ];

    DateTime preBackpress = DateTime.now();

    return WillPopScope(
      onWillPop: () async {
        if (_isAddAssetVisible) {
          _toggleAddAssetVisibility();
          return false;
        } else if (_isAddInstructionsVisible) {
          _toggleAddInstructionsVisibility();
        }
        // double click to exit the app
        final timegap = DateTime.now().difference(preBackpress);
        final cantExit = timegap >= const Duration(seconds: 2);
        preBackpress = DateTime.now();
        if (cantExit) {
          showSnackBar(
            context: context,
            message: _workRequest != null
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
        body: BlocBuilder<TaskBloc, TaskState>(
          builder: (context, state) {
            if (state is TaskLoadingState) {
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
                    lastPageForwardButtonFunction: () => _addNewTask(context),
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
