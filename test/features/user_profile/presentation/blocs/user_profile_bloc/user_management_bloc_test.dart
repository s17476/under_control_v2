import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:under_control_v2/features/core/error/failures.dart';
import 'package:under_control_v2/features/core/usecases/usecase.dart';
import 'package:under_control_v2/features/user_profile/domain/usecases/add_user_avatar.dart';
import 'package:under_control_v2/features/user_profile/domain/usecases/approve_passive_user.dart';
import 'package:under_control_v2/features/user_profile/domain/usecases/approve_user.dart';
import 'package:under_control_v2/features/user_profile/domain/usecases/approve_user_and_make_admin.dart';
import 'package:under_control_v2/features/user_profile/domain/usecases/assign_group_admin.dart';
import 'package:under_control_v2/features/user_profile/domain/usecases/assign_user_to_group.dart';
import 'package:under_control_v2/features/user_profile/domain/usecases/make_user_administrator.dart';
import 'package:under_control_v2/features/user_profile/domain/usecases/reject_user.dart';
import 'package:under_control_v2/features/user_profile/domain/usecases/suspend_user.dart';
import 'package:under_control_v2/features/user_profile/domain/usecases/unassign_group_admin.dart';
import 'package:under_control_v2/features/user_profile/domain/usecases/unassign_user_from_group.dart';
import 'package:under_control_v2/features/user_profile/domain/usecases/unmake_user_administrator.dart';
import 'package:under_control_v2/features/user_profile/domain/usecases/unsuspend_user.dart';
import 'package:under_control_v2/features/user_profile/domain/usecases/update_user_data.dart';
import 'package:under_control_v2/features/user_profile/presentation/blocs/user_management/user_management_bloc.dart';

class MockApproveUser extends Mock implements ApproveUser {}

class MockApprovePassiveUser extends Mock implements ApprovePassiveUser {}

class MockMakeUserAdministrator extends Mock implements MakeUserAdministrator {}

class MockUnmakeUserAdministrator extends Mock
    implements UnmakeUserAdministrator {}

class MockApproveUserAndMakeAdmin extends Mock
    implements ApproveUserAndMakeAdmin {}

class MockRejectUser extends Mock implements RejectUser {}

class MockSuspendUser extends Mock implements SuspendUser {}

class MockUnsuspendUser extends Mock implements UnsuspendUser {}

class MockUpdateUserData extends Mock implements UpdateUserData {}

class MockAssignUserToGroup extends Mock implements AssignUserToGroup {}

class MockUnassignUserFromGroup extends Mock implements UnassignUserFromGroup {}

class MockAssignGroupAdmin extends Mock implements AssignGroupAdmin {}

class MockUnassignGroupAdmin extends Mock implements UnassignGroupAdmin {}

class MockAddUserAvatar extends Mock implements AddUserAvatar {}

void main() {
  late MockApproveUser mockApproveUser;
  late MockApprovePassiveUser mockApprovePassiveUser;
  late MockMakeUserAdministrator mockMakeUserAdministrator;
  late MockUnmakeUserAdministrator mockUnmakeUserAdministrator;
  late MockApproveUserAndMakeAdmin mockApproveUserAndMakeAdmin;
  late MockRejectUser mockRejectUser;
  late MockSuspendUser mockSuspendUser;
  late MockUnsuspendUser mockUnsuspendUser;
  late MockUpdateUserData mockUpdateUserData;
  late MockAssignUserToGroup mockAssignUserToGroup;
  late MockUnassignUserFromGroup mockUnassignUserFromGroup;
  late MockAssignGroupAdmin mockAssignGroupAdmin;
  late MockUnassignGroupAdmin mockUnassignGroupAdmin;
  late MockAddUserAvatar mockAddUserAvatar;
  late UserManagementBloc userManagementBloc;

  setUp(() {
    mockApproveUser = MockApproveUser();
    mockApprovePassiveUser = MockApprovePassiveUser();
    mockMakeUserAdministrator = MockMakeUserAdministrator();
    mockUnmakeUserAdministrator = MockUnmakeUserAdministrator();
    mockApproveUserAndMakeAdmin = MockApproveUserAndMakeAdmin();
    mockRejectUser = MockRejectUser();
    mockSuspendUser = MockSuspendUser();
    mockUnsuspendUser = MockUnsuspendUser();
    mockUpdateUserData = MockUpdateUserData();
    mockAssignUserToGroup = MockAssignUserToGroup();
    mockUnassignUserFromGroup = MockUnassignUserFromGroup();
    mockAssignGroupAdmin = MockAssignGroupAdmin();
    mockUnassignGroupAdmin = MockUnassignGroupAdmin();
    mockAddUserAvatar = MockAddUserAvatar();

    userManagementBloc = UserManagementBloc(
      approveUser: mockApproveUser,
      approvePassiveUser: mockApprovePassiveUser,
      makeUserAdministrator: mockMakeUserAdministrator,
      unmakeUserAdministrator: mockUnmakeUserAdministrator,
      approveUserAndMakeAdmin: mockApproveUserAndMakeAdmin,
      rejectUser: mockRejectUser,
      suspendUser: mockSuspendUser,
      unsuspendUser: mockUnsuspendUser,
      updateUserData: mockUpdateUserData,
      assignUserToGroup: mockAssignUserToGroup,
      unassignUserFromGroup: mockUnassignUserFromGroup,
      assignGroupAdmin: mockAssignGroupAdmin,
      unassignGroupAdmin: mockUnassignGroupAdmin,
      addUserAvatar: mockAddUserAvatar,
    );
  });

  const tUserAndGroupParams = UserAndGroupParams(
    groupId: 'groupId',
    userId: 'userId',
  );

  const tAssignGroupAdminParams = AssignGroupAdminParams(
    userId: 'userId',
    groupId: 'groupId',
    companyId: 'companyId',
  );

  setUpAll(() {
    registerFallbackValue(
      const UserAndGroupParams(
        userId: 'userId',
        groupId: 'groupId',
      ),
    );

    registerFallbackValue(
      const AssignGroupAdminParams(
        userId: 'userId',
        groupId: 'groupId',
        companyId: 'companyId',
      ),
    );
  });

  group('User Management BLoC', () {
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

    group('ApprovePassiveUser', () {
      blocTest(
        'should emit [UserManagementError] when usecase returns [UnsuspectedFailure]',
        build: () => userManagementBloc,
        act: (UserManagementBloc bloc) async {
          bloc.add(const ApprovePassiveUserEvent(userId: ''));
          when(() => mockApprovePassiveUser(any()))
              .thenAnswer((_) async => const Left(UnsuspectedFailure()));
        },
        skip: 1,
        verify: (_) => verify(() => mockApprovePassiveUser('')).called(1),
        expect: () => [isA<UserManagementError>()],
      );

      blocTest(
        'should emit [UserManagementError] when usecase returns [DatabaseFailure]',
        build: () => userManagementBloc,
        act: (UserManagementBloc bloc) async {
          bloc.add(const ApprovePassiveUserEvent(userId: ''));
          when(() => mockApprovePassiveUser(any()))
              .thenAnswer((_) async => const Left(DatabaseFailure()));
        },
        skip: 1,
        verify: (_) => verify(() => mockApprovePassiveUser('')).called(1),
        expect: () => [isA<UserManagementError>()],
      );

      blocTest(
        'should emit [UserManagementSuccess] when usecase returns [VoidResult]',
        build: () => userManagementBloc,
        act: (UserManagementBloc bloc) async {
          bloc.add(const ApprovePassiveUserEvent(userId: ''));
          when(() => mockApprovePassiveUser(any()))
              .thenAnswer((invocation) async => Right(VoidResult()));
        },
        skip: 1,
        verify: (_) => verify(() => mockApprovePassiveUser('')).called(1),
        expect: () => [isA<UserManagementSuccessful>()],
      );
    });

    group('MakeUserAdministrator', () {
      blocTest(
        'should emit [UserManagementError] when usecase returns [UnsuspectedFailure]',
        build: () => userManagementBloc,
        act: (UserManagementBloc bloc) async {
          bloc.add(const MakeUserAdministratorEvent(userId: ''));
          when(() => mockMakeUserAdministrator(any()))
              .thenAnswer((_) async => const Left(UnsuspectedFailure()));
        },
        skip: 1,
        verify: (_) => verify(() => mockMakeUserAdministrator('')).called(1),
        expect: () => [isA<UserManagementError>()],
      );

      blocTest(
        'should emit [UserManagementError] when usecase returns [DatabaseFailure]',
        build: () => userManagementBloc,
        act: (UserManagementBloc bloc) async {
          bloc.add(const MakeUserAdministratorEvent(userId: ''));
          when(() => mockMakeUserAdministrator(any()))
              .thenAnswer((_) async => const Left(DatabaseFailure()));
        },
        skip: 1,
        verify: (_) => verify(() => mockMakeUserAdministrator('')).called(1),
        expect: () => [isA<UserManagementError>()],
      );

      blocTest(
        'should emit [UserManagementSuccess] when usecase returns [VoidResult]',
        build: () => userManagementBloc,
        act: (UserManagementBloc bloc) async {
          bloc.add(const MakeUserAdministratorEvent(userId: ''));
          when(() => mockMakeUserAdministrator(any()))
              .thenAnswer((invocation) async => Right(VoidResult()));
        },
        skip: 1,
        verify: (_) => verify(() => mockMakeUserAdministrator('')).called(1),
        expect: () => [isA<UserManagementSuccessful>()],
      );
    });
    group('UnmakeUserAdministrator', () {
      blocTest(
        'should emit [UserManagementError] when usecase returns [UnsuspectedFailure]',
        build: () => userManagementBloc,
        act: (UserManagementBloc bloc) async {
          bloc.add(const UnmakeUserAdministratorEvent(userId: ''));
          when(() => mockUnmakeUserAdministrator(any()))
              .thenAnswer((_) async => const Left(UnsuspectedFailure()));
        },
        skip: 1,
        verify: (_) => verify(() => mockUnmakeUserAdministrator('')).called(1),
        expect: () => [isA<UserManagementError>()],
      );

      blocTest(
        'should emit [UserManagementError] when usecase returns [DatabaseFailure]',
        build: () => userManagementBloc,
        act: (UserManagementBloc bloc) async {
          bloc.add(const UnmakeUserAdministratorEvent(userId: ''));
          when(() => mockUnmakeUserAdministrator(any()))
              .thenAnswer((_) async => const Left(DatabaseFailure()));
        },
        skip: 1,
        verify: (_) => verify(() => mockUnmakeUserAdministrator('')).called(1),
        expect: () => [isA<UserManagementError>()],
      );

      blocTest(
        'should emit [UserManagementSuccess] when usecase returns [VoidResult]',
        build: () => userManagementBloc,
        act: (UserManagementBloc bloc) async {
          bloc.add(const UnmakeUserAdministratorEvent(userId: ''));
          when(() => mockUnmakeUserAdministrator(any()))
              .thenAnswer((invocation) async => Right(VoidResult()));
        },
        skip: 1,
        verify: (_) => verify(() => mockUnmakeUserAdministrator('')).called(1),
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

    group('UnsuspendUser', () {
      blocTest(
        'should emit [UserManagementError] when usecase returns [UnsuspectedFailure]',
        build: () => userManagementBloc,
        act: (UserManagementBloc bloc) async {
          bloc.add(const UnsuspendUserEvent(userId: ''));
          when(() => mockUnsuspendUser(any()))
              .thenAnswer((_) async => const Left(UnsuspectedFailure()));
        },
        skip: 1,
        verify: (_) => verify(() => mockUnsuspendUser('')).called(1),
        expect: () => [isA<UserManagementError>()],
      );

      blocTest(
        'should emit [UserManagementError] when usecase returns [DatabaseFailure]',
        build: () => userManagementBloc,
        act: (UserManagementBloc bloc) async {
          bloc.add(const UnsuspendUserEvent(userId: ''));
          when(() => mockUnsuspendUser(any()))
              .thenAnswer((_) async => const Left(DatabaseFailure()));
        },
        skip: 1,
        verify: (_) => verify(() => mockUnsuspendUser('')).called(1),
        expect: () => [isA<UserManagementError>()],
      );

      blocTest(
        'should emit [UserManagementSuccess] when usecase returns [VoidResult]',
        build: () => userManagementBloc,
        act: (UserManagementBloc bloc) async {
          bloc.add(const UnsuspendUserEvent(userId: ''));
          when(() => mockUnsuspendUser(any()))
              .thenAnswer((_) async => Right(VoidResult()));
        },
        skip: 1,
        verify: (_) => verify(() => mockUnsuspendUser('')).called(1),
        expect: () => [isA<UserManagementSuccessful>()],
      );
    });

    group('AssignUserToGroup', () {
      blocTest(
        'should emit [UserManagementError] when usecase returns [UnsuspectedFailure]',
        build: () => userManagementBloc,
        act: (UserManagementBloc bloc) async {
          bloc.add(
            const AssignUserToGroupEvent(groupId: 'groupId', userId: 'userId'),
          );
          when(() => mockAssignUserToGroup(any()))
              .thenAnswer((_) async => const Left(UnsuspectedFailure()));
        },
        skip: 1,
        verify: (_) =>
            verify(() => mockAssignUserToGroup(tUserAndGroupParams)).called(1),
        expect: () => [isA<UserManagementError>()],
      );

      blocTest(
        'should emit [UserManagementError] when usecase returns [DatabaseFailure]',
        build: () => userManagementBloc,
        act: (UserManagementBloc bloc) async {
          bloc.add(
            const AssignUserToGroupEvent(groupId: 'groupId', userId: 'userId'),
          );
          when(() => mockAssignUserToGroup(any()))
              .thenAnswer((_) async => const Left(UnsuspectedFailure()));
        },
        skip: 1,
        verify: (_) =>
            verify(() => mockAssignUserToGroup(tUserAndGroupParams)).called(1),
        expect: () => [isA<UserManagementError>()],
      );

      blocTest(
        'should emit [UserManagementSuccess] when usecase returns [VoidResult]',
        build: () => userManagementBloc,
        act: (UserManagementBloc bloc) async {
          bloc.add(
            const AssignUserToGroupEvent(groupId: 'groupId', userId: 'userId'),
          );
          when(() => mockAssignUserToGroup(any()))
              .thenAnswer((_) async => Right(VoidResult()));
        },
        skip: 1,
        verify: (_) =>
            verify(() => mockAssignUserToGroup(tUserAndGroupParams)).called(1),
        expect: () => [isA<UserManagementSuccessful>()],
      );
    });

    group('UnassignUserFromGroup', () {
      blocTest(
        'should emit [UserManagementError] when usecase returns [UnsuspectedFailure]',
        build: () => userManagementBloc,
        act: (UserManagementBloc bloc) async {
          bloc.add(
            const UnassignUserFromGroupEvent(
                groupId: 'groupId', userId: 'userId'),
          );
          when(() => mockUnassignUserFromGroup(any()))
              .thenAnswer((_) async => const Left(UnsuspectedFailure()));
        },
        skip: 1,
        verify: (_) =>
            verify(() => mockUnassignUserFromGroup(tUserAndGroupParams))
                .called(1),
        expect: () => [isA<UserManagementError>()],
      );

      blocTest(
        'should emit [UserManagementError] when usecase returns [DatabaseFailure]',
        build: () => userManagementBloc,
        act: (UserManagementBloc bloc) async {
          bloc.add(
            const UnassignUserFromGroupEvent(
                groupId: 'groupId', userId: 'userId'),
          );
          when(() => mockUnassignUserFromGroup(any()))
              .thenAnswer((_) async => const Left(UnsuspectedFailure()));
        },
        skip: 1,
        verify: (_) =>
            verify(() => mockUnassignUserFromGroup(tUserAndGroupParams))
                .called(1),
        expect: () => [isA<UserManagementError>()],
      );

      blocTest(
        'should emit [UserManagementSuccess] when usecase returns [VoidResult]',
        build: () => userManagementBloc,
        act: (UserManagementBloc bloc) async {
          bloc.add(
            const UnassignUserFromGroupEvent(
                groupId: 'groupId', userId: 'userId'),
          );
          when(() => mockUnassignUserFromGroup(any()))
              .thenAnswer((_) async => Right(VoidResult()));
        },
        skip: 1,
        verify: (_) =>
            verify(() => mockUnassignUserFromGroup(tUserAndGroupParams))
                .called(1),
        expect: () => [isA<UserManagementSuccessful>()],
      );
    });

    group('AssignGroupAdmin', () {
      blocTest(
        'should emit [UserManagementError] when usecase returns [UnsuspectedFailure]',
        build: () => userManagementBloc,
        act: (UserManagementBloc bloc) async {
          bloc.add(
            const AssignGroupAdminEvent(
              groupId: 'groupId',
              userId: 'userId',
              companyId: 'companyId',
            ),
          );
          when(() => mockAssignGroupAdmin(any()))
              .thenAnswer((_) async => const Left(UnsuspectedFailure()));
        },
        skip: 1,
        verify: (_) =>
            verify(() => mockAssignGroupAdmin(tAssignGroupAdminParams))
                .called(1),
        expect: () => [isA<UserManagementError>()],
      );

      blocTest(
        'should emit [UserManagementError] when usecase returns [DatabaseFailure]',
        build: () => userManagementBloc,
        act: (UserManagementBloc bloc) async {
          bloc.add(
            const AssignGroupAdminEvent(
              groupId: 'groupId',
              userId: 'userId',
              companyId: 'companyId',
            ),
          );
          when(() => mockAssignGroupAdmin(any()))
              .thenAnswer((_) async => const Left(UnsuspectedFailure()));
        },
        skip: 1,
        verify: (_) =>
            verify(() => mockAssignGroupAdmin(tAssignGroupAdminParams))
                .called(1),
        expect: () => [isA<UserManagementError>()],
      );

      blocTest(
        'should emit [UserManagementSuccess] when usecase returns [VoidResult]',
        build: () => userManagementBloc,
        act: (UserManagementBloc bloc) async {
          bloc.add(
            const AssignGroupAdminEvent(
              groupId: 'groupId',
              userId: 'userId',
              companyId: 'companyId',
            ),
          );
          when(() => mockAssignGroupAdmin(any()))
              .thenAnswer((_) async => Right(VoidResult()));
        },
        skip: 1,
        verify: (_) =>
            verify(() => mockAssignGroupAdmin(tAssignGroupAdminParams))
                .called(1),
        expect: () => [isA<UserManagementSuccessful>()],
      );
    });

    group('UnassignGroupAdmin', () {
      blocTest(
        'should emit [UserManagementError] when usecase returns [UnsuspectedFailure]',
        build: () => userManagementBloc,
        act: (UserManagementBloc bloc) async {
          bloc.add(
            const UnassignGroupAdminEvent(
              groupId: 'groupId',
              userId: 'userId',
              companyId: 'companyId',
            ),
          );
          when(() => mockUnassignGroupAdmin(any()))
              .thenAnswer((_) async => const Left(UnsuspectedFailure()));
        },
        skip: 1,
        verify: (_) =>
            verify(() => mockUnassignGroupAdmin(tAssignGroupAdminParams))
                .called(1),
        expect: () => [isA<UserManagementError>()],
      );

      blocTest(
        'should emit [UserManagementError] when usecase returns [DatabaseFailure]',
        build: () => userManagementBloc,
        act: (UserManagementBloc bloc) async {
          bloc.add(
            const UnassignGroupAdminEvent(
              groupId: 'groupId',
              userId: 'userId',
              companyId: 'companyId',
            ),
          );
          when(() => mockUnassignGroupAdmin(any()))
              .thenAnswer((_) async => const Left(UnsuspectedFailure()));
        },
        skip: 1,
        verify: (_) =>
            verify(() => mockUnassignGroupAdmin(tAssignGroupAdminParams))
                .called(1),
        expect: () => [isA<UserManagementError>()],
      );

      blocTest(
        'should emit [UserManagementSuccess] when usecase returns [VoidResult]',
        build: () => userManagementBloc,
        act: (UserManagementBloc bloc) async {
          bloc.add(
            const UnassignGroupAdminEvent(
              groupId: 'groupId',
              userId: 'userId',
              companyId: 'companyId',
            ),
          );
          when(() => mockUnassignGroupAdmin(any()))
              .thenAnswer((_) async => Right(VoidResult()));
        },
        skip: 1,
        verify: (_) =>
            verify(() => mockUnassignGroupAdmin(tAssignGroupAdminParams))
                .called(1),
        expect: () => [isA<UserManagementSuccessful>()],
      );
    });
  });
}
