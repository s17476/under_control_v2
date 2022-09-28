import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../repositories/instruction_category_repository.dart';

@lazySingleton
class AddInstructionCategory
    extends FutureUseCase<String, InstructionCategoryParams> {
  final InstructionCategoryRepository repository;

  AddInstructionCategory({
    required this.repository,
  });

  @override
  Future<Either<Failure, String>> call(
          InstructionCategoryParams params) async =>
      repository.addInstructionCategory(params);
}
