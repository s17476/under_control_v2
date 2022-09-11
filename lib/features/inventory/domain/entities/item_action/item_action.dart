import 'package:equatable/equatable.dart';

import 'package:under_control_v2/features/inventory/domain/entities/item.dart';

enum ItemActionType {
  add('add'),
  remove('remove'),
  move('move'),
  unknown('');

  final String name;

  const ItemActionType(this.name);

  factory ItemActionType.fromString(String name) {
    switch (name) {
      case 'add':
        return ItemActionType.add;
      case 'remove':
        return ItemActionType.remove;
      case 'move':
        return ItemActionType.move;
      default:
        return ItemActionType.unknown;
    }
  }
}

class ItemAction extends Equatable {
  final String id;
  final ItemActionType type;
  final String description;
  final double ammount;
  final ItemUnit itemUnit;
  final String locationId;
  final DateTime date;
  final String taskId;
  final String itemId;

  const ItemAction({
    required this.id,
    required this.type,
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
      type,
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
    return 'ItemAction(id: $id, type: $type, description: $description, ammount: $ammount, itemUnit: $itemUnit, locationId: $locationId, date: $date, taskId: $taskId, itemId: $itemId)';
  }
}
