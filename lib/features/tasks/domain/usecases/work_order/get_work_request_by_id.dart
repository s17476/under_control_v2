import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../data/models/work_request/work_request_model.dart';
import '../../repositories/work_request_repository.dart';

@lazySingleton
class GetWorkRequestById extends FutureUseCase<WorkRequestModel, IdParams> {
  final WorkRequestsRepository repository;

  GetWorkRequestById({
    required this.repository,
  });

  @override
  Future<Either<Failure, WorkRequestModel>> call(
    IdParams params,
  ) async =>
      repository.getWorkRequestById(params);
}
