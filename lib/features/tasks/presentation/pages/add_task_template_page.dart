import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:under_control_v2/features/assets/domain/entities/asset.dart';
import 'package:under_control_v2/features/tasks/presentation/widgets/add_task/add_task_checkpoints_card.dart';

import '../../../assets/presentation/blocs/asset/asset_bloc.dart';
import '../../../assets/presentation/widgets/add_asset/add_asset_images_card.dart';
import '../../../assets/presentation/widgets/add_asset/add_asset_instructions.dart';
import '../../../assets/presentation/widgets/add_asset/add_asset_location_card.dart';
import '../../../assets/utils/asset_status.dart';
import '../../../checklists/data/models/checkpoint_model.dart';
import '../../../core/presentation/pages/loading_page.dart';
import '../../../core/presentation/widgets/creator_bottom_navigation.dart';
import '../../../core/presentation/widgets/keep_alive_page.dart';
import '../../../core/utils/duration_unit.dart';
import '../../../core/utils/get_cached_firebase_storage_file.dart';
import '../../../core/utils/show_snack_bar.dart';
import '../../../inventory/presentation/blocs/items/items_bloc.dart';
import '../../../user_profile/presentation/blocs/user_profile/user_profile_bloc.dart';
import '../../data/models/task/spare_part_item_model.dart';
import '../../data/models/task/task_model.dart';
import '../../data/models/work_request/work_request_model.dart';
import '../../domain/entities/task/task.dart';
import '../../domain/entities/task_priority.dart';
import '../../domain/entities/task_type.dart';
import '../../domain/entities/work_request/work_request.dart';
import '../blocs/task/task_bloc.dart';
import '../blocs/task_management/task_management_bloc.dart';
import '../blocs/task_templates_management/task_templates_management_bloc.dart';
import '../widgets/add_task/add_task_assign_card.dart';
import '../widgets/add_task/add_task_card.dart';
import '../widgets/add_task/add_task_set_cyclic.dart';
import '../widgets/add_task/add_task_spare_part_card.dart';
import '../widgets/add_task/add_task_summary_card.dart';
import '../widgets/add_task/add_task_type_card.dart';
import '../widgets/add_work_request/add_video_card.dart';
import '../widgets/add_work_request/add_work_request_set_asset_card.dart';
import '../widgets/add_work_request/set_asset_status_card.dart';
import '../widgets/add_work_request/set_priority_card.dart';

class AddTaskTemplatePage extends StatefulWidget {
  const AddTaskTemplatePage({Key? key}) : super(key: key);

  static const routeName = '/tasks/add-task-template';

  @override
  State<AddTaskTemplatePage> createState() => _AddTaskTemplatePageState();
}

class _AddTaskTemplatePageState extends State<AddTaskTemplatePage> {
  Task? _task;

  bool _isTemplate = true;

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
  String _durationUnit = '';
  int _duration = 0;

  bool _isAddAssetVisible = false;
  bool _isAddItemVisible = false;
  bool _isConnectedToAsset = false;
  bool _isAddInstructionsVisible = false;
  bool _isAddGroupsVisible = false;
  bool _isAddUsersVisible = false;
  bool _isAddChecklist = false;
  bool _isCyclicTask = false;

  DateTime _date = DateTime.now();
  DateTime _executionDate = DateTime.now();

  List<File> _images = [];
  List<String> _instructions = [];
  List<String> _assignedGroups = [];
  List<String> _assignedUsers = [];

  List<String> _sparePartsAssets = [];
  List<SparePartItemModel> _sparePartsItems = [];
  List<CheckpointModel> _checklist = [];

  File? _videoFile;

  _addNewTask(BuildContext context) {
    String errorMessage = '';
    if (!_formKey.currentState!.validate()) {
      if (_titleTextEditingController.text.trim().length < 2) {
        errorMessage =
            '${AppLocalizations.of(context)!.title} - ${AppLocalizations.of(context)!.validation_min_two_characters}';
      }
    } else {
      // task type validation
      if (errorMessage.isEmpty && _taskType.isEmpty) {
        errorMessage = AppLocalizations.of(context)!.task_type_select;
      }
      // location validation
      if (errorMessage.isEmpty && !_isConnectedToAsset && _locationId.isEmpty) {
        errorMessage =
            AppLocalizations.of(context)!.validation_location_not_selected;
      }
      // asset validation
      if (errorMessage.isEmpty && _isConnectedToAsset && _assetId.isEmpty) {
        errorMessage =
            AppLocalizations.of(context)!.task_connected_asset_select;
      }
      // asset status validation
      if (errorMessage.isEmpty &&
          _isConnectedToAsset &&
          _assetId.isNotEmpty &&
          _assetStatus.isEmpty) {
        errorMessage = AppLocalizations.of(context)!.asset_status_not_selected;
      }
      // cyclic task - duration unit and duration validation
      if (errorMessage.isEmpty &&
          _isCyclicTask &&
          (_durationUnit.isEmpty || _duration == 0)) {
        errorMessage = AppLocalizations.of(context)!.asset_next_inspection_tip;
      }
      // assigned users/groups validation
      if (errorMessage.isEmpty &&
          _assignedUsers.isEmpty &&
          _assignedGroups.isEmpty) {
        errorMessage =
            AppLocalizations.of(context)!.task_assign_groups_or_users_error;
      }
      if (errorMessage.isEmpty && _sparePartsItems.isNotEmpty) {
        for (var item in _sparePartsItems) {
          if (errorMessage.isEmpty && item.quantity <= 0) {
            errorMessage =
                AppLocalizations.of(context)!.item_spare_part_quantity_error;
          }
        }
      }
    }

    // // shows SnackBar if validation error occures
    if (errorMessage.isNotEmpty) {
      showSnackBar(
        context: context,
        message: errorMessage,
        isErrorMessage: true,
      );
      // saves instruction to DB if no error
    } else {
      final newTask = TaskModel(
        id: _task?.id ?? '',
        parentId: _task?.parentId ?? '',
        count: _task?.count ?? 0,
        date: _date,
        executionDate: _executionDate,
        title: _titleTextEditingController.text,
        description: _descriptionTextEditingController.text,
        locationId: _locationId,
        userId: _userId,
        assetId: _assetId,
        workOrderId: '',
        images: const [],
        instructions: _instructions,
        video: '',
        priority: TaskPriority.fromString(_priority),
        type: TaskType.fromString(_taskType),
        assetStatus: AssetStatus.fromString(_assetStatus),
        isFinished: false,
        isCancelled: false,
        isSuccessful: false,
        isInProgress: false,
        isCyclictask: _isCyclicTask,
        durationUnit: DurationUnit.fromString(_durationUnit),
        duration: _duration,
        actions: const [],
        assignedGroups: _assignedGroups,
        assignedUsers: _assignedUsers,
        sparePartsAssets: _sparePartsAssets,
        sparePartsItems: _sparePartsItems,
        checklist: _checklist,
      );

      if (_isTemplate) {
        // add new template
        if (_task == null || _task!.id.isEmpty) {
          context.read<TaskTemplatesManagementBloc>().add(
                AddTaskTemplateEvent(
                  task: newTask,
                  images: _images,
                  video: _videoFile,
                ),
              );
          // update template
        } else {
          context.read<TaskTemplatesManagementBloc>().add(
                UpdateTaskTemplateEvent(
                  task: newTask,
                  images: _images,
                  video: _videoFile,
                ),
              );
        }
      } else {
        // add new task
        context.read<TaskManagementBloc>().add(
              AddTaskEvent(
                task: newTask,
                images: _images,
                video: _videoFile,
              ),
            );
      }

      Navigator.pop(context);
    }
  }

  void _toggleAddInstructionsVisibility() {
    setState(() {
      _isAddInstructionsVisible = !_isAddInstructionsVisible;
    });
  }

  void _toggleAddGroupsVisibility() {
    setState(() {
      _isAddGroupsVisible = !_isAddGroupsVisible;
    });
  }

  void _toggleAddUsersVisibility() {
    setState(() {
      _isAddUsersVisible = !_isAddUsersVisible;
    });
  }

  void _toggleAddChecklistVisibility() {
    setState(() {
      _isAddChecklist = !_isAddChecklist;
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

  void _toggleUserSelection(String user) {
    if (!_assignedUsers.contains(user)) {
      setState(() {
        _assignedUsers.add(user);
        if (_assignedGroups.isNotEmpty) {
          _assignedGroups.clear();
        }
      });
    } else {
      setState(() {
        _assignedUsers.remove(user);
      });
    }
  }

  void _toggleGroupSelection(String group) {
    if (!_assignedGroups.contains(group)) {
      setState(() {
        _assignedGroups.add(group);
        if (_assignedUsers.isNotEmpty) {
          _assignedUsers.clear();
        }
      });
    } else {
      setState(() {
        _assignedGroups.remove(group);
      });
    }
  }

  void _setVideo(File? video) {
    setState(() {
      _videoFile = video;
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

  void _setIsCyclicTask(bool value) {
    if (value) {
      setState(() {
        _isCyclicTask = value;
      });
    } else {
      setState(() {
        _isCyclicTask = value;

        _durationUnit = '';
        _duration = 0;
      });
    }
  }

  void _setExecutionDate(DateTime date) {
    setState(() {
      _executionDate = date;
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

  void _toggleAddItemVisibility() {
    setState(() {
      _isAddItemVisible = !_isAddItemVisible;
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
    List<String> notAssetsSpareParts = [];
    List<String> sparePartsAssets = [];
    List<SparePartItemModel> sparePartsItems = [];
    // update spare parts lists
    final assetState = context.read<AssetBloc>().state;
    if (assetState is AssetLoadedState) {
      // get selected asset
      final selectedAsset = assetState.getAssetById(assetId);
      // add spareparts if list is not empty
      if (selectedAsset != null && selectedAsset.spareParts.isNotEmpty) {
        for (var sparePartId in selectedAsset.spareParts) {
          final sparePartAsset = assetState.getAssetById(sparePartId);
          if (sparePartAsset != null) {
            // add asset type spare part
            sparePartsAssets.add(sparePartId);
          } else {
            // add item type spare parts to separated list
            notAssetsSpareParts.add(sparePartId);
          }
        }
        // if items type spare part list is not empty
        if (notAssetsSpareParts.isNotEmpty) {
          final itemsState = context.read<ItemsBloc>().state;
          if (itemsState is ItemsLoadedState) {
            for (var sparePartId in notAssetsSpareParts) {
              final sparePartItem = itemsState.getItemById(sparePartId);
              if (sparePartItem != null) {
                // add item type spare part
                sparePartsItems.add(
                  SparePartItemModel(
                    itemId: sparePartId,
                    locationId: '',
                    quantity: 0,
                  ),
                );
              }
            }
          }
        }
      }
    }
    setState(() {
      _assetId = assetId;
      _assetStatus = '';
      _sparePartsAssets = sparePartsAssets;
      _sparePartsItems = sparePartsItems;
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
        if (_taskType == TaskType.inspection.name) {
          _taskType = '';
        }
        _isConnectedToAsset = false;
        _assetId = '';
        _locationId = '';
        _assetStatus = '';
        _sparePartsAssets = [];
        _sparePartsItems = [];
      });
    }
  }

  void _toggleAssetSparePartSelection(String assetId) {
    if (_sparePartsAssets.contains(assetId)) {
      setState(() {
        _sparePartsAssets.remove(assetId);
      });
    } else {
      setState(() {
        _sparePartsAssets.add(assetId);
      });
    }
  }

  void _toggleItemSparePartSelection(SparePartItemModel sparePartItemModel) {
    if (_sparePartsItems.contains(sparePartItemModel)) {
      setState(() {
        _sparePartsItems.remove(sparePartItemModel);
      });
    } else {
      setState(() {
        _sparePartsItems.add(sparePartItemModel);
      });
    }
  }

  void _updateSparePartItemModel(String itemId, double quantity) {
    final index = _sparePartsItems.indexWhere((part) => part.itemId == itemId);
    if (index >= 0) {
      setState(() {
        _sparePartsItems.removeAt(index);
        _sparePartsItems.insert(
          index,
          SparePartItemModel(
            itemId: itemId,
            locationId: '',
            quantity: quantity,
          ),
        );
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
      } else if (_isAddItemVisible) {
        _toggleAddItemVisibility();
      } else if (_isAddInstructionsVisible) {
        _toggleAddInstructionsVisibility();
      } else if (_isAddGroupsVisible) {
        _toggleAddGroupsVisibility();
      } else if (_isAddUsersVisible) {
        _toggleAddUsersVisibility();
      } else if (_isAddChecklist) {
        _toggleAddChecklistVisibility();
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
      _durationUnit = _task!.durationUnit.name;
      _duration = _task!.duration;
      _isCyclicTask = _task!.isCyclictask;
      _executionDate = _task!.executionDate;
      _assignedUsers = _task!.assignedUsers;
      _assignedGroups = _task!.assignedGroups;
      _sparePartsAssets = _task!.sparePartsAssets;
      _sparePartsItems = _task!.sparePartsItems;
      _checklist = _task!.checklist;
    }

    // task template use mode
    if (arguments != null &&
        arguments is List &&
        arguments[0] is Task &&
        _task == null) {
      _task = TaskModel.fromTask(arguments[0]).deepCopy();
      _isTemplate = false;

      if (_task!.images.isNotEmpty) {
        fetchImages(_task!.images);
      }
      _titleTextEditingController.text = _task!.title;
      _descriptionTextEditingController.text = _task!.description;
      _locationId = _task!.locationId;
      _priority = _task!.priority.name;
      _date = DateTime.now();
      _assetId = _task!.assetId;
      _assetStatus = _task!.assetStatus.name;
      _isConnectedToAsset = _task!.assetId.isNotEmpty;
      _taskType = _task!.type.name;
      _instructions = _task!.instructions;
      _durationUnit = _task!.durationUnit.name;
      _duration = _task!.duration;
      _isCyclicTask = _task!.isCyclictask;
      _executionDate = DateTime.now();
      _assignedUsers = _task!.assignedUsers;
      _assignedGroups = _task!.assignedGroups;
      _sparePartsAssets = _task!.sparePartsAssets;
      _sparePartsItems = _task!.sparePartsItems;
      _checklist = _task!.checklist;
    }

    // add to asset
    if (arguments != null && arguments is Asset && _task == null) {
      final asset = arguments;

      _locationId = asset.locationId;
      _assetId = asset.id;
      _assetStatus = asset.currentStatus.name;
      _isConnectedToAsset = true;
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
          isTemplate: _isTemplate,
          titleTextEditingController: _titleTextEditingController,
          descriptionTextEditingController: _descriptionTextEditingController,
        ),
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
          videoUrl:
              (_task != null && _task!.video.isNotEmpty) ? _task!.video : null,
          updateVideo: _setVideo,
        ),
      ),
      AddAssetInstructionsCard(
        toggleSelection: _toggleInstructionSelection,
        toggleAddInstructionsVisibility: _toggleAddInstructionsVisibility,
        instructions: _instructions,
        isAddInstructionsVisible: _isAddInstructionsVisible,
      ),
      AddTaskSparePartCard(
        toggleAssetSelection: _toggleAssetSparePartSelection,
        toggleItemSelection: _toggleItemSparePartSelection,
        updateSparePartQuantity: _updateSparePartItemModel,
        toggleAddAssetVisibility: _toggleAddAssetVisibility,
        toggleAddItemVisibility: _toggleAddItemVisibility,
        sparePartsAssets: _sparePartsAssets,
        sparePartsItems: _sparePartsItems,
        isAddAssetVisible: _isAddAssetVisible,
        isAddItemVisible: _isAddItemVisible,
      ),
      AddTaskSetCyclicCard(
        executionDate: _executionDate,
        setExecutionDate: _setExecutionDate,
        isCyclicTask: _isCyclicTask,
        setIsCyclicTask: _setIsCyclicTask,
        durationUnit: _durationUnit,
        setDurationUnit: _setDurationUnit,
        duration: _duration,
        setDuration: _setDuration,
      ),
      AddTaskAssignCard(
        toggleUserSelection: _toggleUserSelection,
        toggleGroupSelection: _toggleGroupSelection,
        toggleAddUsersVisibility: _toggleAddUsersVisibility,
        toggleAddGroupsVisibility: _toggleAddGroupsVisibility,
        assignedUsers: _assignedUsers,
        assignedGroups: _assignedGroups,
        isAddUsersVisible: _isAddUsersVisible,
        isAddGroupsVisible: _isAddGroupsVisible,
      ),
      AddTaskCheckpointsCard(
        checklist: _checklist,
        isAddChecklistVisible: _isAddChecklist,
        toggleAddChecklistVisibility: _toggleAddChecklistVisibility,
      ),
      AddTaskTypeCard(
        setTaskType: _setTaskType,
        taskType: _taskType,
        isConnectedToAsset: _isConnectedToAsset,
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
        video: _videoFile,
        isCyclicTask: _isCyclicTask,
        executionDate: _executionDate,
        durationUnit: _durationUnit,
        duration: _duration,
        assignedGroups: _assignedGroups,
        assignedUsers: _assignedUsers,
        sparePartsAssets: _sparePartsAssets,
        sparePartsItems: _sparePartsItems,
        checklist: _checklist,
      ),
    ];

    DateTime preBackpress = DateTime.now();

    return WillPopScope(
      onWillPop: () async {
        if (_isAddAssetVisible) {
          _toggleAddAssetVisibility();
          return false;
        } else if (_isAddItemVisible) {
          _toggleAddItemVisibility();
          return false;
        } else if (_isAddInstructionsVisible) {
          _toggleAddInstructionsVisibility();
          return false;
        } else if (_isAddGroupsVisible) {
          _toggleAddGroupsVisibility();
          return false;
        } else if (_isAddUsersVisible) {
          _toggleAddUsersVisibility();
          return false;
        } else if (_isAddChecklist) {
          _toggleAddChecklistVisibility();
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
