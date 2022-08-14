import 'package:equatable/equatable.dart';

class ChecklistsStream extends Equatable {
  final Stream allChecklists;

  const ChecklistsStream({
    required this.allChecklists,
  });

  @override
  List<Object> get props => [allChecklists];

  @override
  String toString() => 'ChecklistsStream(allChecklists: $allChecklists)';
}
