import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../repositories/task_repository.dart';

@lazySingleton
class CompleteTask extends FutureUseCase<VoidResult, TaskParams> {
  final TaskRepository repository;

  CompleteTask({
    required this.repository,
  });

  @override
  Future<Either<Failure, VoidResult>> call(TaskParams params) async =>
      repository.completeTask(params);
}
