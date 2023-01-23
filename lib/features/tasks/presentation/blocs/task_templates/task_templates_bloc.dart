import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:under_control_v2/features/authentication/presentation/blocs/authentication/authentication_bloc.dart';

import '../../../../core/usecases/usecase.dart';
import '../../../../user_profile/presentation/blocs/user_profile/user_profile_bloc.dart';
import '../../../data/models/task/tasks_list_model.dart';
import '../../../domain/entities/task/task.dart';
import '../../../domain/usecases/task_template/get_tasks_templates_stream.dart';

part 'task_templates_event.dart';
part 'task_templates_state.dart';

@lazySingleton
class TaskTemplatesBloc extends Bloc<TaskTemplatesEvent, TaskTemplatesState> {
  final AuthenticationBloc authenticationBloc;
  final UserProfileBloc userProfileBloc;
  final GetTasksTemplatesStream getTasksTemplatesStream;

  late StreamSubscription _authStreamSubscription;
  StreamSubscription? _tasksStreamSubscription;

  TaskTemplatesBloc({
    required this.authenticationBloc,
    required this.userProfileBloc,
    required this.getTasksTemplatesStream,
  }) : super(TaskTemplatesEmptyState()) {
    _authStreamSubscription = authenticationBloc.stream.listen((state) {
      if (state is Unauthenticated) {
        add(ResetEvent());
      }
    });

    on<ResetEvent>(
      (event, emit) {
        _tasksStreamSubscription?.cancel();
        emit(TaskTemplatesEmptyState());
      },
    );

    on<GetTaskTemplatesEvent>((event, emit) async {
      final userState = userProfileBloc.state;
      if (userState is Approved) {
        emit(TaskTemplatesLoadingState());

        final failureOrTasksStream = await getTasksTemplatesStream(
          IdParams(
            id: '',
            companyId: userState.userProfile.companyId,
          ),
        );
        await failureOrTasksStream.fold(
            (failure) async =>
                emit(TaskTemplatesErrorState(message: failure.message)),
            (tasksStream) async {
          _tasksStreamSubscription = tasksStream.allTasks.listen((snapshot) {
            add(UpdateTaskTemplatesListEvent(snapshot: snapshot));
          });
        });
      }
    });

    on<UpdateTaskTemplatesListEvent>(
      (event, emit) async {
        emit(TaskTemplatesLoadingState());
        final tasksList = TasksListModel.fromSnapshot(
          event.snapshot as QuerySnapshot<Map<String, dynamic>>,
        );
        emit(TaskTemplatesLoadedState(allTasks: tasksList));
      },
    );
  }

  @override
  Future<void> close() {
    _authStreamSubscription.cancel();
    _tasksStreamSubscription?.cancel();
    return super.close();
  }
}
