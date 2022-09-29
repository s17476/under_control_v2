import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:under_control_v2/features/core/error/failures.dart';
import 'package:under_control_v2/features/core/usecases/usecase.dart';
import 'package:under_control_v2/features/knowledge_base/domain/entities/instruction_category/instruction_category.dart';
import 'package:under_control_v2/features/knowledge_base/domain/repositories/instruction_category_repository.dart';
import 'package:under_control_v2/features/knowledge_base/domain/usecases/item_category/add_instruction_category.dart';

class MockInstructionCategoryRepository extends Mock
    implements InstructionCategoryRepository {}

void main() {
  late AddInstructionCategory usecase;
  late MockInstructionCategoryRepository repository;

  const tInstructionCategoryParams = InstructionCategoryParams(
    instructionCategory: InstructionCategory(
      id: 'id',
      name: 'name',
    ),
    companyId: 'companyId',
  );

  setUpAll(() {
    registerFallbackValue(tInstructionCategoryParams);
  });

  setUp(() {
    repository = MockInstructionCategoryRepository();
    usecase = AddInstructionCategory(repository: repository);
  });

  group('Knowledge Base', () {
    test(
      'should return [String] from repository when AddInstructionCategory is called',
      () async {
        // arrange
        when(() => repository.addInstructionCategory(any()))
            .thenAnswer((_) async => const Right(''));
        // act
        final result = await usecase(tInstructionCategoryParams);
        // assert
        expect(result, isA<Right<Failure, String>>());
      },
    );
  });
}
