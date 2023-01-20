import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/usecases/usecase.dart';
import '../../../../user_profile/presentation/blocs/user_profile/user_profile_bloc.dart';
import '../../../data/models/task/tasks_list_model.dart';
import '../../../domain/usecases/task_template/get_tasks_templates_stream.dart';

part 'task_templates_event.dart';
part 'task_templates_state.dart';

@injectable
class TaskTemplatesBloc extends Bloc<TaskTemplatesEvent, TaskTemplatesState> {
  StreamSubscription? _tasksStreamSubscription;
  final UserProfileBloc userProfileBloc;
  final GetTasksTemplatesStream getTasksTemplatesStream;

  TaskTemplatesBloc({
    required this.userProfileBloc,
    required this.getTasksTemplatesStream,
  }) : super(TaskTemplatesEmptyState()) {
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
        print('TaskTemplatesBloc - Loaded');
        emit(TaskTemplatesLoadedState(allTasks: tasksList));
      },
    );
  }

  @override
  Future<void> close() {
    _tasksStreamSubscription?.cancel();
    return super.close();
  }
}
