import 'package:equatable/equatable.dart';

import '../../data/models/checkpoint_model.dart';

class Checklist extends Equatable {
  final String id;
  final String title;
  final String description;
  final List<CheckpointModel> allCheckpoints;

  const Checklist({
    required this.id,
    required this.title,
    required this.description,
    required this.allCheckpoints,
  });

  @override
  List<Object> get props => [id, title, description, allCheckpoints];

  @override
  String toString() {
    return 'Checklist(id: $id, title: $title, description: $description, allCheckpoints: $allCheckpoints)';
  }
}
