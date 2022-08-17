import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:under_control_v2/features/checklists/data/models/checklist_model.dart';
import 'package:under_control_v2/features/checklists/data/models/checklists_stream_model.dart';
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
  late ChecklistBloc checklistBloc;

  const companyId = 'companyId';

  const tChecklistModel = ChecklistModel(
    id: 'id',
    title: 'title',
    description: 'description',
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
      when(() => mockCompanyProfileBloc.stream).thenAnswer(
        (_) => Stream.fromFuture(
          Future.value(CompanyProfileEmpty()),
        ),
      );

      checklistBloc = ChecklistBloc(
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
            when(() => mockGetChecklistsStream(any())).thenAnswer(
              (_) async => Right(
                ChecklistsStreamModel(
                  allChecklists: Stream.fromIterable([]),
                ),
              ),
            );
          },
          expect: () => [
            ChecklistLoadingState(),
          ],
        );
        blocTest<ChecklistBloc, ChecklistState>(
          'should emit [ChecklistErrorState] when GetLAllChecklistsEvent is called',
          build: () => checklistBloc,
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
