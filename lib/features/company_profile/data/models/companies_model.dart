import 'package:under_control_v2/features/company_profile/domain/entities/company.dart';

import '../../domain/entities/companies.dart';

class CompaniesModel extends Companies {
  const CompaniesModel({
    required List<Company> data,
  }) : super(allCompanies: data);
}
