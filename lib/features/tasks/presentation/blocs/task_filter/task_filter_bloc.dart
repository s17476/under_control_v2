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
      if (lastEvent == const TaskFilterResetEvent()) {
        emit(TaskFilterNothingSelectedState(
          tasks: allTasks ?? [],
          workRequests: allRequests ?? [],
        ));
        // options selected
      } else {
        emit(_filterTasks());
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

    return TaskFilterSelectedState(
      taskOrRequest: lastEvent.taskOrRequest!,
      taskOwner: lastEvent.taskOwner!,
      taskPriority: lastEvent.taskPriority!,
      taskType: lastEvent.taskType!,
      tasks: filteredTasks,
      workRequests: filteredRequests,
    );
  }
}
