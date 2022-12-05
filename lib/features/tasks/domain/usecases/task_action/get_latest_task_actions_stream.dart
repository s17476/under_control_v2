import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../entities/task_action/task_actions_stream.dart';
import '../../repositories/task_action_repository.dart';

@lazySingleton
class GetLatestTaskActionsStream
    extends FutureUseCase<TaskActionsStream, ItemsInLocationsParams> {
  final TaskActionRepository repository;

  GetLatestTaskActionsStream({
    required this.repository,
  });

  @override
  Future<Either<Failure, TaskActionsStream>> call(
    ItemsInLocationsParams params,
  ) async =>
      repository.getLatestTaskActionsStream(params);
}
