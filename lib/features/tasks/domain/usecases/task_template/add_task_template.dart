import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../repositories/task_templates_repository.dart';

@lazySingleton
class AddTaskTemplate extends FutureUseCase<String, TaskParams> {
  final TaskTemplatesRepository repository;

  AddTaskTemplate({
    required this.repository,
  });

  @override
  Future<Either<Failure, String>> call(TaskParams params) async =>
      repository.addTaskTemplate(params);
}
