import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:under_control_v2/features/checklists/domain/entities/checklist.dart';
import 'package:under_control_v2/features/checklists/domain/entities/checklists_stream.dart';
import 'package:under_control_v2/features/checklists/domain/repositories/checklists_repository.dart';
import 'package:under_control_v2/features/checklists/domain/usecases/delete_checklist.dart';
import 'package:under_control_v2/features/checklists/domain/usecases/get_checklists_stream.dart';
import 'package:under_control_v2/features/core/error/failures.dart';
import 'package:under_control_v2/features/core/usecases/usecase.dart';

class MockChecklistsRepository extends Mock implements CheckListsRepository {}

void main() {
  late GetChecklistStream usecase;
  late MockChecklistsRepository repository;

  const tChecklist = Checklist(id: 'id', title: 'title', allCheckpoints: []);

  setUp(() {
    repository = MockChecklistsRepository();
    usecase = GetChecklistStream(repository: repository);
  });
  test(
    'Checklists should return [ChecklistsStream] from repository when get checklists stream usecase is called',
    () async {
      // arrange
      when(
        () => repository.getChecklistsStream(any()),
      ).thenAnswer(
        (_) async => Right(
          ChecklistsStream(
            allChecklists: Stream.fromIterable(
              [tChecklist],
            ),
          ),
        ),
      );

      // act
      final result = await usecase('companyId');
      // assert
      verify(
        () => repository.getChecklistsStream('companyId'),
      );
      verifyNoMoreInteractions(repository);
      expect(result, isA<Right<Failure, ChecklistsStream>>());
    },
  );
}
