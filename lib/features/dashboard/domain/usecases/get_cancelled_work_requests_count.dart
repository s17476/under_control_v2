import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../core/error/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../../../tasks/domain/entities/work_request/work_requests_stream.dart';
import '../repositories/work_request_status_repository.dart';

@lazySingleton
class GetCancelledWorkRequestsCount
    extends FutureUseCase<WorkRequestsStream, ItemsInLocationsParams> {
  final WorkRequestsStatusRepository repository;

  GetCancelledWorkRequestsCount({
    required this.repository,
  });

  @override
  Future<Either<Failure, WorkRequestsStream>> call(
    ItemsInLocationsParams params,
  ) async =>
      repository.getCancelledWorkRequestsCount(params);
}
