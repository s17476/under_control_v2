import 'package:dartz/dartz.dart';

import '../../../core/error/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../../../tasks/domain/entities/work_request/work_requests_stream.dart';

abstract class WorkRequestsStatusRepository {
  ///Gets count of Work Requests in selected locations in last 30 days.
  ///
  ///Returns [WorkRequestsStream] if operation is successful.
  ///Returns [Failure] if operation is unsuccessful.
  Future<Either<Failure, WorkRequestsStream>> getAwaitingWorkRequestsCount(
    ItemsInLocationsParams params,
  );

  ///Gets count of Work Requests converted to tasks in selected locations in last 30 days.
  ///
  ///Returns [WorkRequestsStream] if operation is successful.
  ///Returns [Failure] if operation is unsuccessful.
  Future<Either<Failure, WorkRequestsStream>> getConvertedWorkRequestsCount(
    ItemsInLocationsParams params,
  );

  ///Gets count of cancelled Work Requests selected locations in last 30 days.
  ///
  ///Returns [WorkRequestsStream] if operation is successful.
  ///Returns [Failure] if operation is unsuccessful.
  Future<Either<Failure, WorkRequestsStream>> getCancelledWorkRequestsCount(
    ItemsInLocationsParams params,
  );
}
