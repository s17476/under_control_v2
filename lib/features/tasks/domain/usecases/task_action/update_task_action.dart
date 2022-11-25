import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../repositories/task_action_repository.dart';

@lazySingleton
class UpdateTaskAction extends FutureUseCase<VoidResult, TaskActionParams> {
  final TaskActionRepository repository;

  UpdateTaskAction({
    required this.repository,
  });

  @override
  Future<Either<Failure, VoidResult>> call(TaskActionParams params) async =>
      repository.updateTaskAction(params);
}
