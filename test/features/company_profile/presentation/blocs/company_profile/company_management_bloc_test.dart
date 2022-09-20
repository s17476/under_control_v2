import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:under_control_v2/features/company_profile/data/models/companies_model.dart';
import 'package:under_control_v2/features/company_profile/data/models/company_model.dart';
import 'package:under_control_v2/features/company_profile/domain/entities/company.dart';
import 'package:under_control_v2/features/company_profile/domain/usecases/add_company.dart';
import 'package:under_control_v2/features/company_profile/domain/usecases/add_company_logo.dart';
import 'package:under_control_v2/features/company_profile/domain/usecases/fetch_all_companies.dart';
import 'package:under_control_v2/features/company_profile/domain/usecases/update_company.dart';
import 'package:under_control_v2/features/company_profile/presentation/blocs/company_management/company_management_bloc.dart';
import 'package:under_control_v2/features/core/error/failures.dart';
import 'package:under_control_v2/features/core/usecases/usecase.dart';
import 'package:under_control_v2/features/core/utils/input_validator.dart';
import 'package:under_control_v2/features/user_profile/presentation/blocs/user_profile/user_profile_bloc.dart';

class MockAddCompany extends Mock implements AddCompany {}

class MockFetchAllCompanies extends Mock implements FetchAllCompanies {}

class MockAddCompanyLogo extends Mock implements AddCompanyLogo {}

class MockUpdateCompany extends Mock implements UpdateCompany {}

class MockUserProfileBloc extends Mock
    implements Stream<UserProfileState>, UserProfileBloc {}

class MockInputValidator extends Mock implements InputValidator {}

void main() {
  late CompanyManagementBloc companyManagementBloc;
  late MockAddCompany mockAddCompany;
  late MockAddCompanyLogo mockAddCompanyLogo;
  late MockUpdateCompany mockUpdateCompany;
  late MockFetchAllCompanies mockFetchAllCompanies;
  late MockUserProfileBloc mockUserProfileBloc;
  late MockInputValidator mockInputValidator;

  setUp(() {
    mockUserProfileBloc = MockUserProfileBloc();
    mockAddCompanyLogo = MockAddCompanyLogo();
    mockAddCompany = MockAddCompany();
    mockFetchAllCompanies = MockFetchAllCompanies();
    mockUpdateCompany = MockUpdateCompany();
    mockInputValidator = MockInputValidator();

    when(() => mockUserProfileBloc.stream)
        .thenAnswer((_) => Stream.fromFuture(Future.value(UserProfileEmpty())));

    companyManagementBloc = CompanyManagementBloc(
      updateCompany: mockUpdateCompany,
      userProfileBloc: mockUserProfileBloc,
      inputValidator: mockInputValidator,
      addCompany: mockAddCompany,
      fetchAllCompanies: mockFetchAllCompanies,
      addCompanyLogo: mockAddCompanyLogo,
    );
  });

  setUpAll(() {
    registerFallbackValue(NoParams());
    registerFallbackValue(
      Company(
        id: 'id',
        name: 'name',
        address: 'address',
        postCode: 'postCode',
        city: 'city',
        country: 'country',
        currency: 'currency',
        vatNumber: 'vatNumber',
        phoneNumber: 'phoneNumber',
        email: 'email',
        homepage: 'homepage',
        logo: 'logo',
        joinDate: DateTime.now(),
      ),
    );
  });

  final tCompany = CompanyModel.initial();

  final tCompanies = CompaniesModel(data: [tCompany]);

  group('Company Management BLoC', () {
    test(
      'should emit [CompanyManagementEmpty] as an initial state',
      () async {
        // assert
        expect(companyManagementBloc.state, CompanyManagementEmpty());
      },
    );

    group('FetchAllCompanies', () {
      blocTest(
        'should emit [CompanyManagementCompaniesLoaded] when fetchAllCompanies returns data',
        build: () => companyManagementBloc,
        act: (CompanyManagementBloc bloc) async {
          bloc.add(FetchAllCompaniesEvent());
          when(() => mockFetchAllCompanies(any()))
              .thenAnswer((_) async => Right(tCompanies));
        },
        skip: 1,
        expect: () => [CompanyManagementCompaniesLoaded(companies: tCompanies)],
      );

      blocTest(
        'should emit [CompanyManagementError] when fetchAllCompanies returns DatabaseFailure',
        build: () => companyManagementBloc,
        act: (CompanyManagementBloc bloc) async {
          bloc.add(FetchAllCompaniesEvent());
          when(() => mockFetchAllCompanies(any())).thenAnswer(
              (_) async => const Left(DatabaseFailure(message: 'failure')));
        },
        skip: 1,
        expect: () =>
            [const CompanyManagementError(message: 'failure', error: true)],
      );

      blocTest(
        'should emit [CompanyManagementError] when fetchAllCompanies returns UnsuspectedFailure',
        build: () => companyManagementBloc,
        act: (CompanyManagementBloc bloc) async {
          bloc.add(FetchAllCompaniesEvent());
          when(() => mockFetchAllCompanies(any())).thenAnswer(
              (_) async => const Left(UnsuspectedFailure(message: 'failure')));
        },
        skip: 1,
        expect: () =>
            [const CompanyManagementError(message: 'failure', error: true)],
      );
    });

    group('AddCompany', () {
      blocTest(
        'should emit [CompanyManagementCompaniesLoaded] when addCompany returns data',
        build: () => companyManagementBloc,
        act: (CompanyManagementBloc bloc) async {
          bloc.add(AddCompanyEvent(company: tCompany, companies: tCompanies));
          when(() => mockAddCompany(any()))
              .thenAnswer((_) async => const Right('newId'));
        },
        skip: 1,
        expect: () => [isA<CompanyManagementCompaniesLoaded>()],
      );

      // blocTest(
      //   'should emit [CompanyManagementError] when addCompany returns DatabaseFailure',
      //   build: () => companyManagementBloc,
      //   act: (CompanyManagementBloc bloc) async {
      //     bloc.add(AddCompanyEvent(company: tCompany, companies: tCompanies));
      //     when(() => mockAddCompany(any())).thenAnswer(
      //         (_) async => const Left(DatabaseFailure(message: 'failure')));
      //   },
      //   skip: 1,
      //   expect: () => [const CompanyManagementError(msg: 'failure', err: true)],
      // );

      // blocTest(
      //   'should emit [CompanyManagementError] when fetchAllCompanies returns UnsuspectedFailure',
      //   build: () => companyManagementBloc,
      //   act: (CompanyManagementBloc bloc) async {
      //     bloc.add(AddCompanyEvent(company: tCompany, companies: tCompanies));
      //     when(() => mockAddCompany(any())).thenAnswer(
      //         (_) async => const Left(UnsuspectedFailure(message: 'failure')));
      //   },
      //   skip: 1,
      //   expect: () => [const CompanyManagementError(msg: 'failure', err: true)],
      // );
    });
  });
}
