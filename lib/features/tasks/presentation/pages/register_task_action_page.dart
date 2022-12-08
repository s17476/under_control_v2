import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../core/presentation/pages/loading_page.dart';
import '../../../core/presentation/widgets/creator_bottom_navigation.dart';
import '../../../core/presentation/widgets/keep_alive_page.dart';
import '../../../core/utils/show_snack_bar.dart';
import '../../../user_profile/presentation/blocs/user_profile/user_profile_bloc.dart';
import '../../data/models/task/task_model.dart';
import '../../domain/entities/task/task.dart';
import '../../domain/entities/task_action/task_action.dart';
import '../blocs/task/task_bloc.dart';
import '../widgets/add_task_action/add_task_action_card.dart';

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

  // pageview
  List<Widget> _pages = [];
  final _pageController = PageController();

  final _formKey = GlobalKey<FormState>();

  final _descriptionTextEditingController = TextEditingController();

  String _userId = '';

  DateTime _startDate = DateTime.now();
  DateTime _stopDate = DateTime.now();

  List<File> _images = [];

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

  @override
  void initState() {
    _pageController.addListener(() {
      FocusScope.of(context).unfocus();
      // if (_isAddAssetVisible) {
      //   _toggleAddAssetVisibility();
      // } else if (_isAddItemVisible) {
      //   _toggleAddItemVisibility();
      // } else if (_isAddInstructionsVisible) {
      //   _toggleAddInstructionsVisibility();
      // } else if (_isAddGroupsVisible) {
      //   _toggleAddGroupsVisibility();
      // } else if (_isAddUsersVisible) {
      //   _toggleAddUsersVisibility();
      // }
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

    // new task action
    if (arguments != null && arguments is Task && _task == null) {
      _task = TaskModel.fromTask(arguments).deepCopy();
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
    ];

    DateTime preBackpress = DateTime.now();

    return WillPopScope(
      onWillPop: () async {
        // if (_isAddAssetVisible) {
        //   _toggleAddAssetVisibility();
        //   return false;
        // } else if (_isAddItemVisible) {
        //   _toggleAddItemVisibility();
        //   return false;
        // } else if (_isAddInstructionsVisible) {
        //   _toggleAddInstructionsVisibility();
        //   return false;
        // } else if (_isAddGroupsVisible) {
        //   _toggleAddGroupsVisibility();
        //   return false;
        // } else if (_isAddUsersVisible) {
        //   _toggleAddUsersVisibility();
        //   return false;
        // }
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
