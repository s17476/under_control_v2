part of 'company_management_bloc.dart';

abstract class CompanyManagementState extends Equatable {
  const CompanyManagementState(
      {this.message = '', this.error = false, this.properties = const []});
  final String message;
  final bool error;
  final List properties;

  @override
  List<Object> get props => [message, error, properties];
}

class CompanyManagementEmpty extends CompanyManagementState {}

class CompanyManagementError extends CompanyManagementState {
  const CompanyManagementError({
    super.message,
    super.error,
  });
}

class CompanyManagementLoaded extends CompanyManagementState {
  const CompanyManagementLoaded({
    super.message,
    super.error,
  });
}

class CompanyManagementCompaniesLoaded extends CompanyManagementState {
  final Company? selectedCompany;
  final Companies companies;

  CompanyManagementCompaniesLoaded({
    this.selectedCompany,
    required this.companies,
    super.message,
    super.error,
  }) : super(
          properties: [companies, selectedCompany],
        );
}

class CompanyManagementLoading extends CompanyManagementState {}
