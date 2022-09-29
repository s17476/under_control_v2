import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:under_control_v2/features/core/error/failures.dart';
import 'package:under_control_v2/features/core/usecases/usecase.dart';
import 'package:under_control_v2/features/knowledge_base/domain/entities/instruction.dart';
import 'package:under_control_v2/features/knowledge_base/domain/repositories/instruction_repository.dart';
import 'package:under_control_v2/features/knowledge_base/domain/usecases/delete_instruction.dart';

class MockInstructionRepository extends Mock implements InstructionRepository {}

void main() {
  late DeleteInstruction usecase;
  late MockInstructionRepository repository;

  const tInstructionParams = InstructionParams(
    instruction: Instruction(
      id: 'id',
      name: 'name',
      description: 'description',
      category: 'category',
      steps: [],
      locations: [],
      userId: 'userId',
      lastEdited: [],
      isPublished: true,
    ),
    companyId: 'companyId',
  );

  setUpAll(() {
    registerFallbackValue(tInstructionParams);
  });

  setUp(() {
    repository = MockInstructionRepository();
    usecase = DeleteInstruction(repository: repository);
  });

  group('Knowledge Base', () {
    test(
      'should return [String] from repository when DeleteInstruction is called',
      () async {
        // arrange
        when(() => repository.deleteInstruction(any()))
            .thenAnswer((_) async => Right(VoidResult()));
        // act
        final result = await usecase(tInstructionParams);
        // assert
        expect(result, isA<Right<Failure, VoidResult>>());
      },
    );
  });
}
