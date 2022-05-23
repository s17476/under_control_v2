import 'package:dartz/dartz.dart';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:under_control_v2/features/authentication/presentation/blocs/authentication/authentication_bloc.dart';
import 'package:under_control_v2/features/core/error/failures.dart';
import 'package:under_control_v2/features/core/usecases/usecase.dart';
import 'package:under_control_v2/features/user_profile/data/models/user_profile_model.dart';
import 'package:under_control_v2/features/user_profile/domain/entities/user_profile.dart';
import 'package:under_control_v2/features/user_profile/domain/usecases/add_user.dart';
import 'package:under_control_v2/features/user_profile/domain/usecases/assign_user_to_company.dart';
import 'package:under_control_v2/features/user_profile/domain/usecases/get_user_by_id.dart';
import 'package:under_control_v2/features/user_profile/domain/usecases/update_user_data.dart';
import 'package:under_control_v2/features/user_profile/presentation/blocs/user_profile/user_profile_bloc.dart';

class MockAuthenticationBloc extends Mock
    implements Stream<AuthenticationState>, AuthenticationBloc {}

class MockAddUser extends Mock implements AddUser {}

class MockAssignUserToCompany extends Mock implements AssignUserToCompany {}

class MockGetUserById extends Mock implements GetUserById {}

class MockUpdateUserData extends Mock implements UpdateUserData {}

void main() {
  late UserProfileBloc userProfileBloc;
  late MockAuthenticationBloc mockAuthenticationBloc;
  late MockAddUser mockAddUser;
  late MockAssignUserToCompany mockAssignUserToCompany;
  late MockGetUserById mockGetUserById;
  late MockUpdateUserData mockUpdateUserData;

  setUp(() {
    mockAuthenticationBloc = MockAuthenticationBloc();
    mockAddUser = MockAddUser();
    mockAssignUserToCompany = MockAssignUserToCompany();
    mockGetUserById = MockGetUserById();
    mockUpdateUserData = MockUpdateUserData();

    when(() => mockAuthenticationBloc.stream).thenAnswer(
      (_) => Stream.fromFuture(
        Future.value(
          EmptyAuthenticationState(),
        ),
      ),
    );

    userProfileBloc = UserProfileBloc(
      authenticationBloc: mockAuthenticationBloc,
      addUser: mockAddUser,
      assignUserToCompany: mockAssignUserToCompany,
      getUserById: mockGetUserById,
      updateUserData: mockUpdateUserData,
    );
  });

  setUpAll(() {
    registerFallbackValue(
      const UserProfile(
        id: 'id',
        firstName: 'firstName',
        lastName: 'lastName',
        email: 'email',
        phoneNumber: 'phoneNumber',
        avatarUrl: 'avatarUrl',
        userGroups: ['userGroups'],
        locations: ['locations'],
        companyId: 'companyId',
        approved: false,
        rejected: false,
        suspended: false,
        administrator: false,
      ),
    );
    registerFallbackValue(const AssignParams(companyId: '', userId: ''));
  });

  const UserProfileModel tUserProfileModel = UserProfileModel(
    id: 'id',
    firstName: 'firstName',
    lastName: 'lastName',
    email: 'email',
    phoneNumber: 'phoneNumber',
    avatarUrl: '',
    userGroups: [''],
    locations: [''],
    companyId: '',
    approved: false,
    rejected: false,
    suspended: false,
    administrator: false,
  );

  test(
    'should emit [Empty] as an initial state',
    () async {
      expect(userProfileBloc.state, EmptyUserProfileState());
    },
  );

  group('GetUserById usecase', () {
    blocTest(
      'should emit [UserProfileError] when usecase returns [UnsuspectedFailure]',
      build: () => userProfileBloc,
      act: (UserProfileBloc bloc) async {
        bloc.add(GetUserByIdEvent(userId: ''));
        when(() => mockGetUserById(any()))
            .thenAnswer((_) async => const Left(UnsuspectedFailure()));
      },
      skip: 1,
      verify: (_) => verify(() => mockGetUserById('')).called(1),
      expect: () => [isA<UserProfileError>()],
    );

    blocTest(
      'should emit [DatabaseError] when usecase returns [DatabaseError]',
      build: () => userProfileBloc,
      act: (UserProfileBloc bloc) async {
        bloc.add(GetUserByIdEvent(userId: ''));
        when(() => mockGetUserById(any()))
            .thenAnswer((_) async => const Left(DatabaseFailure()));
      },
      skip: 1,
      verify: (_) => verify(() => mockGetUserById('')).called(1),
      expect: () => [isA<DatabaseError>()],
    );

    blocTest(
      'should emit [NoCompany] when usecase returns [UserProfile] and companyId is empty',
      build: () => userProfileBloc,
      act: (UserProfileBloc bloc) async {
        bloc.add(GetUserByIdEvent(userId: ''));
        when(() => mockGetUserById(any())).thenAnswer(
          (_) async => const Right(tUserProfileModel),
        );
      },
      skip: 1,
      verify: (_) => verify(() => mockGetUserById('')).called(1),
      expect: () => [NoCompany(userProfile: tUserProfileModel)],
    );

    blocTest(
      'should emit [NotApproved] when usecase returns [UserProfile], companyId is not empty and approved is false',
      build: () => userProfileBloc,
      act: (UserProfileBloc bloc) async {
        bloc.add(GetUserByIdEvent(userId: ''));
        when(() => mockGetUserById(any())).thenAnswer(
          (_) async => Right(
            tUserProfileModel.copyWith(companyId: 'companyId'),
          ),
        );
      },
      skip: 1,
      verify: (_) => verify(() => mockGetUserById('')).called(1),
      expect: () => [
        NotApproved(
          userProfile: tUserProfileModel.copyWith(companyId: 'companyId'),
        )
      ],
    );

    blocTest(
      'should emit [Rejected] when usecase returns [UserProfile], companyId is not empty, approved is false and rejected is true',
      build: () => userProfileBloc,
      act: (UserProfileBloc bloc) async {
        bloc.add(GetUserByIdEvent(userId: ''));
        when(() => mockGetUserById(any())).thenAnswer(
          (_) async => Right(
            tUserProfileModel.copyWith(companyId: 'companyId', rejected: true),
          ),
        );
      },
      skip: 1,
      verify: (_) => verify(() => mockGetUserById('')).called(1),
      expect: () => [
        Rejected(
          userProfile: tUserProfileModel.copyWith(
              companyId: 'companyId', rejected: true),
        )
      ],
    );

    blocTest(
      'should emit [Suspended] when usecase returns [UserProfile], companyId is not empty, approved is false and suspended is true',
      build: () => userProfileBloc,
      act: (UserProfileBloc bloc) async {
        bloc.add(GetUserByIdEvent(userId: ''));
        when(() => mockGetUserById(any())).thenAnswer(
          (_) async => Right(
            tUserProfileModel.copyWith(companyId: 'companyId', suspended: true),
          ),
        );
      },
      skip: 1,
      verify: (_) => verify(() => mockGetUserById('')).called(1),
      expect: () => [
        Suspended(
          userProfile: tUserProfileModel.copyWith(
              companyId: 'companyId', suspended: true),
        )
      ],
    );

    blocTest(
      'should emit [Approved] when usecase returns [UserProfile], companyId is not empty, approved is true',
      build: () => userProfileBloc,
      act: (UserProfileBloc bloc) async {
        bloc.add(GetUserByIdEvent(userId: ''));
        when(() => mockGetUserById(any())).thenAnswer(
          (_) async => Right(
            tUserProfileModel.copyWith(companyId: 'companyId', approved: true),
          ),
        );
      },
      skip: 1,
      verify: (_) => verify(() => mockGetUserById('')).called(1),
      expect: () => [
        Approved(
          userProfile: tUserProfileModel.copyWith(
              companyId: 'companyId', approved: true),
        )
      ],
    );
  });

  group('AddUser usecase', () {
    blocTest(
      'should emit [DatabaseError] when usecase returns failure',
      build: () => userProfileBloc,
      act: (UserProfileBloc bloc) async {
        bloc.add(AddUserEvent(userProfile: tUserProfileModel));
        when(() => mockAddUser(any()))
            .thenAnswer((_) async => const Left(DatabaseFailure()));
      },
      skip: 1,
      verify: (_) => verify(() => mockAddUser(tUserProfileModel)).called(1),
      expect: () => [isA<DatabaseError>()],
    );
    blocTest(
      'should emit [NoCompany] when AddUser is called',
      build: () => userProfileBloc,
      act: (UserProfileBloc bloc) async {
        bloc.add(AddUserEvent(userProfile: tUserProfileModel));
        when(() => mockAddUser(any())).thenAnswer(
          (_) async => const Right('newId'),
        );
      },
      skip: 1,
      verify: (_) => verify(() => mockAddUser(tUserProfileModel)).called(1),
      expect: () => [
        NoCompany(userProfile: tUserProfileModel.copyWith(id: 'newId')),
      ],
    );
  });

  group('AssignUserToCompany usecase', () {
    blocTest(
      'should emit [DatabaseError] when usecase returns failure',
      build: () => userProfileBloc,
      act: (UserProfileBloc bloc) async {
        bloc.add(
          AssignToCompanyEvent(
              userProfile: tUserProfileModel, companyId: 'companyId'),
        );
        when(() => mockAssignUserToCompany(any()))
            .thenAnswer((_) async => const Left(DatabaseFailure()));
      },
      skip: 1,
      verify: (_) => verify(
        () => mockAssignUserToCompany(
          AssignParams(userId: tUserProfileModel.id, companyId: 'companyId'),
        ),
      ).called(1),
      expect: () => [isA<DatabaseError>()],
    );
    blocTest(
      'should emit [NotApproved] when AssignUserToCompany is called',
      build: () => userProfileBloc,
      act: (UserProfileBloc bloc) async {
        bloc.add(
          AssignToCompanyEvent(
              userProfile: tUserProfileModel, companyId: 'companyId'),
        );
        when(() => mockAssignUserToCompany(any())).thenAnswer(
          (_) async => Right(VoidResult()),
        );
      },
      skip: 1,
      verify: (_) => verify(
        () => mockAssignUserToCompany(
          AssignParams(userId: tUserProfileModel.id, companyId: 'companyId'),
        ),
      ).called(1),
      expect: () => [
        NotApproved(
          userProfile: tUserProfileModel.copyWith(companyId: 'companyId'),
        ),
      ],
    );
  });

  group('UpdateUserData usecase', () {
    blocTest(
      'should emit [DatabaseError] when usecase returns failure',
      build: () => userProfileBloc,
      act: (UserProfileBloc bloc) async {
        bloc.add(
          UpdateUserDataEvent(userProfile: tUserProfileModel),
        );
        when(() => mockUpdateUserData(any()))
            .thenAnswer((_) async => const Left(DatabaseFailure()));
      },
      skip: 1,
      verify: (_) => verify(
        () => mockUpdateUserData(tUserProfileModel),
      ).called(1),
      expect: () => [isA<DatabaseError>()],
    );
    blocTest(
      'should emit [Approved] containing updated user data when UpdateUserData is called',
      build: () => userProfileBloc,
      act: (UserProfileBloc bloc) async {
        bloc.add(
          UpdateUserDataEvent(
            userProfile: tUserProfileModel.copyWith(id: 'updatedId'),
          ),
        );
        when(() => mockUpdateUserData(any())).thenAnswer(
          (_) async => Right(VoidResult()),
        );
      },
      skip: 1,
      verify: (_) => verify(
        () => mockUpdateUserData(tUserProfileModel.copyWith(id: 'updatedId')),
      ).called(1),
      expect: () => [
        Approved(userProfile: tUserProfileModel.copyWith(id: 'updatedId')),
      ],
    );
  });

  // group('ApproveUser usecase', () {
  //   blocTest(
  //     'should emit [DatabaseError] when usecase returns failure',
  //     build: () => userProfileBloc,
  //     act: (UserProfileBloc bloc) async {
  //       bloc.add(
  //         ApproveUserEvent(userId: tUserProfileModel.id),
  //       );
  //       when(() => mockApproveUser(any())).thenAnswer(
  //         (_) async => const Left(DatabaseFailure()),
  //       );
  //     },
  //     verify: (_) => verify(
  //       () => mockApproveUser(tUserProfileModel.id),
  //     ).called(1),
  //     expect: () => [isA<DatabaseError>()],
  //   );

  //   blocTest(
  //     'should not emit new state when ApproveUser is called',
  //     build: () => userProfileBloc,
  //     act: (UserProfileBloc bloc) async {
  //       bloc.add(
  //         ApproveUserEvent(userId: tUserProfileModel.id),
  //       );
  //       when(() => mockApproveUser(any())).thenAnswer(
  //         (_) async => Right(VoidResult()),
  //       );
  //     },
  //     verify: (_) => verify(
  //       () => mockApproveUser(tUserProfileModel.id),
  //     ).called(1),
  //     expect: () => [],
  //   );
  // });
}
