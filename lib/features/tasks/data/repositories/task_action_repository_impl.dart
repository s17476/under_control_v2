import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:under_control_v2/features/tasks/domain/entities/task_action/task_actions_stream.dart';
import 'package:under_control_v2/features/core/usecases/usecase.dart';
import 'package:under_control_v2/features/core/error/failures.dart';

import '../../domain/repositories/task_action_repository.dart';

@LazySingleton(as: TaskActionRepository)
class TaskActionRepositoryImpl extends TaskActionRepository {
  @override
  Future<Either<Failure, String>> addTaskAction(TaskActionParams params) {
    // TODO: implement addTaskAction
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, VoidResult>> deleteTaskAction(
      TaskActionParams params) {
    // TODO: implement deleteTaskAction
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, TaskActionsStream>> getLatestTaskActionsStream(
      NoParams params) {
    // TODO: implement getLatestTaskActionsStream
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, TaskActionsStream>> getTaskActionsForTaskStream(
      TaskParams params) {
    // TODO: implement getTaskActionsForTaskStream
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, VoidResult>> updateTaskAction(
      TaskActionParams params) {
    // TODO: implement updateTaskAction
    throw UnimplementedError();
  }
}
