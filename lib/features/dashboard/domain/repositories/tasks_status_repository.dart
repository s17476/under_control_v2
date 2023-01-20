import 'package:dartz/dartz.dart';

import '../../../core/error/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../../../tasks/domain/entities/task/tasks_stream.dart';

abstract class TasksStatusRepository {
  ///Gets count of successfully finished Tasks in selected locations in last 30 days.
  ///
  ///Returns [TasksStream] if operation is successful.
  ///Returns [Failure] if operation is unsuccessful.
  Future<Either<Failure, TasksStream>> getSuccessfulTasks(
    ItemsInLocationsParams params,
  );

  ///Gets count of unsuccessfully finished Tasks in selected locations in last 30 days.
  ///
  ///Returns [TasksStream] if operation is successful.
  ///Returns [Failure] if operation is unsuccessful.
  Future<Either<Failure, TasksStream>> getUnsuccessfulTasks(
    ItemsInLocationsParams params,
  );

  ///Gets count of cancelled Tasks selected locations in last 30 days.
  ///
  ///Returns [TasksStream] if operation is successful.
  ///Returns [Failure] if operation is unsuccessful.
  Future<Either<Failure, TasksStream>> getCancelledTasks(
    ItemsInLocationsParams params,
  );
}
