import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../data/models/task/task_model.dart';
import '../../repositories/task_repository.dart';

@lazySingleton
class GetTaskById extends FutureUseCase<TaskModel, IdParams> {
  final TaskRepository repository;

  GetTaskById({
    required this.repository,
  });

  @override
  Future<Either<Failure, TaskModel>> call(
    IdParams params,
  ) async =>
      repository.getTaskById(params);
}
