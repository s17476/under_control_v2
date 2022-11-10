import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../repositories/work_request_repository.dart';

@lazySingleton
class CancelWorkRequest extends FutureUseCase<VoidResult, WorkRequestParams> {
  final WorkRequestsRepository repository;

  CancelWorkRequest({
    required this.repository,
  });

  @override
  Future<Either<Failure, VoidResult>> call(WorkRequestParams params) async =>
      repository.cancelWorkRequest(params);
}
