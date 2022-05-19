import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:under_control_v2/features/company_profile/domain/usecases/add_company.dart';
import 'package:under_control_v2/features/company_profile/domain/usecases/fetch_all_companies.dart';
import 'package:under_control_v2/features/company_profile/domain/usecases/get_company_by_id.dart';
import 'package:under_control_v2/features/company_profile/domain/usecases/update_company.dart';
import 'package:under_control_v2/features/company_profile/presentation/blocs/company_profile/company_profile_bloc.dart';

class MockAddCompany extends Mock implements AddCompany {}

class MockUpdateCompany extends Mock implements UpdateCompany {}

class MockFetchAllCompanies extends Mock implements FetchAllCompanies {}

class MockGetCompanyById extends Mock implements GetCompanyById {}

class MockCompanyBloc extends MockBloc<CompanyProfileEvent, CompanyProfileState>
    implements CompanyProfileBloc {}

void main() {
  late MockAddCompany mockAddCompany;
  late MockUpdateCompany mockUpdateCompany;
  late MockFetchAllCompanies mockFetchAllCompanies;
  late MockGetCompanyById mockGetCompanyById;
  late MockCompanyBloc bloc;

  setUp(() {
    mockAddCompany = MockAddCompany();
    mockUpdateCompany = MockUpdateCompany();
    mockFetchAllCompanies = MockFetchAllCompanies();
    mockGetCompanyById = MockGetCompanyById();
  });

  // late MockCounterBloc mockCounterBlo
}
