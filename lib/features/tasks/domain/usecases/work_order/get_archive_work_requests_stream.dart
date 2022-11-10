import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../entities/work_request/work_requests_stream.dart';
import '../../repositories/work_request_repository.dart';

@lazySingleton
class GetArchiveWorkRequestsStream
    extends FutureUseCase<WorkRequestsStream, ItemsInLocationsParams> {
  final WorkRequestsRepository repository;

  GetArchiveWorkRequestsStream({
    required this.repository,
  });

  @override
  Future<Either<Failure, WorkRequestsStream>> call(
    ItemsInLocationsParams params,
  ) async =>
      repository.getArchiveWorkRequestsStream(params);
}
