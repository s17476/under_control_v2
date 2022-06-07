part of 'company_profile_bloc.dart';

abstract class CompanyProfileEvent extends Equatable {
  const CompanyProfileEvent([this.properties = const []]);

  final List properties;

  @override
  List<Object> get props => [properties];
}

class GetCompanyByIdEvent extends CompanyProfileEvent {
  final String id;
  GetCompanyByIdEvent({
    required this.id,
  }) : super([id]);
}

class UpdateCompanyUsersEvent extends CompanyProfileEvent {
  final Company company;
  final QuerySnapshot<Object?> snapshot;
  UpdateCompanyUsersEvent({
    required this.company,
    required this.snapshot,
  }) : super([company, snapshot]);
}

class UpdateCompanyEvent extends CompanyProfileEvent {
  UpdateCompanyEvent({required this.company}) : super([company]);

  final Company company;
}
