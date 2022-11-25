import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../entities/task_action/task_actions_stream.dart';
import '../../repositories/task_action_repository.dart';

@lazySingleton
class GetTaskActionsStream
    extends FutureUseCase<TaskActionsStream, TaskParams> {
  final TaskActionRepository repository;

  GetTaskActionsStream({
    required this.repository,
  });

  @override
  Future<Either<Failure, TaskActionsStream>> call(
    TaskParams params,
  ) async =>
      repository.getTaskActionsForTaskStream(params);
}
