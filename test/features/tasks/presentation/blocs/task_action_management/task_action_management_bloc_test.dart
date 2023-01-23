import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:under_control_v2/features/core/error/failures.dart';
import 'package:under_control_v2/features/core/usecases/usecase.dart';
import 'package:under_control_v2/features/tasks/domain/usecases/task_action/add_task_action.dart';
import 'package:under_control_v2/features/tasks/domain/usecases/task_action/delete_task_action.dart';
import 'package:under_control_v2/features/tasks/domain/usecases/task_action/update_task_action.dart';
import 'package:under_control_v2/features/tasks/presentation/blocs/task_action_management/task_action_management_bloc.dart';
import 'package:under_control_v2/features/user_profile/domain/entities/user_profile.dart';
import 'package:under_control_v2/features/user_profile/presentation/blocs/user_profile/user_profile_bloc.dart';

import '../../../t_task_instance.dart';

class MockUserProfileBloc extends Mock
    implements Stream<UserProfileState>, UserProfileBloc {}

class MockAddTaskAction extends Mock implements AddTaskAction {}

class MockDeleteTaskAction extends Mock implements DeleteTaskAction {}

class MockUpdateTaskAction extends Mock implements UpdateTaskAction {}

void main() {
  late MockUserProfileBloc mockUserProfileBloc;

  late MockAddTaskAction mockAddTaskAction;
  late MockDeleteTaskAction mockDeleteTaskAction;
  late MockUpdateTaskAction mockUpdateTaskAction;

  late TaskActionManagementBloc taskActionManagementBloc;

  setUp(() {
    mockUserProfileBloc = MockUserProfileBloc();

    mockAddTaskAction = MockAddTaskAction();
    mockDeleteTaskAction = MockDeleteTaskAction();
    mockUpdateTaskAction = MockUpdateTaskAction();

    when(() => mockUserProfileBloc.stream).thenAnswer(
      (_) => Stream.fromFuture(
        Future.value(
          Approved(
            userProfile: UserProfile(
              administrator: true,
              approved: true,
              avatarUrl: '',
              companyId: 'companyId',
              email: 'email',
              firstName: 'firstName',
              lastName: 'lastname',
              id: 'id',
              isActive: true,
              joinDate: DateTime.now(),
              phoneNumber: '',
              locations: const [],
              userGroups: const [],
              rejected: false,
              suspended: false,
            ),
          ),
        ),
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
          rejected: false,
          suspended: false,
          userGroups: const [],
        ),
      ),
    );

    taskActionManagementBloc = TaskActionManagementBloc(
      userProfileBloc: mockUserProfileBloc,
      addTaskAction: mockAddTaskAction,
      deleteTaskAction: mockDeleteTaskAction,
      updateTaskAction: mockUpdateTaskAction,
    );
  });

  setUpAll(() {
    registerFallbackValue(tTaskActionParams);
    registerFallbackValue(tTaskParams);
  });

  group('Task Action Management BLoC', () {
    test(
      'should emit [TaskActionManagementEmptyState] as an initial state',
      () async {
        // assert
        expect(
            taskActionManagementBloc.state, TaskActionManagementEmptyState());
      },
    );

    group('AddTaskAction', () {
      blocTest<TaskActionManagementBloc, TaskActionManagementState>(
        'should emit [TaskActionManagementSuccessfulStete]',
        build: () => taskActionManagementBloc,
        act: (bloc) async {
          when(() => mockAddTaskAction(any()))
              .thenAnswer((_) async => const Right(''));
          bloc.add(
            AddTaskActionEvent(
              task: tTaskModel,
              taskAction: tTaskActionModel,
            ),
          );
        },
        expect: () => [
          TaskActionManagementLoadingState(),
          isA<TaskActionManagementSuccessState>(),
        ],
      );
      blocTest<TaskActionManagementBloc, TaskActionManagementState>(
        'should emit [TaskActionManagementErrorStete]',
        build: () => taskActionManagementBloc,
        act: (bloc) async {
          when(() => mockAddTaskAction(any())).thenAnswer(
            (_) async => const Left(
              DatabaseFailure(),
            ),
          );
          bloc.add(
            AddTaskActionEvent(
              task: tTaskModel,
              taskAction: tTaskActionModel,
            ),
          );
        },
        expect: () => [
          TaskActionManagementLoadingState(),
          isA<TaskActionManagementErrorState>(),
        ],
      );
    });
    group('DeleteTaskAction', () {
      blocTest<TaskActionManagementBloc, TaskActionManagementState>(
        'should emit [TaskActionManagementSuccessfulStete]',
        build: () => taskActionManagementBloc,
        act: (bloc) async {
          when(() => mockDeleteTaskAction(any()))
              .thenAnswer((_) async => Right(VoidResult()));
          bloc.add(
            DeleteTaskActionEvent(
              task: tTaskModel,
              taskAction: tTaskActionModel,
            ),
          );
        },
        expect: () => [
          TaskActionManagementLoadingState(),
          isA<TaskActionManagementSuccessState>(),
        ],
      );
      blocTest<TaskActionManagementBloc, TaskActionManagementState>(
        'should emit [TaskActionManagementErrorStete]',
        build: () => taskActionManagementBloc,
        act: (bloc) async {
          when(() => mockDeleteTaskAction(any())).thenAnswer(
            (_) async => const Left(
              DatabaseFailure(),
            ),
          );
          bloc.add(
            DeleteTaskActionEvent(
              task: tTaskModel,
              taskAction: tTaskActionModel,
            ),
          );
        },
        expect: () => [
          TaskActionManagementLoadingState(),
          isA<TaskActionManagementErrorState>(),
        ],
      );
    });

    group('UpdateTaskAction', () {
      blocTest<TaskActionManagementBloc, TaskActionManagementState>(
        'should emit [TaskActionManagementSuccessfulStete]',
        build: () => taskActionManagementBloc,
        act: (bloc) async {
          when(() => mockUpdateTaskAction(any()))
              .thenAnswer((_) async => Right(VoidResult()));
          bloc.add(
            UpdateTaskActionEvent(
              task: tTaskModel,
              taskAction: tTaskActionModel,
            ),
          );
        },
        expect: () => [
          TaskActionManagementLoadingState(),
          isA<TaskActionManagementSuccessState>(),
        ],
      );
      blocTest<TaskActionManagementBloc, TaskActionManagementState>(
        'should emit [TaskActionManagementErrorStete]',
        build: () => taskActionManagementBloc,
        act: (bloc) async {
          when(() => mockUpdateTaskAction(any())).thenAnswer(
            (_) async => const Left(
              DatabaseFailure(),
            ),
          );
          bloc.add(
            UpdateTaskActionEvent(
              task: tTaskModel,
              taskAction: tTaskActionModel,
            ),
          );
        },
        expect: () => [
          TaskActionManagementLoadingState(),
          isA<TaskActionManagementErrorState>(),
        ],
      );
    });
  });
}
