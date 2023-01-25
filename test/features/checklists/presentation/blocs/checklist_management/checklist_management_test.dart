import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:under_control_v2/features/checklists/data/models/checklist_model.dart';
import 'package:under_control_v2/features/checklists/domain/usecases/add_checklist.dart';
import 'package:under_control_v2/features/checklists/domain/usecases/delete_checklist.dart';
import 'package:under_control_v2/features/checklists/domain/usecases/update_checklist.dart';
import 'package:under_control_v2/features/checklists/presentation/blocs/checklist_management/checklist_management_bloc.dart';
import 'package:under_control_v2/features/core/error/failures.dart';
import 'package:under_control_v2/features/core/usecases/usecase.dart';
import 'package:under_control_v2/features/user_profile/domain/entities/user_profile.dart';
import 'package:under_control_v2/features/user_profile/presentation/blocs/user_profile/user_profile_bloc.dart';

class MockUserProfileBloc extends Mock
    implements Stream<UserProfileState>, UserProfileBloc {}

class MockAddChecklist extends Mock implements AddChecklist {}

class MockUpdateChecklist extends Mock implements UpdateChecklist {}

class MockDeleteChecklist extends Mock implements DeleteChecklist {}

void main() {
  late MockUserProfileBloc mockUserProfileBloc;

  late MockAddChecklist mockAddChecklist;
  late MockUpdateChecklist mockUpdateChecklist;
  late MockDeleteChecklist mockDeleteChecklist;

  late ChecklistManagementBloc checklistManagementBloc;

  const companyId = 'companyId';

  ChecklistModel tChecklistModel = const ChecklistModel(
    id: 'id',
    title: 'title',
    description: 'description',
    allCheckpoints: [],
  );

  ChecklistParams tChecklistsParams = ChecklistParams(
    checklist: tChecklistModel,
    companyId: companyId,
  );

  setUp(
    () {
      mockUserProfileBloc = MockUserProfileBloc();
      when(() => mockUserProfileBloc.stream).thenAnswer(
        (_) => Stream.fromFuture(
          Future.value(UserProfileEmpty()),
        ),
      );
      when(() => mockUserProfileBloc.state).thenReturn(
        Approved(
          userProfile: UserProfile(
            id: '',
            administrator: false,
            approved: true,
            avatarUrl: '',
            companyId: '',
            email: '',
            firstName: '',
            isActive: true,
            joinDate: DateTime.now(),
            lastName: '',
            phoneNumber: '',
            locations: const [],
            deviceTokens: const [],
            rejected: false,
            suspended: false,
            userGroups: const [],
          ),
        ),
      );

      mockAddChecklist = MockAddChecklist();
      mockUpdateChecklist = MockUpdateChecklist();
      mockDeleteChecklist = MockDeleteChecklist();

      checklistManagementBloc = ChecklistManagementBloc(
        userProfileBloc: mockUserProfileBloc,
        addChecklist: mockAddChecklist,
        updateChecklist: mockUpdateChecklist,
        deleteChecklist: mockDeleteChecklist,
      );
    },
  );

  setUpAll(
    () {
      registerFallbackValue(tChecklistsParams);
    },
  );

  group('Checklist Management BLoC', () {
    test(
      'should emit [ChecklistmanagementEmptyState] as an initial state',
      () async {
        // assert
        expect(checklistManagementBloc.state, ChecklistManagementEmptyState());
      },
    );

    group('AddChecklist', () {
      blocTest<ChecklistManagementBloc, ChecklistManagementState>(
        'should emit [ChecklistManagementSuccessfulState] when AddChecklist is called',
        build: () => checklistManagementBloc,
        act: (bloc) async {
          when(() => mockAddChecklist(any()))
              .thenAnswer((_) async => const Right(''));
          bloc.add(AddChecklistEvent(checklist: tChecklistModel));
        },
        expect: () => [
          ChecklistManagementLoadingState(),
          isA<ChecklistManagementSuccessState>(),
        ],
      );
      blocTest<ChecklistManagementBloc, ChecklistManagementState>(
        'should emit [ChecklistManagementErrorState] when AddChecklist is called',
        build: () => checklistManagementBloc,
        act: (bloc) async {
          when(() => mockAddChecklist(any()))
              .thenAnswer((_) async => const Left(DatabaseFailure()));
          bloc.add(AddChecklistEvent(checklist: tChecklistModel));
        },
        expect: () => [
          ChecklistManagementLoadingState(),
          isA<ChecklistManagementErrorState>(),
        ],
      );
    });

    group('UpdateChecklist', () {
      blocTest<ChecklistManagementBloc, ChecklistManagementState>(
        'should emit [ChecklistManagementSuccessfulState] when UpdateChecklist is called',
        build: () => checklistManagementBloc,
        act: (bloc) async {
          when(() => mockUpdateChecklist(any()))
              .thenAnswer((_) async => Right(VoidResult()));
          bloc.add(UpdateChecklistEvent(checklist: tChecklistModel));
        },
        expect: () => [
          ChecklistManagementLoadingState(),
          isA<ChecklistManagementSuccessState>(),
        ],
      );
      blocTest<ChecklistManagementBloc, ChecklistManagementState>(
        'should emit [ChecklistManagementErrorState] when UpdateChecklist is called',
        build: () => checklistManagementBloc,
        act: (bloc) async {
          when(() => mockUpdateChecklist(any()))
              .thenAnswer((_) async => const Left(DatabaseFailure()));
          bloc.add(UpdateChecklistEvent(checklist: tChecklistModel));
        },
        expect: () => [
          ChecklistManagementLoadingState(),
          isA<ChecklistManagementErrorState>(),
        ],
      );
    });

    group('DeleteChecklist', () {
      blocTest<ChecklistManagementBloc, ChecklistManagementState>(
        'should emit [ChecklistManagementSuccessfulState] when DeleteChecklist is called',
        build: () => checklistManagementBloc,
        act: (bloc) async {
          when(() => mockDeleteChecklist(any()))
              .thenAnswer((_) async => Right(VoidResult()));
          bloc.add(DeleteChecklistEvent(checklist: tChecklistModel));
        },
        expect: () => [
          ChecklistManagementLoadingState(),
          isA<ChecklistManagementSuccessState>(),
        ],
      );
      blocTest<ChecklistManagementBloc, ChecklistManagementState>(
        'should emit [ChecklistManagementErrorState] when DeleteChecklist is called',
        build: () => checklistManagementBloc,
        act: (bloc) async {
          when(() => mockDeleteChecklist(any()))
              .thenAnswer((_) async => const Left(DatabaseFailure()));
          bloc.add(DeleteChecklistEvent(checklist: tChecklistModel));
        },
        expect: () => [
          ChecklistManagementLoadingState(),
          isA<ChecklistManagementErrorState>(),
        ],
      );
    });
  });
}
