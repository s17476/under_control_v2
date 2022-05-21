part of 'company_profile_bloc.dart';

abstract class CompanyProfileState extends Equatable {
  const CompanyProfileState([this.properties = const []]);

  final List properties;

  @override
  List<Object> get props => [properties];
}

class EmptyCompanyProfileState extends CompanyProfileState {}

class Error extends CompanyProfileState {
  final String message;
  Error({
    required this.message,
  }) : super([message]);
}

class Loaded extends CompanyProfileState {
  final CompanyUsers companyUsers;
  final Company company;
  Loaded({
    required this.companyUsers,
    required this.company,
  }) : super([company, companyUsers]);
}

class Loading extends CompanyProfileState {}
