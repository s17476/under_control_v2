import 'package:equatable/equatable.dart';

import '../../data/models/checkpoint_model.dart';

class Checklist extends Equatable {
  final String id;
  final String title;
  final List<CheckpointModel> allCheckpoints;

  const Checklist({
    required this.id,
    required this.title,
    required this.allCheckpoints,
  });

  @override
  List<Object> get props => [id, title, allCheckpoints];

  @override
  String toString() =>
      'Checklist(id: $id, title: $title, allCheckPoints: $allCheckpoints)';
}
