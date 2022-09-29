import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../core/error/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../entities/instructions_stream.dart';
import '../repositories/instruction_repository.dart';

@lazySingleton
class GetInstructionsStream
    extends FutureUseCase<InstructionsStream, InstructionsInLocationsParams> {
  final InstructionRepository repository;

  GetInstructionsStream({
    required this.repository,
  });

  @override
  Future<Either<Failure, InstructionsStream>> call(
    InstructionsInLocationsParams params,
  ) async =>
      repository.getInstructionsStream(params);
}
