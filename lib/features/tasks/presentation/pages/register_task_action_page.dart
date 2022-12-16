import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:under_control_v2/features/tasks/data/models/task_action/user_action_model.dart';
import 'package:under_control_v2/features/tasks/presentation/blocs/reserved_spare_parts/reserved_spare_parts_bloc.dart';
import 'package:under_control_v2/features/tasks/presentation/widgets/add_task_action/add_task_action_add_participants_card.dart';
import 'package:under_control_v2/features/tasks/presentation/widgets/add_task_action/add_task_action_spare_part_card.dart';

import '../../../assets/presentation/widgets/add_asset/add_asset_images_card.dart';
import '../../../core/presentation/pages/loading_page.dart';
import '../../../core/presentation/widgets/creator_bottom_navigation.dart';
import '../../../core/presentation/widgets/keep_alive_page.dart';
import '../../../core/utils/get_cached_firebase_storage_file.dart';
import '../../../core/utils/show_snack_bar.dart';
import '../../../user_profile/presentation/blocs/user_profile/user_profile_bloc.dart';
import '../../data/models/task/spare_part_item_model.dart';
import '../../data/models/task/task_model.dart';
import '../../domain/entities/task/task.dart';
import '../../domain/entities/task_action/task_action.dart';
import '../blocs/task/task_bloc.dart';
import '../widgets/add_task_action/add_task_action_card.dart';
import 'subtract_item_from_location_page.dart';

class RegisterTaskActionPage extends StatefulWidget {
  const RegisterTaskActionPage({Key? key}) : super(key: key);

  static const routeName = '/tasks/register-task-action';

  @override
  State<RegisterTaskActionPage> createState() => _RegisterTaskActionPageState();
}

class _RegisterTaskActionPageState extends State<RegisterTaskActionPage> {
  TaskAction? _taskAction;
  Task? _task;

  bool _loadingImages = false;
  bool _isAddItemVisible = false;

  // pageview
  List<Widget> _pages = [];
  final _pageController = PageController();

  final _formKey = GlobalKey<FormState>();

  final _descriptionTextEditingController = TextEditingController();

  String _userId = '';

  DateTime _startTime = DateTime.now().subtract(Duration(minutes: 5));
  DateTime _stopTime = DateTime.now();

  List<UserActionModel> _participants = [];

  List<File> _images = [];
  List<SparePartItemModel> _sparePartsItems = [];

  bool _isAddUsersVisible = false;

  _addNewTaskAction(BuildContext context) {
    // String errorMessage = '';
    // if (!_formKey.currentState!.validate()) {
    //   if (_titleTextEditingController.text.trim().length < 2) {
    //     errorMessage =
    //         '${AppLocalizations.of(context)!.title} - ${AppLocalizations.of(context)!.validation_min_two_characters}';
    //   }
    // } else {
    //   // task type validation
    //   if (errorMessage.isEmpty && _taskType.isEmpty) {
    //     errorMessage = AppLocalizations.of(context)!.task_type_select;
    //   }
    //   // location validation
    //   if (errorMessage.isEmpty && !_isConnectedToAsset && _locationId.isEmpty) {
    //     errorMessage =
    //         AppLocalizations.of(context)!.validation_location_not_selected;
    //   }
    //   // asset validation
    //   if (errorMessage.isEmpty && _isConnectedToAsset && _assetId.isEmpty) {
    //     errorMessage =
    //         AppLocalizations.of(context)!.task_connected_asset_select;
    //   }
    //   // asset status validation
    //   if (errorMessage.isEmpty &&
    //       _isConnectedToAsset &&
    //       _assetId.isNotEmpty &&
    //       _assetStatus.isEmpty) {
    //     errorMessage = AppLocalizations.of(context)!.asset_status_not_selected;
    //   }
    //   // cyclic task - duration unit and duration validation
    //   if (errorMessage.isEmpty &&
    //       _isCyclicTask &&
    //       (_durationUnit.isEmpty || _duration == 0)) {
    //     errorMessage = AppLocalizations.of(context)!.asset_next_inspection_tip;
    //   }
    //   // assigned users/groups validation
    //   if (errorMessage.isEmpty &&
    //       _assignedUsers.isEmpty &&
    //       _assignedGroups.isEmpty) {
    //     errorMessage =
    //         AppLocalizations.of(context)!.task_assign_groups_or_users_error;
    //   }
    //   if (errorMessage.isEmpty && _sparePartsItems.isNotEmpty) {
    //     for (var item in _sparePartsItems) {
    //       if (errorMessage.isEmpty && item.quantity <= 0) {
    //         errorMessage =
    //             AppLocalizations.of(context)!.item_spare_part_quantity_error;
    //       }
    //     }
    //   }
    // }

    // // // shows SnackBar if validation error occures
    // if (errorMessage.isNotEmpty) {
    //   showSnackBar(
    //     context: context,
    //     message: errorMessage,
    //     isErrorMessage: true,
    //   );
    //   // saves instruction to DB if no error
    // } else {
    //   final newTask = TaskModel(
    //     id: _task?.id ?? '',
    //     parentId: _task?.parentId ?? '',
    //     count: _task?.count ?? 0,
    //     date: _date,
    //     executionDate: _executionDate,
    //     title: _titleTextEditingController.text,
    //     description: _descriptionTextEditingController.text,
    //     locationId: _locationId,
    //     userId: _userId,
    //     assetId: _assetId,
    //     workOrderId: _workRequest?.id ?? '',
    //     images: const [],
    //     instructions: _instructions,
    //     video: '',
    //     priority: TaskPriority.fromString(_priority),
    //     type: TaskType.fromString(_taskType),
    //     assetStatus: AssetStatus.fromString(_assetStatus),
    //     isFinished: false,
    //     isCancelled: false,
    //     isSuccessful: false,
    //     isInProgress: false,
    //     isCyclictask: _isCyclicTask,
    //     durationUnit: DurationUnit.fromString(_durationUnit),
    //     duration: _duration,
    //     actions: const [],
    //     assignedGroups: _assignedGroups,
    //     assignedUsers: _assignedUsers,
    //     sparePartsAssets: _sparePartsAssets,
    //     sparePartsItems: _sparePartsItems,
    //   );

    //   // add new task
    //   if (_task == null || _task!.id.isEmpty) {
    //     context.read<TaskManagementBloc>().add(
    //           AddTaskEvent(
    //             task: newTask,
    //             images: _images,
    //             video: _videoFile,
    //           ),
    //         );
    //     // update task
    //   } else {
    //     context.read<TaskManagementBloc>().add(
    //           UpdateTaskEvent(
    //             task: newTask,
    //             images: _images,
    //             video: _videoFile,
    //           ),
    //         );
    //   }

    //   Navigator.pop(context);
    // }
  }

  // TODO: update start/stop times

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

  void _updateParticipant(UserActionModel userActionModel) {
    final index = _participants
        .indexWhere((element) => element.userId == userActionModel.userId);
    if (index >= 0) {
      setState(() {
        _participants.removeAt(index);
        _participants.insert(index, userActionModel);
      });
    }
  }

  void _toggleParticipantSelection(String userId) {
    final index =
        _participants.indexWhere((element) => element.userId == userId);
    if (index >= 0) {
      setState(() {
        _participants.removeAt(index);
      });
    } else {
      final userAction = UserActionModel(
          userId: userId, startTime: _startTime, stopTime: _stopTime);
      setState(() {
        _participants.add(userAction);
      });
    }
  }

  void _toggleAddUsersVisibility() {
    setState(() {
      _isAddUsersVisible = !_isAddUsersVisible;
    });
  }

  void _addItem(SparePartItemModel sparePartItemModel) async {
    final result = await Navigator.pushNamed(
      context,
      SubtractItemFromLocationPage.routeName,
      arguments: sparePartItemModel,
    );
    if (result is SparePartItemModel) {
      setState(() {
        _sparePartsItems.add(result);
      });
      if (mounted) {
        context.read<ReservedSparePartsBloc>().add(
              ReservedSparePartsUpdateEvent(spareParts: _sparePartsItems),
            );
      }
    }
  }

  void _removeItem(SparePartItemModel sparePartItemModel) {
    setState(() {
      _sparePartsItems.remove(sparePartItemModel);
    });
    if (mounted) {
      context.read<ReservedSparePartsBloc>().add(
            ReservedSparePartsUpdateEvent(spareParts: _sparePartsItems),
          );
    }
  }

  void _updateSparePartItemModel(SparePartItemModel item) {
    final index = _sparePartsItems.indexWhere((part) => part == item);
    if (index >= 0) {
      setState(() {
        _sparePartsItems.removeAt(index);
        _sparePartsItems.insert(
          index,
          item,
        );
      });
      if (mounted) {
        context.read<ReservedSparePartsBloc>().add(
              ReservedSparePartsUpdateEvent(spareParts: _sparePartsItems),
            );
      }
    }
  }

  void _toggleAddItemVisibility() {
    setState(() {
      _isAddItemVisible = !_isAddItemVisible;
    });
  }

  @override
  void initState() {
    context.read<ReservedSparePartsBloc>().add(
          ReservedSparePartsResetEvent(),
        );
    _pageController.addListener(() {
      FocusScope.of(context).unfocus();
      // if (_isAddAssetVisible) {
      //   _toggleAddAssetVisibility();
      // } else
      if (_isAddItemVisible) {
        _toggleAddItemVisibility();
      } else
      //if (_isAddInstructionsVisible) {
      //   _toggleAddInstructionsVisibility();
      // } else if (_isAddGroupsVisible) {
      //   _toggleAddGroupsVisibility();
      // } else
      if (_isAddUsersVisible) {
        _toggleAddUsersVisibility();
      }
    });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // final TODO: get spare parts assets
    final userState = context.watch<UserProfileBloc>().state;
    if (_participants.isEmpty && userState is Approved) {
      _userId = userState.userProfile.id;
      _participants.add(
        UserActionModel(
          userId: _userId,
          startTime: _startTime,
          stopTime: _stopTime,
        ),
      );
    }

    final arguments = ModalRoute.of(context)!.settings.arguments;

    // new task action
    if (arguments != null && arguments is Task && _task == null) {
      _task = TaskModel.fromTask(arguments).deepCopy();

      _sparePartsItems = _task!.sparePartsItems;
    }

    // TODO: add edit case

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _descriptionTextEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _pages = [
      KeepAlivePage(
        child: AddTaskActionCard(
          isEditMode: _taskAction != null,
          descriptionTextEditingController: _descriptionTextEditingController,
        ),
      ),
      AddTaskActionAddParticipantsCard(
        toggleParticipantSelection: _toggleParticipantSelection,
        updateParticipant: _updateParticipant,
        toggleIsAddUserVisible: _toggleAddUsersVisibility,
        participants: _participants,
        isAddUsersVisible: _isAddUsersVisible,
      ),
      AddAssetImagesCard(
        addImage: _addImage,
        removeImage: _removeImage,
        images: _images,
        loading: _loadingImages,
      ),
      AddTaskActionSparePartCard(
        addItem: _addItem,
        removeItem: _removeItem,
        updateSparePartQuantity: _updateSparePartItemModel,
        toggleAddItemVisibility: _toggleAddItemVisibility,
        sparePartsItems: _sparePartsItems,
        isAddItemVisible: _isAddItemVisible,
      ),
      // if(_task!.assetId.isNotEmpty)
// TODO: get spare part assets
    ];

    DateTime preBackpress = DateTime.now();

    return WillPopScope(
      onWillPop: () async {
        // if (_isAddAssetVisible) {
        //   _toggleAddAssetVisibility();
        //   return false;
        // } else
        if (_isAddItemVisible) {
          _toggleAddItemVisibility();
          return false;
        }
        //else if (_isAddInstructionsVisible) {
        //   _toggleAddInstructionsVisibility();
        //   return false;
        // } else if (_isAddGroupsVisible) {
        //   _toggleAddGroupsVisibility();
        //   return false;
        // } else
        if (_isAddUsersVisible) {
          _toggleAddUsersVisibility();
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
          context.read<ReservedSparePartsBloc>().add(
                ReservedSparePartsResetEvent(),
              );
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
                    lastPageForwardButtonFunction: () =>
                        _addNewTaskAction(context),
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
