import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../repositories/work_request_repository.dart';

@lazySingleton
class UpdateWorkRequest extends FutureUseCase<VoidResult, WorkRequestParams> {
  final WorkRequestsRepository repository;

  UpdateWorkRequest({
    required this.repository,
  });

  @override
  Future<Either<Failure, VoidResult>> call(WorkRequestParams params) async =>
      repository.updateWorkRequest(params);
}
