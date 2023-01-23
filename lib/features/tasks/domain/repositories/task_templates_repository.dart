import 'package:dartz/dartz.dart';

import '../../../core/error/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../entities/task/tasks_stream.dart';

abstract class TaskTemplatesRepository {
  ///Gets stream of task templates.
  ///
  ///Returns [TasksStream] if operation is successful.
  ///Returns [Failure] if operation is unsuccessful.
  Future<Either<Failure, TasksStream>> getTasksTemplatesStream(
    IdParams params,
  );

  ///Adds new task template to the DB.
  ///
  ///Returns [String] containing generated by DB item id.
  ///Returns [Failure] if operation is unsuccessful.
  Future<Either<Failure, String>> addTaskTemplate(TaskParams params);

  ///Updates task in the DB.
  ///
  ///Returns [VoidResult] if operation is successful.
  ///Returns [Failure] if operation is unsuccessful.
  Future<Either<Failure, VoidResult>> updateTaskTemplate(TaskParams params);

  ///Deletes task from the DB.
  ///
  ///Returns [VoidResult] if operation is successful.
  ///Returns [Failure] if operation is unsuccessful.
  Future<Either<Failure, VoidResult>> deleteTaskTemplate(TaskParams params);
}