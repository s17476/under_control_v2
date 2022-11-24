import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

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

@injectable
class TaskFilterBloc extends Bloc<TaskFilterEvent, TaskFilterState> {
  final UserProfileBloc userProfileBloc;
  final TaskBloc taskBloc;
  final WorkRequestBloc workRequestBloc;
  late StreamSubscription userStreamSubscription;
  late StreamSubscription tasksStreamSubscription;
  late StreamSubscription requestsStreamSubscription;

  UserProfile? userProfile;

  List<Task>? allTasks;
  List<WorkRequest>? allRequests;

  TaskFilterEvent lastEvent = const TaskFilterResetEvent();

  final double filterFullHeight = 350;
  final double filterFullHeightOnlyRequests = 200;
  final double filterMiniHeight = 170;
  final double filterMiniHeightOnlyRequests = 90;

  TaskFilterBloc(
    this.userProfileBloc,
    this.taskBloc,
    this.workRequestBloc,
  ) : super(const TaskFilterInitialState()) {
    userProfileBloc.stream.listen((state) {
      if (state is Approved) {
        userProfile = state.userProfile;
        if (allRequests != null && allTasks != null) {
          add(lastEvent);
        }
      }
    });
    taskBloc.stream.listen((state) {
      if (state is TaskLoadedState) {
        allTasks = state.allTasks.allTasks;
        if (allRequests != null && userProfile != null) {
          // update state with recent selected options
          add(lastEvent);
        }
      }
    });
    workRequestBloc.stream.listen((state) {
      if (state is WorkRequestLoadedState) {
        allRequests = state.allWorkRequests.allWorkRequests;
        if (allTasks != null && userProfile != null) {
          // update state with recent selected options
          add(lastEvent);
        }
      }
    });

    on<TaskFilterResetEvent>((event, emit) {
      lastEvent = event;
      emit(TaskFilterNothingSelectedState(
        filterHeight: filterFullHeight,
        isFilterVisible: state.isFilterVisible,
        isMiniSize: state.isMiniSize,
        tasks: allTasks ?? [],
        workRequests: allRequests ?? [],
      ));
    });

    on<TaskFilterSelectEvent>((event, emit) {
      lastEvent = TaskFilterSelectEvent(
        taskOrRequest: event.taskOrRequest ?? lastEvent.taskOrRequest,
        taskOwner: event.taskOwner ?? lastEvent.taskOwner,
        taskPriority: event.taskPriority ?? lastEvent.taskPriority,
        taskType: event.taskType ?? lastEvent.taskType,
      );
      // nothing is selected
      if (lastEvent.taskOrRequest == TaskOrRequest.all &&
          lastEvent.taskOwner == TaskOwner.all &&
          lastEvent.taskPriority == TaskPriority.unknown &&
          lastEvent.taskType == TaskType.unknown) {
        emit(TaskFilterNothingSelectedState(
          filterHeight: state.isMiniSize ? filterMiniHeight : filterFullHeight,
          isFilterVisible: state.isFilterVisible,
          isMiniSize: state.isMiniSize,
          tasks: allTasks ?? [],
          workRequests: allRequests ?? [],
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
          filterHeight: filterFullHeight,
          isFilterVisible: true,
          isMiniSize: false,
        );
      } else if (state is TaskFilterNothingSelectedState) {
        newState = (state as TaskFilterNothingSelectedState).copyWith(
          filterHeight: filterFullHeight,
          isFilterVisible: true,
          isMiniSize: false,
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
      TaskFilterState? newState;
      if (state is TaskFilterSelectedState) {
        newState = (state as TaskFilterSelectedState).copyWith(
          filterHeight: filterMiniHeight,
          isMiniSize: true,
        );
      } else if (state is TaskFilterNothingSelectedState) {
        newState = (state as TaskFilterNothingSelectedState).copyWith(
          filterHeight: filterMiniHeight,
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
          filterHeight: filterFullHeight,
          isMiniSize: false,
        );
      } else if (state is TaskFilterNothingSelectedState) {
        newState = (state as TaskFilterNothingSelectedState).copyWith(
          filterHeight: filterFullHeight,
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
    userStreamSubscription.cancel();
    tasksStreamSubscription.cancel();
    requestsStreamSubscription.cancel();
    return super.close();
  }

  TaskFilterState _filterTasks() {
    List<Task> filteredTasks = [];
    List<WorkRequest> filteredRequests = [];

    // task or requests
    switch (lastEvent.taskOrRequest) {
      case TaskOrRequest.all:
        filteredTasks = allTasks ?? [];
        filteredRequests = allRequests ?? [];
        break;
      case TaskOrRequest.request:
        filteredTasks = [];
        filteredRequests = allRequests ?? [];
        break;
      case TaskOrRequest.task:
        filteredTasks = allTasks ?? [];
        filteredRequests = [];
        break;
      default:
    }

    // task owner
    if (filteredTasks.isNotEmpty) {
      switch (lastEvent.taskOwner) {
        // user tasks
        case TaskOwner.user:
          filteredTasks = filteredTasks
              .where(
                (task) => task.assignedUsers.contains(
                  userProfile!.id,
                ),
              )
              .toList();
          break;
        // groups tasks
        case TaskOwner.group:
          filteredTasks = filteredTasks
              .where(
                (task) => task.assignedGroups.any(
                  (groupId) => userProfile!.userGroups.contains(
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
                      (groupId) => userProfile!.userGroups.contains(
                        groupId,
                      ),
                    ) ||
                    task.assignedUsers.contains(
                      userProfile!.id,
                    ),
              )
              .toList();
          break;
        default:
          break;
      }
    }

    // filter priority
    if (lastEvent.taskPriority != TaskPriority.unknown) {
      filteredTasks = filteredTasks
          .where((task) => task.priority == lastEvent.taskPriority)
          .toList();
      filteredRequests = filteredRequests
          .where((request) => request.priority == lastEvent.taskPriority)
          .toList();
    }

    // filter task type
    if (lastEvent.taskType != TaskType.unknown) {
      filteredTasks = filteredTasks
          .where((task) => task.type == lastEvent.taskType)
          .toList();
    }

    final isOnlyRequestFilter =
        lastEvent.taskOrRequest == TaskOrRequest.request;
    double newSize;
    if (isOnlyRequestFilter) {
      if (state.isMiniSize) {
        newSize = filterMiniHeightOnlyRequests;
      } else {
        newSize = filterFullHeightOnlyRequests;
      }
    } else {
      if (state.isMiniSize) {
        newSize = filterMiniHeight;
      } else {
        newSize = filterFullHeight;
      }
    }

    return TaskFilterSelectedState(
      filterHeight: newSize,
      isFilterVisible: state.isFilterVisible,
      isMiniSize: state.isMiniSize,
      taskOrRequest: lastEvent.taskOrRequest!,
      taskOwner: lastEvent.taskOwner!,
      taskPriority: lastEvent.taskPriority!,
      taskType: lastEvent.taskType!,
      tasks: filteredTasks,
      workRequests: filteredRequests,
    );
  }
}
