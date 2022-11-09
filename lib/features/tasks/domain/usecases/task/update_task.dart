import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../repositories/task_repository.dart';

@lazySingleton
class UpdateTask extends FutureUseCase<VoidResult, TaskParams> {
  final TaskRepository repository;

  UpdateTask({
    required this.repository,
  });

  @override
  Future<Either<Failure, VoidResult>> call(TaskParams params) async =>
      repository.updateTask(params);
}
