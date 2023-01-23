import 'package:dartz/dartz.dart';

import '../../../core/error/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../../../tasks/domain/entities/task_action/task_actions_stream.dart';

abstract class TaskActionStatusRepository {
  ///Gets TaskActions in selected locations in last 30 days.
  ///
  ///Returns [TaskActionsStream] if operation is successful.
  ///Returns [Failure] if operation is unsuccessful.
  Future<Either<Failure, TaskActionsStream>> getLatestTaskActions(
    ItemsInLocationsParams params,
  );
}
