import 'package:equatable/equatable.dart';

import 'company.dart';

class Companies extends Equatable {
  final List<Company> allCompanies;

  const Companies({
    required this.allCompanies,
  });

  @override
  List<Object> get props => [allCompanies];

  @override
  String toString() => 'Companies(data: $allCompanies)';
}
