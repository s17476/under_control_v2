import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../entities/task/tasks_stream.dart';
import '../../repositories/task_repository.dart';

@lazySingleton
class GetArchiveLatestTasksStream
    extends FutureUseCase<TasksStream, ItemsInLocationsParams> {
  final TaskRepository repository;

  GetArchiveLatestTasksStream({
    required this.repository,
  });

  @override
  Future<Either<Failure, TasksStream>> call(
    ItemsInLocationsParams params,
  ) async =>
      repository.getArchiveLatestTasksStream(params);
}
