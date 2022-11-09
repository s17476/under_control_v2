import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../repositories/task_repository.dart';

@lazySingleton
class AddTask extends FutureUseCase<String, TaskParams> {
  final TaskRepository repository;

  AddTask({
    required this.repository,
  });

  @override
  Future<Either<Failure, String>> call(TaskParams params) async =>
      repository.addTask(params);
}
