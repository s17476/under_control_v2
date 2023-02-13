import 'package:dartz/dartz.dart';

import '../../../core/error/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../../data/models/work_request/work_request_model.dart';
import '../entities/work_request/work_requests_stream.dart';

abstract class WorkRequestsRepository {
  ///Gets stream of work Requests in selected locations.
  ///
  ///Returns [WorkRequestsStream] if operation is successful.
  ///Returns [Failure] if operation is unsuccessful.
  Future<Either<Failure, WorkRequestsStream>> getWorkRequestsStream(
    ItemsInLocationsParams params,
  );

  ///Gets work request by id.
  ///
  ///Returns [WorkRequestModel] if operation is successful.
  ///Returns [Failure] if operation is unsuccessful.
  Future<Either<Failure, WorkRequestModel>> getWorkRequestById(
    IdParams params,
  );

  ///Gets stream of work Requests from archive in selected locations.
  ///
  ///Returns [WorkRequestsStream] if operation is successful.
  ///Returns [Failure] if operation is unsuccessful.
  Future<Either<Failure, WorkRequestsStream>> getArchiveWorkRequestsStream(
    ItemsInLocationsParams params,
  );

  ///Adds new work Request to the DB.
  ///
  ///Returns [String] containing generated by DB item id.
  ///Returns [Failure] if operation is unsuccessful.
  Future<Either<Failure, String>> addWorkRequest(WorkRequestParams params);

  ///Updates work Request in the DB.
  ///
  ///Returns [VoidResult] if operation is successful.
  ///Returns [Failure] if operation is unsuccessful.
  Future<Either<Failure, VoidResult>> updateWorkRequest(
      WorkRequestParams params);

  ///Deletes work Request from the DB.
  ///
  ///Returns [VoidResult] if operation is successful.
  ///Returns [Failure] if operation is unsuccessful.
  Future<Either<Failure, VoidResult>> deleteWorkRequest(
      WorkRequestParams params);

  ///Cancel work Request and move it to work Requests archive.
  ///
  ///Returns [VoidResult] if operation is successful.
  ///Returns [Failure] if operation is unsuccessful.
  Future<Either<Failure, VoidResult>> cancelWorkRequest(
      WorkRequestParams params);
}
