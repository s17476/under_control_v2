import 'package:equatable/equatable.dart';

class ItemReservation extends Equatable {
  final String id;
  final double ammount;
  final String taskId;
  final String taskTitle;
  final DateTime plannedUsedate;
  final String locationId;

  const ItemReservation({
    required this.id,
    required this.ammount,
    required this.taskId,
    required this.taskTitle,
    required this.plannedUsedate,
    required this.locationId,
  });

  @override
  List<Object> get props {
    return [
      id,
      ammount,
      taskId,
      taskTitle,
      plannedUsedate,
      locationId,
    ];
  }

  @override
  String toString() {
    return 'ItemReservation(id: $id, ammount: $ammount, taskId: $taskId, taskTitle: $taskTitle, plannedUsedate: $plannedUsedate, locationId: $locationId)';
  }
}
