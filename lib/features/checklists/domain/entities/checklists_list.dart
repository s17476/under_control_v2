import 'package:equatable/equatable.dart';

import 'checklist.dart';

class ChecklistsList extends Equatable {
  final List<Checklist> allChecklists;

  const ChecklistsList({
    required this.allChecklists,
  });

  @override
  List<Object> get props => [allChecklists];

  @override
  String toString() => 'ChecklistsList(allChecklists: $allChecklists)';
}
