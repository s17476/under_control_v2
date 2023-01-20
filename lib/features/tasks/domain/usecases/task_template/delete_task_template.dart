import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../repositories/task_templates_repository.dart';

@lazySingleton
class DeleteTaskTemplate extends FutureUseCase<VoidResult, TaskParams> {
  final TaskTemplatesRepository repository;

  DeleteTaskTemplate({
    required this.repository,
  });

  @override
  Future<Either<Failure, VoidResult>> call(TaskParams params) async =>
      repository.deleteTaskTemplate(params);
}
