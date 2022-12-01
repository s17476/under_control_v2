import 'package:dartz/dartz.dart';

import '../../../core/error/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../entities/task_action/task_actions_stream.dart';

abstract class TaskActionRepository {
  ///Gets stream of task actions for selected task.
  ///
  ///Returns [TaskActionsStream] if operation is successful.
  ///Returns [Failure] if operation is unsuccessful.
  Future<Either<Failure, TaskActionsStream>> getTaskActionsForTaskStream(
    TaskParams params,
  );

  ///Gets stream of latest five task actions.
  ///
  ///Returns [TaskActionsStream] if operation is successful.
  ///Returns [Failure] if operation is unsuccessful.
  Future<Either<Failure, TaskActionsStream>> getLatestTaskActionsStream(
    NoParams params,
  );

  ///Adds new task action to the DB.
  ///
  ///Returns [String] containing generated by DB item id.
  ///Returns [Failure] if operation is unsuccessful.
  Future<Either<Failure, String>> addTaskAction(TaskActionParams params);

  ///Update task action in the DB.
  ///
  ///Returns [VoidResult] if operation is successful.
  ///Returns [Failure] if operation is unsuccessful.
  Future<Either<Failure, VoidResult>> updateTaskAction(TaskActionParams params);

  ///Delete task action in the DB.
  ///
  ///Returns [VoidResult] if operation is successful.
  ///Returns [Failure] if operation is unsuccessful.
  Future<Either<Failure, VoidResult>> deleteTaskAction(TaskActionParams params);
}