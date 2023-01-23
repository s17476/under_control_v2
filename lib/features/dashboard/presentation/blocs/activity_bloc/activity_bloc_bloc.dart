import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';

import '../../../../authentication/presentation/blocs/authentication/authentication_bloc.dart';
import '../../../../tasks/domain/entities/task/task.dart';
import '../../../../tasks/domain/entities/task_action/task_action.dart';
import '../../../../tasks/domain/entities/work_request/work_request.dart';
import '../../../../tasks/presentation/blocs/task/task_bloc.dart';
import '../../../../tasks/presentation/blocs/task_archive/task_archive_bloc.dart';
import '../../../../tasks/presentation/blocs/work_request/work_request_bloc.dart';
import '../../../../tasks/presentation/blocs/work_request_archive/work_request_archive_bloc.dart';
import '../task_actions_status/task_actions_status_bloc.dart';

part 'activity_bloc_event.dart';
part 'activity_bloc_state.dart';

@singleton
class ActivityBloc extends Bloc<ActivityBlocEvent, ActivityBlocState> {
  final AuthenticationBloc authenticationBloc;
  final WorkRequestBloc workRequestBloc;
  final WorkRequestArchiveBloc workRequestArchiveBloc;
  final TaskBloc taskBloc;
  final TaskArchiveBloc taskArchiveBloc;
  final TaskActionsStatusBloc taskActionsStatusBloc;

  late StreamSubscription _authStreamSubscription;
  late StreamSubscription _workRequestStreamSubscription;
  late StreamSubscription _workRequestArchiveStreamSubscription;
  late StreamSubscription _taskStreamSubscription;
  late StreamSubscription _taskArchiveStreamSubscription;
  late StreamSubscription _taskActionStatusStreamSubscription;

  final _startDate = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  ).subtract(
    const Duration(days: 30),
  );

  ActivityBloc({
    required this.authenticationBloc,
    required this.workRequestBloc,
    required this.workRequestArchiveBloc,
    required this.taskBloc,
    required this.taskArchiveBloc,
    required this.taskActionsStatusBloc,
  }) : super(ActivityBlocState.empty()) {
    _authStreamSubscription = authenticationBloc.stream.listen((state) {
      if (state is Unauthenticated) {
        add(ResetEvent());
      }
    });
    _workRequestStreamSubscription = workRequestBloc.stream.listen((state) {
      if (state is WorkRequestLoadedState) {
        add(
          UpdateWorkRequestsEvent(
            workRequests: state.allWorkRequests.allWorkRequests
                .where((element) => element.date.isAfter(_startDate))
                .toList(),
          ),
        );
      }
    });
    _workRequestArchiveStreamSubscription =
        workRequestArchiveBloc.stream.listen((state) {
      if (state is WorkRequestArchiveLoadedState) {
        add(
          UpdateWorkRequestsArchiveEvent(
            workRequests: state.allWorkRequests.allWorkRequests
                .where((element) => element.date.isAfter(_startDate))
                .toList(),
          ),
        );
      }
    });
    _taskStreamSubscription = taskBloc.stream.listen((state) {
      if (state is TaskLoadedState) {
        add(
          UpdateTasksEvent(
            tasks: state.allTasks.allTasks
                .where((element) => element.date.isAfter(_startDate))
                .toList(),
          ),
        );
      }
    });
    _taskArchiveStreamSubscription = taskArchiveBloc.stream.listen((state) {
      if (state is TaskArchiveLoadedState) {
        add(
          UpdateTasksArchiveEvent(
            tasks: state.allTasks.allTasks
                .where((element) => element.executionDate.isAfter(_startDate))
                .toList(),
          ),
        );
      }
    });
    _taskActionStatusStreamSubscription =
        taskActionsStatusBloc.stream.listen((state) {
      if (state is TaskActionsStatusLoadedState) {
        add(
          UpdateTaskActionsEvent(
            taskActions: state.taskActions.allTaskActions
                .where((element) => element.stopTime.isAfter(_startDate))
                .toList(),
          ),
        );
      }
    });

    on<ResetEvent>(
      (event, emit) {
        emit(ActivityBlocState.empty());
      },
    );

    on<UpdateWorkRequestsEvent>(
      (event, emit) => emit(
        state.copyWith(
          workRequests: event.workRequests,
          isLoading: false,
        ),
      ),
    );
    on<UpdateWorkRequestsArchiveEvent>(
      (event, emit) => emit(
        state.copyWith(
          workRequestsArchive: event.workRequests,
          isLoading: false,
        ),
      ),
    );
    on<UpdateTasksEvent>(
      (event, emit) => emit(
        state.copyWith(
          tasks: event.tasks,
          isLoading: false,
        ),
      ),
    );
    on<UpdateTasksArchiveEvent>(
      (event, emit) => emit(
        state.copyWith(
          tasksArchive: event.tasks,
          isLoading: false,
        ),
      ),
    );
    on<UpdateTaskActionsEvent>(
      (event, emit) => emit(
        state.copyWith(
          taskActions: event.taskActions,
          isLoading: false,
        ),
      ),
    );
  }

  @override
  Future<void> close() {
    _authStreamSubscription.cancel();
    _workRequestStreamSubscription.cancel();
    _workRequestArchiveStreamSubscription.cancel();
    _taskStreamSubscription.cancel();
    _taskArchiveStreamSubscription.cancel();
    _taskActionStatusStreamSubscription.cancel();
    return super.close();
  }
}
