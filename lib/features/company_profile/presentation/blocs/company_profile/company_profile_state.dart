part of 'company_profile_bloc.dart';

abstract class CompanyProfileState extends Equatable {
  const CompanyProfileState({
    this.message = '',
    this.error = false,
    this.properties = const [],
  });
  final String message;
  final bool error;
  final List properties;

  @override
  List<Object> get props => [message, error, properties];
}

class CompanyProfileEmpty extends CompanyProfileState {}

class CompanyProfileError extends CompanyProfileState {
  const CompanyProfileError({
    super.message = '',
    super.error = false,
  });
}

class CompanyProfileLoaded extends CompanyProfileState {
  final CompanyUsersList companyUsers;
  final Company company;

  CompanyProfileLoaded({
    required this.companyUsers,
    required this.company,
    super.message = '',
    super.error = false,
  }) : super(
          properties: [companyUsers, company],
        );

  UserProfile? getUserById(String id) {
    final index = companyUsers.activeUsers.indexWhere((usr) => usr.id == id);
    if (index >= 0) {
      return companyUsers.activeUsers[index];
    }
    return null;
  }

  List<UserProfile> get allUsers =>
      [...companyUsers.activeUsers, ...companyUsers.passiveUsers];
}

class CompanyProfileLoading extends CompanyProfileState {}
