import 'package:flutter_test/flutter_test.dart';
import 'package:under_control_v2/features/company_profile/data/models/companies_model.dart';
import 'package:under_control_v2/features/company_profile/data/models/company_model.dart';
import 'package:under_control_v2/features/company_profile/domain/entities/companies.dart';

void main() {
  final tCompany = CompanyModel.initial();
  final tCompanies = CompaniesModel(data: [tCompany]);

  test(
    'should be a subclass of [Companies] entity',
    () async {
      // assert
      expect(tCompanies, isA<Companies>());
    },
  );
}
