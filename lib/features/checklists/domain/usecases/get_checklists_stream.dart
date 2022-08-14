import 'package:dartz/dartz.dart';

import '../../../core/error/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../entities/checklists_stream.dart';
import '../repositories/checklists_repository.dart';

class GetChecklistStream extends FutureUseCase<ChecklistsStream, String> {
  final CheckListsRepository repository;

  GetChecklistStream({
    required this.repository,
  });

  @override
  Future<Either<Failure, ChecklistsStream>> call(String params) async =>
      repository.getChecklistsStream(params);
}
