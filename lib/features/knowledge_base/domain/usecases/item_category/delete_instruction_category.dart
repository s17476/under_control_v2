import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../repositories/instruction_category_repository.dart';

@lazySingleton
class DeleteInstructionCategory
    extends FutureUseCase<VoidResult, InstructionCategoryParams> {
  final InstructionCategoryRepository repository;

  DeleteInstructionCategory({
    required this.repository,
  });

  @override
  Future<Either<Failure, VoidResult>> call(
          InstructionCategoryParams params) async =>
      repository.deleteInstructionCategory(params);
}
