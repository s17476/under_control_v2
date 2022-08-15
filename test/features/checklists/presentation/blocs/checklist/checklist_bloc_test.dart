import 'package:bloc_test/bloc_test.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:under_control_v2/features/checklists/data/models/checklist_model.dart';
import 'package:under_control_v2/features/checklists/data/repositories/checklists_repository_impl.dart';
import 'package:under_control_v2/features/checklists/domain/usecases/get_checklists_stream.dart';
import 'package:under_control_v2/features/checklists/presentation/blocs/Checklist/checklist_bloc.dart';
import 'package:under_control_v2/features/company_profile/presentation/blocs/company_profile/company_profile_bloc.dart';
import 'package:under_control_v2/features/core/error/failures.dart';
import 'package:under_control_v2/features/core/usecases/usecase.dart';

class MockCompanyProfileBloc extends Mock
    implements Stream<CompanyProfileState>, CompanyProfileBloc {}

class MockGetChecklistsStream extends Mock implements GetChecklistStream {}

void main() {
  late MockCompanyProfileBloc mockCompanyProfileBloc;
  late MockGetChecklistsStream mockGetChecklistsStream;
  late GetChecklistStream getChecklistStream;
  late FakeFirebaseFirestore fakeFirebaseFirestore;
  late ChecklistsRepositoryImpl checklistsRepositoryImpl;
  late CollectionReference checklistsReference;
  late ChecklistBloc checklistBloc;
  late ChecklistBloc badChecklistsBloc;

  const companyId = 'companyId';

  const tChecklistModel = ChecklistModel(
    id: 'id',
    title: 'title',
    allCheckpoints: [],
  );

  const tChecklistsParams = ChecklistParams(
    checklist: tChecklistModel,
    companyId: companyId,
  );

  setUp(
    () {
      mockCompanyProfileBloc = MockCompanyProfileBloc();
      mockGetChecklistsStream = MockGetChecklistsStream();
      fakeFirebaseFirestore = FakeFirebaseFirestore();
      checklistsRepositoryImpl =
          ChecklistsRepositoryImpl(firebaseFirestore: fakeFirebaseFirestore);
      getChecklistStream =
          GetChecklistStream(repository: checklistsRepositoryImpl);

      checklistsReference = fakeFirebaseFirestore
          .collection('companies')
          .doc(companyId)
          .collection('checklists');

      checklistsReference.add(tChecklistModel.toMap());

      when(() => mockCompanyProfileBloc.stream).thenAnswer(
        (_) => Stream.fromFuture(
          Future.value(CompanyProfileEmpty()),
        ),
      );

      checklistBloc = ChecklistBloc(
        companyProfileBloc: mockCompanyProfileBloc,
        getChecklistsStream: getChecklistStream,
      );

      badChecklistsBloc = ChecklistBloc(
        companyProfileBloc: mockCompanyProfileBloc,
        getChecklistsStream: mockGetChecklistsStream,
      );
    },
  );

  setUpAll(
    () {
      registerFallbackValue(tChecklistsParams);
    },
  );

  group('Checklist BLoC', () {
    test(
      'should emit [ChecklistEmptyState] as an initial state',
      () async {
        // assert
        expect(checklistBloc.state, ChecklistEmptyState());
      },
    );

    group(
      'GetLocationsStream',
      () {
        blocTest<ChecklistBloc, ChecklistState>(
          'should emit [ChecklistLoadingState]  when GetLAllChecklistsEvent is called',
          build: () => checklistBloc,
          act: (bloc) async {
            bloc.add(GetAllChecklistsEvent());
          },
          expect: () => [
            ChecklistLoadingState(),
            isA<ChecklistLoadedState>(),
          ],
        );
        blocTest<ChecklistBloc, ChecklistState>(
          'should emit [ChecklistErrorState] when GetLAllChecklistsEvent is called',
          build: () => badChecklistsBloc,
          act: (bloc) async {
            bloc.add(GetAllChecklistsEvent());
            when(() => mockGetChecklistsStream(any())).thenAnswer(
              (_) async => const Left(
                DatabaseFailure(),
              ),
            );
          },
          expect: () => [
            ChecklistLoadingState(),
            isA<ChecklistErrorState>(),
          ],
        );
      },
    );
  });
}
