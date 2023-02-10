import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/usecases/usecase.dart';
import '../../../../user_profile/presentation/blocs/user_profile/user_profile_bloc.dart';
import '../../../data/models/task/task_model.dart';
import '../../../domain/usecases/task/get_task_by_id.dart';

part 'task_state.dart';

@injectable
class TaskCubit extends Cubit<TaskCubitState> {
  final UserProfileBloc userProfileBloc;
  final GetTaskById getTaskByIdUsecase;
  TaskCubit({
    required this.userProfileBloc,
    required this.getTaskByIdUsecase,
  }) : super(TaskCubitEmpty());

  Future<void> getTaskById(String taskId) async {
    final userState = userProfileBloc.state;
    if (userState is Approved) {
      final params = IdParams(
        companyId: userState.userProfile.companyId,
        id: taskId,
      );
      final failureOrTask = await getTaskByIdUsecase(params);
      await failureOrTask.fold(
        (failure) async => emit(TaskCubitError()),
        (task) async => emit(TaskCubitLoaded(task: task)),
      );
    }
  }
}
