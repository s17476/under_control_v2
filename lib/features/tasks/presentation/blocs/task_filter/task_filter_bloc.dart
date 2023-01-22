import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../authentication/presentation/blocs/authentication/authentication_bloc.dart';
import '../../../../user_profile/domain/entities/user_profile.dart';
import '../../../../user_profile/presentation/blocs/user_profile/user_profile_bloc.dart';
import '../../../domain/entities/task/task.dart';
import '../../../domain/entities/task_filter_enums.dart';
import '../../../domain/entities/task_priority.dart';
import '../../../domain/entities/task_type.dart';
import '../../../domain/entities/work_request/work_request.dart';
import '../task/task_bloc.dart';
import '../work_request/work_request_bloc.dart';

part 'task_filter_event.dart';
part 'task_filter_state.dart';

@singleton
class TaskFilterBloc extends Bloc<TaskFilterEvent, TaskFilterState> {
  final AuthenticationBloc authenticationBloc;
  final UserProfileBloc userProfileBloc;
  final TaskBloc taskBloc;
  final WorkRequestBloc workRequestBloc;
  late StreamSubscription _authStreamSubscription;
  late StreamSubscription _userStreamSubscription;
  late StreamSubscription _tasksStreamSubscription;
  late StreamSubscription _requestsStreamSubscription;

  UserProfile? _userProfile;
  List<Task>? _allTasks;
  List<WorkRequest>? _allRequests;

  TaskFilterEvent _lastEvent = const TaskFilterResetEvent();

  final double _filterFullHeight = 335;
  final double _filterFullHeightOnlyRequests = 180;
  final double _filterMiniHeight = 180;
  final double _filterMiniHeightOnlyRequests = 113;

  TaskFilterBloc(
    this.authenticationBloc,
    this.userProfileBloc,
    this.taskBloc,
    this.workRequestBloc,
  ) : super(const TaskFilterInitialState()) {
    _authStreamSubscription = authenticationBloc.stream.listen((state) {
      if (state is Unauthenticated) {
        add(ResetEvent());
      }
    });
    userProfileBloc.stream.listen((state) {
      if (state is Approved) {
        _userProfile = state.userProfile;
        if (_allRequests != null && _allTasks != null) {
          add(_lastEvent);
        }
      }
    });
    taskBloc.stream.listen((state) {
      if (state is TaskLoadedState) {
        _allTasks = state.allTasks.allTasks;
        if (_allRequests != null && _userProfile != null) {
          // update state with recent selected options
          add(_lastEvent);
        }
      }
    });
    workRequestBloc.stream.listen((state) {
      if (state is WorkRequestLoadedState) {
        _allRequests = state.allWorkRequests.allWorkRequests;
        if (_allTasks != null && _userProfile != null) {
          // update state with recent selected options
          add(_lastEvent);
        }
      }
    });

    on<ResetEvent>(
      (event, emit) {
        _userProfile = null;
        _allTasks = null;
        _allRequests = null;
        _lastEvent = const TaskFilterResetEvent();
      },
    );

    on<TaskFilterResetEvent>((event, emit) {
      _lastEvent = event;
      emit(TaskFilterNothingSelectedState(
        filterHeight: _filterFullHeight,
        isFilterVisible: state.isFilterVisible,
        isMiniSize: false,
        tasks: _allTasks ?? [],
        workRequests: _allRequests ?? [],
      ));
    });

    on<TaskFilterSelectEvent>((event, emit) {
      _lastEvent = TaskFilterSelectEvent(
        taskOrRequest: event.taskOrRequest ?? _lastEvent.taskOrRequest,
        taskOwner: event.taskOwner ?? _lastEvent.taskOwner,
        taskPriority: event.taskPriority ?? _lastEvent.taskPriority,
        taskType: event.taskType ?? _lastEvent.taskType,
      );
      // nothing is selected
      if (_lastEvent.taskOrRequest == TaskOrRequest.all &&
          _lastEvent.taskOwner == TaskOwner.all &&
          _lastEvent.taskPriority == TaskPriority.unknown &&
          _lastEvent.taskType == TaskType.unknown) {
        emit(TaskFilterNothingSelectedState(
          filterHeight:
              state.isMiniSize ? _filterMiniHeight : _filterFullHeight,
          isFilterVisible: state.isFilterVisible,
          isMiniSize: state.isMiniSize,
          tasks: _allTasks ?? [],
          workRequests: _allRequests ?? [],
        ));
        // options selected
      } else {
        emit(_filterTasks());
      }
    });

    on<TaskFilterShowEvent>((event, emit) {
      TaskFilterState? newState;
      if (state is TaskFilterSelectedState) {
        newState = (state as TaskFilterSelectedState).copyWith(
          isFilterVisible: true,
        );
      } else if (state is TaskFilterNothingSelectedState) {
        newState = (state as TaskFilterNothingSelectedState).copyWith(
          isFilterVisible: true,
        );
      }
      if (newState != null) {
        emit(newState);
      }
    });

    on<TaskFilterHideEvent>((event, emit) {
      TaskFilterState? newState;
      if (state is TaskFilterSelectedState) {
        newState =
            (state as TaskFilterSelectedState).copyWith(isFilterVisible: false);
      } else if (state is TaskFilterNothingSelectedState) {
        newState = (state as TaskFilterNothingSelectedState)
            .copyWith(isFilterVisible: false);
      }
      if (newState != null) {
        emit(newState);
      }
    });

    on<TaskFilterSetMiniSizeEvent>((event, emit) {
      if (!state.isFilterVisible) {
        return;
      }
      TaskFilterState? newState;
      if (state is TaskFilterSelectedState) {
        newState = (state as TaskFilterSelectedState).copyWith(
          filterHeight: state.taskOrRequest == TaskOrRequest.request
              ? _filterMiniHeightOnlyRequests
              : _filterMiniHeight,
          isMiniSize: true,
        );
      } else if (state is TaskFilterNothingSelectedState) {
        newState = (state as TaskFilterNothingSelectedState).copyWith(
          filterHeight: _filterMiniHeight,
          isMiniSize: true,
        );
      }
      if (newState != null) {
        emit(newState);
      }
    });

    on<TaskFilterSetFullSizeEvent>((event, emit) {
      TaskFilterState? newState;
      if (state is TaskFilterSelectedState) {
        newState = (state as TaskFilterSelectedState).copyWith(
          filterHeight: state.taskOrRequest == TaskOrRequest.request
              ? _filterFullHeightOnlyRequests
              : _filterFullHeight,
          isMiniSize: false,
        );
      } else if (state is TaskFilterNothingSelectedState) {
        newState = (state as TaskFilterNothingSelectedState).copyWith(
          filterHeight: _filterFullHeight,
          isMiniSize: false,
        );
      }
      if (newState != null) {
        emit(newState);
      }
    });
  }

  @override
  Future<void> close() {
    _authStreamSubscription.cancel();
    _userStreamSubscription.cancel();
    _tasksStreamSubscription.cancel();
    _requestsStreamSubscription.cancel();
    return super.close();
  }

  TaskFilterState _filterTasks() {
    List<Task> filteredTasks = [];
    List<WorkRequest> filteredRequests = [];

    // task or requests
    switch (_lastEvent.taskOrRequest) {
      case TaskOrRequest.all:
        filteredTasks = _allTasks ?? [];
        filteredRequests = _allRequests ?? [];
        break;
      case TaskOrRequest.request:
        filteredTasks = [];
        filteredRequests = _allRequests ?? [];
        break;
      case TaskOrRequest.task:
        filteredTasks = _allTasks ?? [];
        filteredRequests = [];
        break;
      default:
    }

    // task owner
    if (filteredTasks.isNotEmpty) {
      switch (_lastEvent.taskOwner) {
        // user tasks
        case TaskOwner.user:
          filteredTasks = filteredTasks
              .where(
                (task) => task.assignedUsers.contains(
                  _userProfile!.id,
                ),
              )
              .toList();
          break;
        // groups tasks
        case TaskOwner.group:
          filteredTasks = filteredTasks
              .where(
                (task) => task.assignedGroups.any(
                  (groupId) => _userProfile!.userGroups.contains(
                    groupId,
                  ),
                ),
              )
              .toList();
          break;
        // user and groups tasks
        case TaskOwner.userAndGroup:
          filteredTasks = filteredTasks
              .where(
                (task) =>
                    task.assignedGroups.any(
                      (groupId) => _userProfile!.userGroups.contains(
                        groupId,
                      ),
                    ) ||
                    task.assignedUsers.contains(
                      _userProfile!.id,
                    ),
              )
              .toList();
          break;
        default:
          break;
      }
    }

    // filter priority
    if (_lastEvent.taskPriority != TaskPriority.unknown) {
      filteredTasks = filteredTasks
          .where((task) => task.priority == _lastEvent.taskPriority)
          .toList();
      filteredRequests = filteredRequests
          .where((request) => request.priority == _lastEvent.taskPriority)
          .toList();
    }

    // filter task type
    if (_lastEvent.taskType != TaskType.unknown) {
      filteredTasks = filteredTasks
          .where((task) => task.type == _lastEvent.taskType)
          .toList();
    }

    final isOnlyRequestFilter =
        _lastEvent.taskOrRequest == TaskOrRequest.request;
    double newSize;
    if (isOnlyRequestFilter) {
      if (state.isMiniSize) {
        newSize = _filterMiniHeightOnlyRequests;
      } else {
        newSize = _filterFullHeightOnlyRequests;
      }
    } else {
      if (state.isMiniSize) {
        newSize = _filterMiniHeight;
      } else {
        newSize = _filterFullHeight;
      }
    }

    return TaskFilterSelectedState(
      filterHeight: newSize,
      isFilterVisible: state.isFilterVisible,
      isMiniSize: state.isMiniSize,
      taskOrRequest: _lastEvent.taskOrRequest!,
      taskOwner: _lastEvent.taskOwner!,
      taskPriority: _lastEvent.taskPriority!,
      taskType: _lastEvent.taskType!,
      tasks: filteredTasks,
      workRequests: filteredRequests,
    );
  }
}
