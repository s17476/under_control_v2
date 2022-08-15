import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:under_control_v2/features/checklists/domain/entities/checklist.dart';
import 'package:under_control_v2/features/checklists/domain/repositories/checklists_repository.dart';
import 'package:under_control_v2/features/checklists/domain/usecases/add_checklist.dart';
import 'package:under_control_v2/features/checklists/domain/usecases/update_checklist.dart';
import 'package:under_control_v2/features/core/error/failures.dart';
import 'package:under_control_v2/features/core/usecases/usecase.dart';

class MockChecklistsRepository extends Mock implements CheckListsRepository {}

void main() {
  late UpdateChecklist usecase;
  late MockChecklistsRepository repository;

  const tChecklist = Checklist(id: 'id', title: 'title', allCheckpoints: []);

  setUpAll(() {
    registerFallbackValue(const ChecklistParams(
      checklist: tChecklist,
      companyId: 'companyId',
    ));
  });

  setUp(() {
    repository = MockChecklistsRepository();
    usecase = UpdateChecklist(repository: repository);
  });
  test(
    'Checklists should return [VoidResult] from repository when update checklist usecase is called',
    () async {
      // arrange
      when(
        () => repository.updateChecklist(any()),
      ).thenAnswer((_) async => Right(VoidResult()));

      // act
      final result = await usecase(
        const ChecklistParams(
          checklist: tChecklist,
          companyId: 'companyId',
        ),
      );
      // assert
      verify(
        () => repository.updateChecklist(
          const ChecklistParams(
            checklist: tChecklist,
            companyId: 'companyId',
          ),
        ),
      );
      verifyNoMoreInteractions(repository);
      expect(result, isA<Right<Failure, VoidResult>>());
    },
  );
}
