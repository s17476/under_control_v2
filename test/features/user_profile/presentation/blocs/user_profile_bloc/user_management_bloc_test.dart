import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:under_control_v2/features/core/error/failures.dart';
import 'package:under_control_v2/features/core/usecases/usecase.dart';
import 'package:under_control_v2/features/user_profile/domain/usecases/approve_user.dart';
import 'package:under_control_v2/features/user_profile/domain/usecases/approve_user_and_make_admin.dart';
import 'package:under_control_v2/features/user_profile/domain/usecases/reject_user.dart';
import 'package:under_control_v2/features/user_profile/domain/usecases/suspend_user.dart';
import 'package:under_control_v2/features/user_profile/presentation/blocs/user_management/user_management_bloc.dart';

class MockApproveUser extends Mock implements ApproveUser {}

class MockApproveUserAndMakeAdmin extends Mock
    implements ApproveUserAndMakeAdmin {}

class MockRejectUser extends Mock implements RejectUser {}

class MockSuspendUser extends Mock implements SuspendUser {}

void main() {
  late MockApproveUser mockApproveUser;
  late MockApproveUserAndMakeAdmin mockApproveUserAndMakeAdmin;
  late MockRejectUser mockRejectUser;
  late MockSuspendUser mockSuspendUser;
  late UserManagementBloc userManagementBloc;

  setUp(() {
    mockApproveUser = MockApproveUser();
    mockApproveUserAndMakeAdmin = MockApproveUserAndMakeAdmin();
    mockRejectUser = MockRejectUser();
    mockSuspendUser = MockSuspendUser();

    userManagementBloc = UserManagementBloc(
      approveUser: mockApproveUser,
      approveUserAndMakeAdmin: mockApproveUserAndMakeAdmin,
      rejectUser: mockRejectUser,
      suspendUser: mockSuspendUser,
    );
  });

  group('User management bloc', () {
    test(
      'should emit [UserManagementEmpty] as an initial state',
      () async {
        // assert
        expect(userManagementBloc.state, UserManagementEmpty());
      },
    );

    group('ApproveUser', () {
      blocTest(
        'should emit [UserManagementError] when usecase returns [UnsuspectedFailure]',
        build: () => userManagementBloc,
        act: (UserManagementBloc bloc) async {
          bloc.add(const ApproveUserEvent(userId: ''));
          when(() => mockApproveUser(any()))
              .thenAnswer((_) async => const Left(UnsuspectedFailure()));
        },
        skip: 1,
        verify: (_) => verify(() => mockApproveUser('')).called(1),
        expect: () => [isA<UserManagementError>()],
      );

      blocTest(
        'should emit [UserManagementError] when usecase returns [DatabaseFailure]',
        build: () => userManagementBloc,
        act: (UserManagementBloc bloc) async {
          bloc.add(const ApproveUserEvent(userId: ''));
          when(() => mockApproveUser(any()))
              .thenAnswer((_) async => const Left(DatabaseFailure()));
        },
        skip: 1,
        verify: (_) => verify(() => mockApproveUser('')).called(1),
        expect: () => [isA<UserManagementError>()],
      );

      blocTest(
        'should emit [UserManagementSuccess] when usecase returns [VoidResult]',
        build: () => userManagementBloc,
        act: (UserManagementBloc bloc) async {
          bloc.add(const ApproveUserEvent(userId: ''));
          when(() => mockApproveUser(any()))
              .thenAnswer((invocation) async => Right(VoidResult()));
        },
        skip: 1,
        verify: (_) => verify(() => mockApproveUser('')).called(1),
        expect: () => [isA<UserManagementSuccessful>()],
      );
    });

    group('ApproveUserAndMakeAdmin', () {
      blocTest(
        'should emit [UserManagementError] when usecase returns [UnsuspectedFailure]',
        build: () => userManagementBloc,
        act: (UserManagementBloc bloc) async {
          bloc.add(const ApproveUserAndMakeAdminEvent(userId: ''));
          when(() => mockApproveUserAndMakeAdmin(any()))
              .thenAnswer((_) async => const Left(UnsuspectedFailure()));
        },
        skip: 1,
        verify: (_) => verify(() => mockApproveUserAndMakeAdmin('')).called(1),
        expect: () => [isA<UserManagementError>()],
      );

      blocTest(
        'should emit [UserManagementError] when usecase returns [DatabaseFailure]',
        build: () => userManagementBloc,
        act: (UserManagementBloc bloc) async {
          bloc.add(const ApproveUserAndMakeAdminEvent(userId: ''));
          when(() => mockApproveUserAndMakeAdmin(any()))
              .thenAnswer((_) async => const Left(DatabaseFailure()));
        },
        skip: 1,
        verify: (_) => verify(() => mockApproveUserAndMakeAdmin('')).called(1),
        expect: () => [isA<UserManagementError>()],
      );

      blocTest(
        'should emit [UserManagementSuccess] when usecase returns [VoidResult]',
        build: () => userManagementBloc,
        act: (UserManagementBloc bloc) async {
          bloc.add(const ApproveUserAndMakeAdminEvent(userId: ''));
          when(() => mockApproveUserAndMakeAdmin(any()))
              .thenAnswer((invocation) async => Right(VoidResult()));
        },
        skip: 1,
        verify: (_) => verify(() => mockApproveUserAndMakeAdmin('')).called(1),
        expect: () => [isA<UserManagementSuccessful>()],
      );
    });

    group('RejectUser', () {
      blocTest(
        'should emit [UserManagementError] when usecase returns [UnsuspectedFailure]',
        build: () => userManagementBloc,
        act: (UserManagementBloc bloc) async {
          bloc.add(const RejectUserEvent(userId: ''));
          when(() => mockRejectUser(any()))
              .thenAnswer((_) async => const Left(UnsuspectedFailure()));
        },
        skip: 1,
        verify: (_) => verify(() => mockRejectUser('')).called(1),
        expect: () => [isA<UserManagementError>()],
      );

      blocTest(
        'should emit [UserManagementError] when usecase returns [DatabaseFailure]',
        build: () => userManagementBloc,
        act: (UserManagementBloc bloc) async {
          bloc.add(const RejectUserEvent(userId: ''));
          when(() => mockRejectUser(any()))
              .thenAnswer((_) async => const Left(DatabaseFailure()));
        },
        skip: 1,
        verify: (_) => verify(() => mockRejectUser('')).called(1),
        expect: () => [isA<UserManagementError>()],
      );

      blocTest(
        'should emit [UserManagementSuccess] when usecase returns [VoidResult]',
        build: () => userManagementBloc,
        act: (UserManagementBloc bloc) async {
          bloc.add(const RejectUserEvent(userId: ''));
          when(() => mockRejectUser(any()))
              .thenAnswer((invocation) async => Right(VoidResult()));
        },
        skip: 1,
        verify: (_) => verify(() => mockRejectUser('')).called(1),
        expect: () => [isA<UserManagementSuccessful>()],
      );
    });

    group('SuspendUser', () {
      blocTest(
        'should emit [UserManagementError] when usecase returns [UnsuspectedFailure]',
        build: () => userManagementBloc,
        act: (UserManagementBloc bloc) async {
          bloc.add(const SuspendUserEvent(userId: ''));
          when(() => mockSuspendUser(any()))
              .thenAnswer((_) async => const Left(UnsuspectedFailure()));
        },
        skip: 1,
        verify: (_) => verify(() => mockSuspendUser('')).called(1),
        expect: () => [isA<UserManagementError>()],
      );

      blocTest(
        'should emit [UserManagementError] when usecase returns [DatabaseFailure]',
        build: () => userManagementBloc,
        act: (UserManagementBloc bloc) async {
          bloc.add(const SuspendUserEvent(userId: ''));
          when(() => mockSuspendUser(any()))
              .thenAnswer((_) async => const Left(DatabaseFailure()));
        },
        skip: 1,
        verify: (_) => verify(() => mockSuspendUser('')).called(1),
        expect: () => [isA<UserManagementError>()],
      );

      blocTest(
        'should emit [UserManagementSuccess] when usecase returns [VoidResult]',
        build: () => userManagementBloc,
        act: (UserManagementBloc bloc) async {
          bloc.add(const SuspendUserEvent(userId: ''));
          when(() => mockSuspendUser(any()))
              .thenAnswer((invocation) async => Right(VoidResult()));
        },
        skip: 1,
        verify: (_) => verify(() => mockSuspendUser('')).called(1),
        expect: () => [isA<UserManagementSuccessful>()],
      );
    });
  });
}
