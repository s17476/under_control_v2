import 'package:equatable/equatable.dart';

class GroupsStream extends Equatable {
  final Stream allGroups;

  const GroupsStream({
    required this.allGroups,
  });

  @override
  List<Object> get props => [allGroups];

  @override
  String toString() => 'GroupsStream(allGroups: $allGroups)';
}
