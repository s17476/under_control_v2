import 'package:equatable/equatable.dart';

import 'checkpoint.dart';

class Checklist extends Equatable {
  final String title;
  final List<Checkpoint> allCheckPoints;

  const Checklist({
    required this.title,
    required this.allCheckPoints,
  });

  @override
  List<Object> get props => [title, allCheckPoints];

  @override
  String toString() =>
      'CheckList(title: $title, allCheckPoints: $allCheckPoints)';
}
