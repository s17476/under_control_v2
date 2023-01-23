import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../core/error/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../../../tasks/domain/entities/task_action/task_actions_stream.dart';
import '../repositories/task_action_status_repository.dart';

@lazySingleton
class GetLatestTaskActions
    extends FutureUseCase<TaskActionsStream, ItemsInLocationsParams> {
  final TaskActionStatusRepository repository;

  GetLatestTaskActions({
    required this.repository,
  });

  @override
  Future<Either<Failure, TaskActionsStream>> call(
    ItemsInLocationsParams params,
  ) async =>
      repository.getLatestTaskActions(params);
}
