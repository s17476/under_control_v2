import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:under_control_v2/features/core/error/failures.dart';
import 'package:under_control_v2/features/core/usecases/usecase.dart';
import 'package:under_control_v2/features/knowledge_base/domain/entities/instruction_category/instruction_category.dart';
import 'package:under_control_v2/features/knowledge_base/domain/entities/instruction_category/instructions_categories_stream.dart';
import 'package:under_control_v2/features/knowledge_base/domain/repositories/instruction_category_repository.dart';
import 'package:under_control_v2/features/knowledge_base/domain/usecases/item_category/get_instructions_categories_stream.dart';

class MockInstructionCategoryRepository extends Mock
    implements InstructionCategoryRepository {}

void main() {
  late GetInstructionsCategoriesStream usecase;
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
    usecase = GetInstructionsCategoriesStream(repository: repository);
  });

  group('Knowledge Base', () {
    test(
      'should return [VoidResult] from repository when GetInstructionsCategoriesStream is called',
      () async {
        // arrange
        when(() => repository.getInstructionsCategoriesStream(any()))
            .thenAnswer((_) async => Right(InstructionsCategoriesStream(
                allInstructionsCategories: Stream.fromIterable([]))));
        // act
        final result = await usecase('companyId');
        // assert
        expect(result, isA<Right<Failure, InstructionsCategoriesStream>>());
      },
    );
  });
}
