import 'package:dartz/dartz.dart';

import '../repositories/checklists_repository.dart';
import '../../../core/error/failures.dart';
import '../../../core/usecases/usecase.dart';

class DeleteChecklist extends FutureUseCase<VoidResult, ChecklistParams> {
  final CheckListsRepository repository;

  DeleteChecklist({
    required this.repository,
  });

  @override
  Future<Either<Failure, VoidResult>> call(ChecklistParams params) async =>
      repository.deleteChecklist(params);
}
