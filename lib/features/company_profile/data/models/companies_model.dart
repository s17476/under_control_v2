import '../../domain/entities/companies.dart';
import '../../domain/entities/company.dart';

class CompaniesModel extends Companies {
  const CompaniesModel({
    required List<Company> data,
  }) : super(allCompanies: data);
}
