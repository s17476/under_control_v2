import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../repositories/checklists_repository.dart';
import '../../../core/error/failures.dart';
import '../../../core/usecases/usecase.dart';

@lazySingleton
class AddChecklist extends FutureUseCase<String, ChecklistParams> {
  final CheckListsRepository repository;

  AddChecklist({
    required this.repository,
  });

  @override
  Future<Either<Failure, String>> call(ChecklistParams params) async =>
      repository.addChecklist(params);
}
