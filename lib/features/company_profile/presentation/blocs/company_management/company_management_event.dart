part of 'company_management_bloc.dart';

abstract class CompanyManagementEvent extends Equatable {
  const CompanyManagementEvent([this.properties = const []]);

  final List properties;

  @override
  List<Object> get props => [properties];
}

class FetchAllCompaniesEvent extends CompanyManagementEvent {}

class AddCompanyEvent extends CompanyManagementEvent {
  final Company company;
  final Companies companies;

  AddCompanyEvent({
    required this.company,
    required this.companies,
  }) : super([company, companies]);
}

class AddCompanyLogoEvent extends CompanyManagementEvent {
  final Company company;
  final File? logo;

  AddCompanyLogoEvent({
    required this.company,
    this.logo,
  }) : super([company, logo]);
}

class UpdateCompanyDataEvent extends CompanyManagementEvent {
  final Company company;

  UpdateCompanyDataEvent({
    required this.company,
  }) : super([company]);
}
