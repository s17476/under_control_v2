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
  final String msg;
  final bool err;
  const CompanyManagementError({
    this.msg = '',
    this.err = false,
  }) : super(
          message: msg,
          error: err,
        );
}

class CompanyManagementCompaniesLoaded extends CompanyManagementState {
  final Company? selectedCompany;
  final Companies companies;
  final String msg;
  final bool err;
  CompanyManagementCompaniesLoaded({
    this.selectedCompany,
    required this.companies,
    this.msg = '',
    this.err = false,
  }) : super(
          message: msg,
          error: err,
          properties: [companies, selectedCompany],
        );
}

class CompanyManagementLoading extends CompanyManagementState {}
