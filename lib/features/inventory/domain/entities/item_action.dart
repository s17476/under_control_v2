import 'package:equatable/equatable.dart';

class ItemAction extends Equatable {
  final String id;
  final String title;
  final String description;
  final double ammount;
  final String locationId;
  final DateTime date;
  final String taskId;

  const ItemAction({
    required this.id,
    required this.title,
    required this.description,
    required this.ammount,
    required this.locationId,
    required this.date,
    required this.taskId,
  });

  @override
  List<Object> get props {
    return [
      id,
      title,
      description,
      ammount,
      locationId,
      date,
      taskId,
    ];
  }

  @override
  String toString() {
    return 'ItemAction(id: $id, title: $title, description: $description, ammount: $ammount, locationId: $locationId, date: $date, taskId: $taskId)';
  }
}
