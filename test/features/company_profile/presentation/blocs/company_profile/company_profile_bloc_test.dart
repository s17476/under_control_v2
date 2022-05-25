import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:under_control_v2/features/company_profile/data/models/company_model.dart';
import 'package:under_control_v2/features/company_profile/data/models/company_users_model.dart';
import 'package:under_control_v2/features/company_profile/domain/usecases/fetch_all_company_users.dart';
import 'package:under_control_v2/features/company_profile/domain/usecases/get_company_by_id.dart';
import 'package:under_control_v2/features/company_profile/domain/usecases/update_company.dart';
import 'package:under_control_v2/features/company_profile/presentation/blocs/company_profile/company_profile_bloc.dart';
import 'package:under_control_v2/features/core/utils/input_validator.dart';
import 'package:under_control_v2/features/user_profile/presentation/blocs/user_profile/user_profile_bloc.dart';

class MockUpdateCompany extends Mock implements UpdateCompany {}

class MockFetchAllCompanyUsers extends Mock implements FetchAllCompanyUsers {}

class MockGetCompanyById extends Mock implements GetCompanyById {}

class MockUserProfileBloc extends Mock
    implements Stream<UserProfileState>, UserProfileBloc {}

class MockInputValidator extends Mock implements InputValidator {}

void main() {
  late CompanyProfileBloc companyProfileBloc;
  late MockUpdateCompany mockUpdateCompany;
  late MockFetchAllCompanyUsers mockFetchAllCompanyUsers;
  late MockGetCompanyById mockGetCompanyById;
  late MockUserProfileBloc mockUserProfileBloc;
  late MockInputValidator mockInputValidator;

  setUp(() {
    mockUserProfileBloc = MockUserProfileBloc();
    mockUpdateCompany = MockUpdateCompany();
    mockFetchAllCompanyUsers = MockFetchAllCompanyUsers();
    mockGetCompanyById = MockGetCompanyById();
    mockInputValidator = MockInputValidator();

    when(() => mockUserProfileBloc.stream)
        .thenAnswer((_) => Stream.fromFuture(Future.value(UserProfileEmpty())));

    companyProfileBloc = CompanyProfileBloc(
      userProfileBloc: mockUserProfileBloc,
      updateCompany: mockUpdateCompany,
      fetchAllCompanyUsers: mockFetchAllCompanyUsers,
      getCompanyById: mockGetCompanyById,
      inputValidator: mockInputValidator,
    );
  });

  final tCompany = CompanyModel.initial();

  final tCompanyUsers = CompanyUsersModel(allUsers: Stream.fromIterable([]));

  group('company profile', () {
    test(
      'should emit [CompanyProfileEmpty] as an initila state',
      () async {
        // assert
        expect(companyProfileBloc.state, CompanyProfileEmpty());
      },
    );

    // group('GetCompanyById', () {
    //   blocTest(
    //     'should emit [CompanyProfileLoaded] when getCompanyById and fetchAllCompanyUsers returns data',
    //     build: () => companyProfileBloc,
    //     act: (CompanyProfileBloc bloc) async {
    //       bloc.add(GetCompanyByIdEvent(id: ''));
    //       when(() => mockGetCompanyById(any()))
    //           .thenAnswer((_) async => Right(tCompany));
    //       when(() => mockFetchAllCompanyUsers(any()))
    //           .thenAnswer((_) async => Right(tCompanyUsers));
    //     },
    //     skip: 1,
    //     expect: () => isA<CompanyProfileLoaded>(),
    //   );
    // });
  });
}
