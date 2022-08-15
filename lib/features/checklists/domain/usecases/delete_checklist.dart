import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../repositories/checklists_repository.dart';
import '../../../core/error/failures.dart';
import '../../../core/usecases/usecase.dart';

@lazySingleton
class DeleteChecklist extends FutureUseCase<VoidResult, ChecklistParams> {
  final CheckListsRepository repository;

  DeleteChecklist({
    required this.repository,
  });

  @override
  Future<Either<Failure, VoidResult>> call(ChecklistParams params) async =>
      repository.deleteChecklist(params);
}
