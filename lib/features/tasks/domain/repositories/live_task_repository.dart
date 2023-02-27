import 'package:dartz/dartz.dart';

import '../../../core/error/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../entities/task_action/task_action_stream.dart';

abstract class LiveTaskActionRepository {
  ///Gets stream of live taskAction.
  ///
  ///Returns [TaskActionStream] if operation is successful.
  ///Returns [Failure] if operation is unsuccessful.
  Future<Either<Failure, TaskActionStream>> getLiveTaskAction(IdParams params);

  ///Updates live taskAction.
  ///
  ///Returns [VoidResult] if operation is successful.
  ///Returns [Failure] if operation is unsuccessful.
  Future<Either<Failure, VoidResult>> updateLiveTaskAction(
    TaskActionParams params,
  );

  ///Deletes live taskAction.
  ///
  ///Returns [VoidResult] if operation is successful.
  ///Returns [Failure] if operation is unsuccessful.
  Future<Either<Failure, VoidResult>> deleteLiveTaskAction(IdParams params);

  ///Complete taskAction.
  ///
  ///Returns [VoidResult] if operation is successful.
  ///Returns [Failure] if operation is unsuccessful.
  Future<Either<Failure, VoidResult>> completeTaskAction(
    TaskActionParams params,
  );
}
