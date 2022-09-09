import 'package:equatable/equatable.dart';

import 'package:under_control_v2/features/inventory/domain/entities/item.dart';

class ItemAction extends Equatable {
  final String id;
  final String title;
  final String description;
  final double ammount;
  final ItemUnit itemUnit;
  final String locationId;
  final DateTime date;
  final String taskId;
  final String itemId;

  const ItemAction({
    required this.id,
    required this.title,
    required this.description,
    required this.ammount,
    required this.itemUnit,
    required this.locationId,
    required this.date,
    this.taskId = '',
    required this.itemId,
  });

  @override
  List<Object> get props {
    return [
      id,
      title,
      description,
      ammount,
      itemUnit,
      locationId,
      date,
      taskId,
      itemId,
    ];
  }

  @override
  String toString() {
    return 'ItemAction(id: $id, title: $title, description: $description, ammount: $ammount, itemUnit: $itemUnit, locationId: $locationId, date: $date, taskId: $taskId, itemId: $itemId)';
  }
}
