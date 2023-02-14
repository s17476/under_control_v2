import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../entities/task/tasks_stream.dart';
import '../../repositories/task_repository.dart';

@lazySingleton
class GetArchiveTasksStreamForAsset
    extends FutureUseCase<TasksStream, IdParams> {
  final TaskRepository repository;

  GetArchiveTasksStreamForAsset({
    required this.repository,
  });

  @override
  Future<Either<Failure, TasksStream>> call(
    IdParams params,
  ) async =>
      repository.getArchiveTasksForAsset(params);
}
