import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:under_control_v2/features/core/error/failures.dart';
import 'package:under_control_v2/features/core/usecases/usecase.dart';
import 'package:under_control_v2/features/knowledge_base/data/models/instruction_model.dart';
import 'package:under_control_v2/features/knowledge_base/domain/entities/instruction.dart';
import 'package:under_control_v2/features/knowledge_base/domain/repositories/instruction_repository.dart';
import 'package:under_control_v2/features/knowledge_base/domain/usecases/add_instruction.dart';

class MockInstructionRepository extends Mock implements InstructionRepository {}

void main() {
  late AddInstruction usecase;
  late MockInstructionRepository repository;

  const tInstructionParams = InstructionParams(
    instruction: InstructionModel(
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
    usecase = AddInstruction(repository: repository);
  });

  group('Knowledge Base', () {
    test(
      'should return [String] from repository when AddInstruction is called',
      () async {
        // arrange
        when(() => repository.addInstruction(any()))
            .thenAnswer((_) async => const Right(''));
        // act
        final result = await usecase(tInstructionParams);
        // assert
        expect(result, isA<Right<Failure, String>>());
      },
    );
  });
}
