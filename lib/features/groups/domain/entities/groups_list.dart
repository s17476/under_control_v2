import 'package:equatable/equatable.dart';

import 'group.dart';

class GroupsList extends Equatable {
  final List<Group> allGroups;

  const GroupsList({
    required this.allGroups,
  });

  @override
  List<Object> get props => [allGroups];

  @override
  String toString() => 'GroupsList(allGroups: $allGroups)';
}
