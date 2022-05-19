import 'package:equatable/equatable.dart';

class CompanyUser extends Equatable {
  final String id;
  final String firstName;
  final String lastName;
  final String avatarUrl;

  const CompanyUser({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.avatarUrl,
  });

  @override
  List<Object> get props => [id, firstName, lastName, avatarUrl];

  @override
  String toString() {
    return 'CompanyUser(id: $id, firstName: $firstName, lastName: $lastName, avatarUrl: $avatarUrl)';
  }
}
