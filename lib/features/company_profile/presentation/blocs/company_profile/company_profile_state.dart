part of 'company_profile_bloc.dart';

abstract class CompanyProfileState extends Equatable {
  const CompanyProfileState(
      {this.message = '', this.error = false, this.properties = const []});
  final String message;
  final bool error;
  final List properties;

  @override
  List<Object> get props => [message, error, properties];
}

class CompanyProfileEmpty extends CompanyProfileState {}

class CompanyProfileError extends CompanyProfileState {
  final String msg;
  final bool err;
  const CompanyProfileError({
    this.msg = '',
    this.err = false,
  }) : super(
          message: msg,
          error: err,
        );
}

class CompanyProfileLoaded extends CompanyProfileState {
  final CompanyUsersList companyUsers;
  final Company company;
  final String msg;
  final bool err;
  CompanyProfileLoaded({
    required this.companyUsers,
    required this.company,
    this.msg = '',
    this.err = false,
  }) : super(
          message: msg,
          error: err,
          properties: [companyUsers, company],
        );
}

class CompanyProfileLoading extends CompanyProfileState {}
