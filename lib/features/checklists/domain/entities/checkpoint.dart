import 'package:equatable/equatable.dart';

class Checkpoint extends Equatable {
  final String title;
  final bool isChecked;

  const Checkpoint({
    required this.title,
    required this.isChecked,
  });

  @override
  List<Object> get props => [title, isChecked];

  @override
  String toString() => 'Checkpoint(title: $title, isChecked: $isChecked)';
}
