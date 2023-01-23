import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:under_control_v2/features/authentication/presentation/blocs/authentication/authentication_bloc.dart';
import 'package:under_control_v2/features/company_profile/data/models/company_model.dart';
import 'package:under_control_v2/features/company_profile/data/models/company_users_model.dart';
import 'package:under_control_v2/features/company_profile/domain/usecases/fetch_all_company_users.dart';
import 'package:under_control_v2/features/company_profile/domain/usecases/get_company_by_id.dart';
import 'package:under_control_v2/features/company_profile/presentation/blocs/company_profile/company_profile_bloc.dart';
import 'package:under_control_v2/features/core/error/failures.dart';
import 'package:under_control_v2/features/core/utils/input_validator.dart';
import 'package:under_control_v2/features/user_profile/presentation/blocs/user_profile/user_profile_bloc.dart';

class MockFetchAllCompanyUsers extends Mock implements FetchAllCompanyUsers {}

class MockGetCompanyById extends Mock implements GetCompanyById {}

class MockUserProfileBloc extends Mock
    implements Stream<UserProfileState>, UserProfileBloc {}

class MockAuthenticationBloc extends Mock
    implements Stream<AuthenticationState>, AuthenticationBloc {}

class MockInputValidator extends Mock implements InputValidator {}

void main() {
  late MockAuthenticationBloc mockAuthenticationBloc;
  late CompanyProfileBloc companyProfileBloc;
  late MockFetchAllCompanyUsers mockFetchAllCompanyUsers;
  late MockGetCompanyById mockGetCompanyById;
  late MockUserProfileBloc mockUserProfileBloc;
  late MockInputValidator mockInputValidator;

  setUp(() {
    mockUserProfileBloc = MockUserProfileBloc();
    mockFetchAllCompanyUsers = MockFetchAllCompanyUsers();
    mockGetCompanyById = MockGetCompanyById();
    mockInputValidator = MockInputValidator();

    when(() => mockUserProfileBloc.stream)
        .thenAnswer((_) => Stream.fromFuture(Future.value(UserProfileEmpty())));
    mockAuthenticationBloc = MockAuthenticationBloc();
    when(() => mockAuthenticationBloc.stream).thenAnswer(
      (_) => Stream.fromFuture(
        Future.value(EmptyAuthenticationState()),
      ),
    );

    companyProfileBloc = CompanyProfileBloc(
      authenticationBloc: mockAuthenticationBloc,
      userProfileBloc: mockUserProfileBloc,
      fetchAllCompanyUsers: mockFetchAllCompanyUsers,
      getCompanyById: mockGetCompanyById,
      inputValidator: mockInputValidator,
    );
  });

  setUpAll(() {
    registerFallbackValue(CompanyModel.initial());
  });

  final tCompany = CompanyModel.initial();

  final tCompanyUsers = CompanyUsersModel(allUsers: Stream.fromIterable([]));

  group('Company Profile BLoC', () {
    test(
      'should emit [CompanyProfileEmpty] as an initila state',
      () async {
        // assert
        expect(companyProfileBloc.state, CompanyProfileEmpty());
      },
    );

    group('GetCompanyById', () {
      blocTest(
        'should emit [CompanyProfileLoaded] when getCompanyById and fetchAllCompanyUsers returns data',
        build: () => companyProfileBloc,
        act: (CompanyProfileBloc bloc) async {
          bloc.add(GetCompanyByIdEvent(id: ''));
          when(() => mockGetCompanyById(any()))
              .thenAnswer((_) async => Right(tCompany));
          when(() => mockFetchAllCompanyUsers(any()))
              .thenAnswer((_) async => Right(tCompanyUsers));
        },
        skip: 1,
        // verify: (_) => verify(() => mockUpdateCompany(any())).called(1),
        expect: () => [],
      );
      blocTest(
        'should emit [CompanyProfileError] when getCompanyById fails',
        build: () => companyProfileBloc,
        act: (CompanyProfileBloc bloc) async {
          bloc.add(GetCompanyByIdEvent(id: ''));
          when(() => mockGetCompanyById(any()))
              .thenAnswer((_) async => const Left((DatabaseFailure())));
          when(() => mockFetchAllCompanyUsers(any()))
              .thenAnswer((_) async => Right(tCompanyUsers));
        },
        skip: 1,
        expect: () => [isA<CompanyProfileError>()],
      );
      blocTest(
        'should emit [CompanyProfileError] when fetchAllCompanies fails',
        build: () => companyProfileBloc,
        act: (CompanyProfileBloc bloc) async {
          bloc.add(GetCompanyByIdEvent(id: ''));
          when(() => mockGetCompanyById(any()))
              .thenAnswer((_) async => Right(tCompany));
          when(() => mockFetchAllCompanyUsers(any()))
              .thenAnswer((_) async => const Left((DatabaseFailure())));
        },
        skip: 1,
        expect: () => [isA<CompanyProfileError>()],
      );
      blocTest(
        'should emit [CompanyProfileError] when fetchAllCompanies and getUserById fails',
        build: () => companyProfileBloc,
        act: (CompanyProfileBloc bloc) async {
          bloc.add(GetCompanyByIdEvent(id: ''));
          when(() => mockGetCompanyById(any()))
              .thenAnswer((_) async => const Left((DatabaseFailure())));
          when(() => mockFetchAllCompanyUsers(any()))
              .thenAnswer((_) async => const Left((DatabaseFailure())));
        },
        skip: 1,
        expect: () => [isA<CompanyProfileError>()],
      );
    });
  });
}
