import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../entities/instruction_category/instructions_categories_stream.dart';
import '../../repositories/instruction_category_repository.dart';

@lazySingleton
class GetInstructionsCategoriesStream
    extends FutureUseCase<InstructionsCategoriesStream, String> {
  final InstructionCategoryRepository repository;

  GetInstructionsCategoriesStream({
    required this.repository,
  });

  @override
  Future<Either<Failure, InstructionsCategoriesStream>> call(
    String params,
  ) async =>
      repository.getInstructionsCategoriesStream(params);
}
