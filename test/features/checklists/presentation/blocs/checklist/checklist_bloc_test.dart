import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:under_control_v2/features/authentication/presentation/blocs/authentication/authentication_bloc.dart';
import 'package:under_control_v2/features/checklists/data/models/checklist_model.dart';
import 'package:under_control_v2/features/checklists/data/models/checklists_stream_model.dart';
import 'package:under_control_v2/features/checklists/domain/usecases/get_checklists_stream.dart';
import 'package:under_control_v2/features/checklists/presentation/blocs/Checklist/checklist_bloc.dart';
import 'package:under_control_v2/features/core/error/failures.dart';
import 'package:under_control_v2/features/core/usecases/usecase.dart';
import 'package:under_control_v2/features/user_profile/presentation/blocs/user_profile/user_profile_bloc.dart';

class MockUserProfileBloc extends Mock
    implements Stream<UserProfileState>, UserProfileBloc {}

class MockAuthenticationBloc extends Mock
    implements Stream<AuthenticationState>, AuthenticationBloc {}

class MockGetChecklistsStream extends Mock implements GetChecklistStream {}

void main() {
  late MockAuthenticationBloc mockAuthenticationBloc;
  late MockUserProfileBloc mockUserProfileBloc;
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
      mockGetChecklistsStream = MockGetChecklistsStream();

      mockUserProfileBloc = MockUserProfileBloc();
      when(() => mockUserProfileBloc.stream).thenAnswer(
        (_) => Stream.fromFuture(
          Future.value(UserProfileEmpty()),
        ),
      );

      mockAuthenticationBloc = MockAuthenticationBloc();
      when(() => mockAuthenticationBloc.stream).thenAnswer(
        (_) => Stream.fromFuture(
          Future.value(EmptyAuthenticationState()),
        ),
      );

      checklistBloc = ChecklistBloc(
        authenticationBloc: mockAuthenticationBloc,
        userProfileBloc: mockUserProfileBloc,
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
