import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../repositories/task_action_repository.dart';

@lazySingleton
class AddTaskAction extends FutureUseCase<String, TaskActionParams> {
  final TaskActionRepository repository;

  AddTaskAction({
    required this.repository,
  });

  @override
  Future<Either<Failure, String>> call(TaskActionParams params) async =>
      repository.addTaskAction(params);
}
