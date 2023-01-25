import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:under_control_v2/features/assets/utils/asset_status.dart';
import 'package:under_control_v2/features/core/error/failures.dart';
import 'package:under_control_v2/features/core/usecases/usecase.dart';
import 'package:under_control_v2/features/core/utils/duration_unit.dart';
import 'package:under_control_v2/features/tasks/data/models/task/spare_part_item_model.dart';
import 'package:under_control_v2/features/tasks/data/models/task/task_model.dart';
import 'package:under_control_v2/features/tasks/domain/entities/task_priority.dart';
import 'package:under_control_v2/features/tasks/domain/entities/task_type.dart';
import 'package:under_control_v2/features/tasks/domain/usecases/task/add_task.dart';
import 'package:under_control_v2/features/tasks/domain/usecases/task/cancel_task.dart';
import 'package:under_control_v2/features/tasks/domain/usecases/task/complete_task.dart';
import 'package:under_control_v2/features/tasks/domain/usecases/task/delete_task.dart';
import 'package:under_control_v2/features/tasks/domain/usecases/task/update_task.dart';
import 'package:under_control_v2/features/tasks/presentation/blocs/task_management/task_management_bloc.dart';
import 'package:under_control_v2/features/user_profile/domain/entities/user_profile.dart';
import 'package:under_control_v2/features/user_profile/presentation/blocs/user_profile/user_profile_bloc.dart';

class MockUserProfileBloc extends Mock
    implements Stream<UserProfileState>, UserProfileBloc {}

class MockAddTask extends Mock implements AddTask {}

class MockDeleteTask extends Mock implements DeleteTask {}

class MockCancelTask extends Mock implements CancelTask {}

class MockUpdateTask extends Mock implements UpdateTask {}

class MockCompleteTask extends Mock implements CompleteTask {}

void main() {
  late MockUserProfileBloc mockUserProfileBloc;

  late MockAddTask mockAddTask;
  late MockDeleteTask mockDeleteTask;
  late MockCancelTask mockCancelTask;
  late MockUpdateTask mockUpdateTask;
  late MockCompleteTask mockCompleteTask;

  late TaskManagementBloc workRequestManagementBloc;

  const companyId = 'companyId';

  final tTaskModel = TaskModel(
    id: 'id',
    title: 'title',
    description: 'description',
    date: DateTime.now(),
    locationId: 'locationId',
    userId: 'userId',
    assetId: 'assetId',
    images: const [],
    video: 'video',
    priority: TaskPriority.low,
    count: 0,
    workOrderId: 'taskId',
    assetStatus: AssetStatus.ok,
    isCancelled: false,
    actions: const [],
    assignedGroups: const [],
    assignedUsers: const [],
    duration: 0,
    durationUnit: DurationUnit.day,
    executionDate: DateTime.now(),
    instructions: const [],
    isCyclictask: false,
    isFinished: false,
    isInProgress: false,
    isSuccessful: false,
    parentId: 'parentId',
    type: TaskType.event,
    sparePartsAssets: const [],
    sparePartsItems: const [
      SparePartItemModel(
          itemId: 'itemId', locationId: 'locationId', quantity: 1),
    ],
    checklist: const [],
  );

  final tTaskParams = TaskParams(
    task: tTaskModel,
    companyId: companyId,
  );

  setUp(() {
    mockAddTask = MockAddTask();
    mockDeleteTask = MockDeleteTask();
    mockCancelTask = MockCancelTask();
    mockUpdateTask = MockUpdateTask();
    mockCompleteTask = MockCompleteTask();

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

    workRequestManagementBloc = TaskManagementBloc(
      userProfileBloc: mockUserProfileBloc,
      addTask: mockAddTask,
      deleteTask: mockDeleteTask,
      updateTask: mockUpdateTask,
      cancelTask: mockCancelTask,
      completeTask: mockCompleteTask,
    );
  });

  setUpAll(() {
    registerFallbackValue(tTaskParams);
  });

  group('Task Management BLoC', () {
    test(
      'should emit [TaskManagementEmptyState] as an initial state',
      () async {
        // assert
        expect(workRequestManagementBloc.state, TaskManagementEmptyState());
      },
    );

    group('AddTask', () {
      blocTest<TaskManagementBloc, TaskManagementState>(
        'should emit [TaskManagementSuccessfulStete]',
        build: () => workRequestManagementBloc,
        act: (bloc) async {
          when(() => mockAddTask(any()))
              .thenAnswer((_) async => const Right(''));
          bloc.add(AddTaskEvent(task: tTaskModel));
        },
        expect: () => [
          TaskManagementLoadingState(),
          isA<TaskManagementSuccessState>(),
        ],
      );
      blocTest<TaskManagementBloc, TaskManagementState>(
        'should emit [TaskManagementErrorStete]',
        build: () => workRequestManagementBloc,
        act: (bloc) async {
          when(() => mockAddTask(any())).thenAnswer(
            (_) async => const Left(
              DatabaseFailure(),
            ),
          );
          bloc.add(AddTaskEvent(task: tTaskModel));
        },
        expect: () => [
          TaskManagementLoadingState(),
          isA<TaskManagementErrorState>(),
        ],
      );
    });
    group('DeleteTask', () {
      blocTest<TaskManagementBloc, TaskManagementState>(
        'should emit [TaskManagementSuccessfulStete]',
        build: () => workRequestManagementBloc,
        act: (bloc) async {
          when(() => mockDeleteTask(any()))
              .thenAnswer((_) async => Right(VoidResult()));
          bloc.add(DeleteTaskEvent(task: tTaskModel));
        },
        expect: () => [
          TaskManagementLoadingState(),
          isA<TaskManagementSuccessState>(),
        ],
      );
      blocTest<TaskManagementBloc, TaskManagementState>(
        'should emit [TaskManagementErrorStete]',
        build: () => workRequestManagementBloc,
        act: (bloc) async {
          when(() => mockDeleteTask(any())).thenAnswer(
            (_) async => const Left(
              DatabaseFailure(),
            ),
          );
          bloc.add(DeleteTaskEvent(task: tTaskModel));
        },
        expect: () => [
          TaskManagementLoadingState(),
          isA<TaskManagementErrorState>(),
        ],
      );
    });
    group('CancelTask', () {
      blocTest<TaskManagementBloc, TaskManagementState>(
        'should emit [TaskManagementSuccessfulStete]',
        build: () => workRequestManagementBloc,
        act: (bloc) async {
          when(() => mockCancelTask(any()))
              .thenAnswer((_) async => Right(VoidResult()));
          bloc.add(CancelTaskEvent(
            task: tTaskModel,
            comment: '',
          ));
        },
        expect: () => [
          TaskManagementLoadingState(),
          isA<TaskManagementSuccessState>(),
        ],
      );
      blocTest<TaskManagementBloc, TaskManagementState>(
        'should emit [TaskManagementErrorStete]',
        build: () => workRequestManagementBloc,
        act: (bloc) async {
          when(() => mockCancelTask(any())).thenAnswer(
            (_) async => const Left(
              DatabaseFailure(),
            ),
          );
          bloc.add(CancelTaskEvent(
            task: tTaskModel,
            comment: '',
          ));
        },
        expect: () => [
          TaskManagementLoadingState(),
          isA<TaskManagementErrorState>(),
        ],
      );
    });
    group('UpdateTask', () {
      blocTest<TaskManagementBloc, TaskManagementState>(
        'should emit [TaskManagementSuccessfulStete]',
        build: () => workRequestManagementBloc,
        act: (bloc) async {
          when(() => mockUpdateTask(any()))
              .thenAnswer((_) async => Right(VoidResult()));
          bloc.add(UpdateTaskEvent(task: tTaskModel));
        },
        expect: () => [
          TaskManagementLoadingState(),
          isA<TaskManagementSuccessState>(),
        ],
      );
      blocTest<TaskManagementBloc, TaskManagementState>(
        'should emit [TaskManagementErrorStete]',
        build: () => workRequestManagementBloc,
        act: (bloc) async {
          when(() => mockUpdateTask(any())).thenAnswer(
            (_) async => const Left(
              DatabaseFailure(),
            ),
          );
          bloc.add(UpdateTaskEvent(task: tTaskModel));
        },
        expect: () => [
          TaskManagementLoadingState(),
          isA<TaskManagementErrorState>(),
        ],
      );
    });
  });
}
