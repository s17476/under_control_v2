import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../core/error/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../repositories/instruction_repository.dart';

@lazySingleton
class AddInstruction extends FutureUseCase<String, InstructionParams> {
  final InstructionRepository repository;

  AddInstruction({
    required this.repository,
  });

  @override
  Future<Either<Failure, String>> call(InstructionParams params) async =>
      repository.addInstruction(params);
}
