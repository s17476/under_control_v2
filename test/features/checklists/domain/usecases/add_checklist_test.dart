import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:under_control_v2/features/checklists/domain/entities/checklist.dart';
import 'package:under_control_v2/features/checklists/domain/repositories/checklists_repository.dart';
import 'package:under_control_v2/features/checklists/domain/usecases/add_checklist.dart';
import 'package:under_control_v2/features/core/error/failures.dart';
import 'package:under_control_v2/features/core/usecases/usecase.dart';

class MockChecklistsRepository extends Mock implements CheckListsRepository {}

void main() {
  late AddChecklist usecase;
  late MockChecklistsRepository repository;

  const tChecklist = Checklist(title: 'title', allCheckPoints: []);

  setUpAll(() {
    registerFallbackValue(const ChecklistParams(
      checklist: tChecklist,
      companyId: 'companyId',
    ));
  });

  setUp(() {
    repository = MockChecklistsRepository();
    usecase = AddChecklist(repository: repository);
  });
  test(
    'Checklists should return [String] from repository when add checklist usecase is called',
    () async {
      // arrange
      when(
        () => repository.addChecklist(any()),
      ).thenAnswer((_) async => const Right(''));

      // act
      final result = await usecase(
        const ChecklistParams(
          checklist: tChecklist,
          companyId: 'companyId',
        ),
      );
      // assert
      verify(
        () => repository.addChecklist(
          const ChecklistParams(
            checklist: tChecklist,
            companyId: 'companyId',
          ),
        ),
      );
      verifyNoMoreInteractions(repository);
      expect(result, isA<Right<Failure, String>>());
    },
  );
}
