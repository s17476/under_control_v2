import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:under_control_v2/features/core/error/failures.dart';
import 'package:under_control_v2/features/core/usecases/usecase.dart';
import 'package:under_control_v2/features/knowledge_base/domain/entities/instructions_stream.dart';
import 'package:under_control_v2/features/knowledge_base/domain/repositories/instruction_repository.dart';
import 'package:under_control_v2/features/knowledge_base/domain/usecases/get_instructions_stream.dart';

class MockInstructionRepository extends Mock implements InstructionRepository {}

void main() {
  late GetInstructionsStream usecase;
  late MockInstructionRepository repository;

  const tInstructionsInLocationsParams = InstructionsInLocationsParams(
    locations: [],
    companyId: 'companyId',
  );

  setUpAll(() {
    registerFallbackValue(tInstructionsInLocationsParams);
  });

  setUp(() {
    repository = MockInstructionRepository();
    usecase = GetInstructionsStream(repository: repository);
  });

  group('Knowledge Base', () {
    test(
      'should return [String] from repository when GetInstructionsStream is called',
      () async {
        // arrange
        when(() => repository.getInstructionsStream(any())).thenAnswer(
            (_) async => Right(
                InstructionsStream(allInstructions: Stream.fromIterable([]))));
        // act
        final result = await usecase(tInstructionsInLocationsParams);
        // assert
        expect(result, isA<Right<Failure, InstructionsStream>>());
      },
    );
  });
}
