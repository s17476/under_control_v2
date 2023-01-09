import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:under_control_v2/features/tasks/data/models/task_action/task_action_model.dart';
import 'package:under_control_v2/features/tasks/presentation/blocs/task_action_management/task_action_management_bloc.dart';
import 'package:under_control_v2/features/tasks/presentation/widgets/add_task_action/add_task_action_summary_card.dart';
import 'package:under_control_v2/features/tasks/presentation/widgets/add_work_request/set_asset_status_card.dart';

import '../../../assets/data/models/asset_model.dart';
import '../../../assets/presentation/blocs/asset/asset_bloc.dart';
import '../../../assets/presentation/blocs/asset_parts/asset_parts_bloc.dart';
import '../../../assets/presentation/widgets/add_asset/add_asset_images_card.dart';
import '../../../assets/utils/asset_status.dart';
import '../../../core/presentation/pages/loading_page.dart';
import '../../../core/presentation/widgets/creator_bottom_navigation.dart';
import '../../../core/presentation/widgets/keep_alive_page.dart';
import '../../../core/utils/get_cached_firebase_storage_file.dart';
import '../../../core/utils/show_snack_bar.dart';
import '../../../user_profile/presentation/blocs/user_profile/user_profile_bloc.dart';
import '../../data/models/task/spare_part_item_model.dart';
import '../../data/models/task/task_model.dart';
import '../../data/models/task_action/user_action_model.dart';
import '../../domain/entities/task/task.dart';
import '../../domain/entities/task_action/task_action.dart';
import '../blocs/reserved_spare_parts/reserved_spare_parts_bloc.dart';
import '../blocs/task/task_bloc.dart';
import '../blocs/task_action/task_action_bloc.dart';
import '../widgets/add_task_action/add_task_action_add_participants_card.dart';
import '../widgets/add_task_action/add_task_action_add_spare_part_card.dart';
import '../widgets/add_task_action/add_task_action_card.dart';
import '../widgets/add_task_action/add_task_action_remove_asset_card.dart';
import '../widgets/add_task_action/add_task_action_spare_part_card.dart';
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
  bool _isAddAssetVisible = false;
  bool _isAddUsersVisible = false;

  // pageview
  List<Widget> _pages = [];
  final _pageController = PageController();

  final _formKey = GlobalKey<FormState>();

  final _descriptionTextEditingController = TextEditingController();

  String _userId = '';

  DateTime _startTime = DateTime.now().subtract(const Duration(minutes: 5));
  DateTime _stopTime = DateTime.now();

  final List<UserActionModel> _participants = [];

  List<File> _images = [];
  final List<SparePartItemModel> _sparePartsItems = [];
  final List<AssetModel> _removedPartsAssets = [];
  final List<String> _addedPartsAssets = [];

  AssetModel? _replacedAsset;
  AssetModel? _replacementAsset;

  AssetStatus? _assetStatus;

  _addNewTaskAction(BuildContext context) {
    String errorMessage = '';
    if (!_formKey.currentState!.validate()) {
      if (_descriptionTextEditingController.text.trim().length < 2) {
        errorMessage =
            '${AppLocalizations.of(context)!.description} - ${AppLocalizations.of(context)!.validation_min_two_characters}';
      }
    } else {
      // participants list validation
      if (errorMessage.isEmpty) {
        if (_participants.isEmpty) {
          errorMessage = AppLocalizations.of(context)!
              .task_action_add_participants_no_selected;
        } else {
          //validate duration - min. 5 minutes
          Duration totalDuration = const Duration();
          for (var participant in _participants) {
            if (participant.totalTime.inMinutes < 5) {
              errorMessage = AppLocalizations.of(context)!
                  .task_action_user_duration_to_short;
            }
            totalDuration +=
                participant.stopTime.difference(participant.startTime);
          }
          if (totalDuration.inMinutes < 5) {
            errorMessage =
                AppLocalizations.of(context)!.task_action_duration_to_short;
          }
        }
      }
      // connected asset replacement validation
      // if connected asset is replaced, replacement asset has to be added
      if (errorMessage.isEmpty &&
          _replacedAsset != null &&
          _replacementAsset == null) {
        errorMessage =
            AppLocalizations.of(context)!.task_action_replaced_asset_err;
      }
      // set new asset status if it has not been replaced
      if (errorMessage.isEmpty && _replacedAsset == null) {
        if (_assetStatus == null ||
            _assetStatus == AssetStatus.unknown ||
            _assetStatus == AssetStatus.disposed ||
            _assetStatus == AssetStatus.noInspection) {
          errorMessage =
              AppLocalizations.of(context)!.asset_status_not_selected;
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
      // saves instruction to DB if no error
    } else {
      final taskAction = TaskActionModel(
        id: '',
        taskId: _task!.id,
        replacedAssetStatus: _replacedAsset?.currentStatus ?? _assetStatus!,
        replacedAssetLocationId: _replacedAsset?.locationId ?? '',
        replacementAssetId: _replacementAsset?.id ?? '',
        comment: _descriptionTextEditingController.text,
        startTime: _startTime,
        stopTime: _stopTime,
        images: const [],
        removedPartsAssets: _removedPartsAssets,
        addedPartsAssets: _addedPartsAssets,
        sparePartsItems: _sparePartsItems,
        usersActions: _participants,
      );

      if (_taskAction == null) {
        context.read<TaskActionManagementBloc>().add(
              AddTaskActionEvent(
                taskAction: taskAction,
                task: _task!,
                images: _images,
              ),
            );
      } else {
        context.read<TaskActionManagementBloc>().add(
              UpdateTaskActionEvent(
                taskAction: taskAction,
                task: _task!,
                images: _images,
              ),
            );
      }

      Navigator.pop(context);
    }
  }

  void _toggleReplaceConnectedAsset(AssetModel asset) {
    if (_replacedAsset != null) {
      setState(() {
        _replacedAsset = null;
        _replacementAsset = null;
      });
    } else {
      setState(() {
        _replacedAsset = asset;
      });
    }
  }

  void _toggleReplacementAsset(AssetModel? asset) {
    setState(() {
      _replacementAsset = asset;
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

  void _fetchImages(List<String> urls) async {
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

  void _updateStartAndStopTime() {
    DateTime? minTime;
    DateTime? maxTime;
    for (var participant in _participants) {
      if (minTime == null || minTime.isAfter(participant.startTime)) {
        minTime = participant.startTime;
      }
      if (maxTime == null || maxTime.isBefore(participant.stopTime)) {
        maxTime = participant.stopTime;
      }
    }
    if (minTime != null && maxTime != null) {
      _startTime = minTime;
      _stopTime = maxTime;
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
      _updateStartAndStopTime();
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
    _updateStartAndStopTime();
  }

  void _toggleRemovedAsset(AssetModel asset) {
    if (_removedPartsAssets.map((e) => e.id).contains(asset.id)) {
      setState(() {
        _removedPartsAssets.removeWhere(
          (element) => element.id == asset.id,
        );
      });
    } else {
      setState(() {
        _removedPartsAssets.add(asset);
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

  void _toggleAddAssetVisibility() {
    setState(() {
      _isAddAssetVisible = !_isAddAssetVisible;
    });
  }

  void _toggleAssetSelection(String assetId) {
    if (_addedPartsAssets.contains(assetId)) {
      setState(() {
        _addedPartsAssets.remove(assetId);
      });
    } else {
      setState(() {
        _addedPartsAssets.add(assetId);
      });
    }
  }

  void _setStatus(String newStatus) {
    setState(() {
      _assetStatus = AssetStatus.fromString(newStatus);
    });
  }

  @override
  void initState() {
    context.read<ReservedSparePartsBloc>().add(
          ReservedSparePartsResetEvent(),
        );
    _pageController.addListener(() {
      FocusScope.of(context).unfocus();
      if (_isAddAssetVisible) {
        _toggleAddAssetVisibility();
      } else if (_isAddItemVisible) {
        _toggleAddItemVisibility();
      } else if (_isAddUsersVisible) {
        _toggleAddUsersVisibility();
      }
    });
    super.initState();
  }

  @override
  void didChangeDependencies() {
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
      if (_task!.assetId.isNotEmpty) {
        context.read<AssetPartsBloc>().add(
              GetAssetsForParentEvent(
                parentAssetId: _task!.assetId,
              ),
            );
        final assetState = context.watch<AssetBloc>().state;
        if (assetState is AssetLoadedState) {
          final asset = assetState.getAssetById(_task!.assetId);
          _assetStatus = asset?.currentStatus;
        }
      }
    }

    if (arguments != null && arguments is TaskAction && _taskAction == null) {
      _taskAction = TaskActionModel.fromTaskAction(arguments).deepCopy();
      final tasksState = context.read<TaskBloc>().state;
      if (tasksState is TaskLoadedState) {
        _task = tasksState.getTaskById(_taskAction!.taskId);
        if (_task != null && _task!.assetId.isNotEmpty) {
          context.read<AssetPartsBloc>().add(
                GetAssetsForParentEvent(
                  parentAssetId: _task!.assetId,
                ),
              );
        }
      }
      _descriptionTextEditingController.text = _taskAction!.comment;
      _participants.addAll(_taskAction!.usersActions);
      _fetchImages(_taskAction!.images);
      _sparePartsItems.addAll(_taskAction!.sparePartsItems);
      _removedPartsAssets.addAll(_taskAction!.removedPartsAssets);
      _addedPartsAssets.addAll(_taskAction!.addedPartsAssets);

      _updateStartAndStopTime();

      if (_task!.assetId.isNotEmpty) {
        final assetsState = context.watch<AssetBloc>().state;
        if (assetsState is AssetLoadedState) {
          if (_taskAction!.replacedAssetLocationId.isNotEmpty) {
            final replacedAsset = assetsState.getAssetById(_task!.assetId);
            if (replacedAsset != null) {
              _replacedAsset = AssetModel.fromAsset(replacedAsset);
            }
            final replacementAsset =
                assetsState.getAssetById(_taskAction!.replacementAssetId);
            if (replacementAsset != null) {
              _replacementAsset = AssetModel.fromAsset(replacementAsset);
            }
          }
        }
      }
    }

    // final assetPartsState = context.watch<AssetPartsBloc>().state;

    // if (_task != null && _task!.assetId.isNotEmpty) {
    //   _hasChildrenAssets = assetPartsState is AssetPartsLoadedState &&
    //       assetPartsState.parentId == _task!.assetId &&
    //       assetPartsState.allAssetParts.allAssets.isNotEmpty;
    // } else {
    //   _hasChildrenAssets = false;
    // }
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
      if (_task!.assetId.isNotEmpty)
        AddTaskActionRemoveAssetCard(
          assetsToRemove: _removedPartsAssets,
          toggleRemovedAssets: _toggleRemovedAsset,
          replaceConnectedAssets: _toggleReplaceConnectedAsset,
          connectedAssetId: _task!.assetId,
          replacedAsset: _replacedAsset,
        ),
      AddTaskActionAddSparePartCard(
        toggleAssetSelection: _toggleAssetSelection,
        toggleAddAssetVisibility: _toggleAddAssetVisibility,
        sparePartsAssets: _addedPartsAssets,
        isAddAssetVisible: _isAddAssetVisible,
        replacementAsset: _replacementAsset,
        isConnectedAssetReplaced: _replacedAsset != null,
        toggleReplacementAsset: _toggleReplacementAsset,
      ),
      if (_assetStatus != null && _replacedAsset == null)
        SetAssetStatusCard(
            setStatus: _setStatus, assetStatus: _assetStatus!.name),
      AddTaskActionSummaryCard(
        pageController: _pageController,
        descriptionTextEditingController: _descriptionTextEditingController,
        startTime: _startTime,
        stopTime: _stopTime,
        participants: _participants,
        images: _images,
        removedPartsAssets: _removedPartsAssets,
        addedPartsAssets: _addedPartsAssets,
        sparePartsItems: _sparePartsItems,
        replacedAsset: _replacedAsset,
        replacementAsset: _replacementAsset,
        assetStatus: _assetStatus,
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
        } else if (_isAddUsersVisible) {
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
