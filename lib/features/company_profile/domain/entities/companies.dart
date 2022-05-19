import 'package:equatable/equatable.dart';

import 'company.dart';

class Companies extends Equatable {
  final List<Company> data;

  const Companies({
    required this.data,
  });

  @override
  List<Object> get props => [data];

  @override
  String toString() => 'Companies(data: $data)';
}
