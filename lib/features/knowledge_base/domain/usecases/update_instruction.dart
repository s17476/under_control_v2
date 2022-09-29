import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../core/error/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../repositories/instruction_repository.dart';

@lazySingleton
class UpdateInstruction extends FutureUseCase<VoidResult, InstructionParams> {
  final InstructionRepository repository;

  UpdateInstruction({
    required this.repository,
  });

  @override
  Future<Either<Failure, VoidResult>> call(InstructionParams params) async =>
      repository.updateInstruction(params);
}
