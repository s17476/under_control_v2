import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../repositories/work_request_repository.dart';

@lazySingleton
class AddWorkRequest extends FutureUseCase<String, WorkRequestParams> {
  final WorkRequestsRepository repository;

  AddWorkRequest({
    required this.repository,
  });

  @override
  Future<Either<Failure, String>> call(WorkRequestParams params) async =>
      repository.addWorkRequest(params);
}
