import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../repositories/instruction_category_repository.dart';

@lazySingleton
class AddInstructionCategory extends FutureUseCase<String, CategoryParams> {
  final InstructionCategoryRepository repository;

  AddInstructionCategory({
    required this.repository,
  });

  @override
  Future<Either<Failure, String>> call(CategoryParams params) async =>
      repository.addInstructionCategory(params);
}
