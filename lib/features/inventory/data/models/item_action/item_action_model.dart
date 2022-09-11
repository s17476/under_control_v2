import 'package:under_control_v2/features/inventory/domain/entities/item_action/item_action.dart';

import '../../../domain/entities/item.dart';

class ItemActionModel extends ItemAction {
  const ItemActionModel({
    required super.id,
    required super.type,
    required super.description,
    required super.ammount,
    required super.itemUnit,
    required super.locationId,
    required super.date,
    required super.itemId,
    super.taskId,
  });

  ItemActionModel copyWith({
    String? id,
    ItemActionType? type,
    String? description,
    double? ammount,
    ItemUnit? itemUnit,
    String? locationId,
    DateTime? date,
    String? taskId,
    String? itemId,
  }) {
    return ItemActionModel(
      id: id ?? this.id,
      type: type ?? this.type,
      description: description ?? this.description,
      ammount: ammount ?? this.ammount,
      itemUnit: itemUnit ?? this.itemUnit,
      locationId: locationId ?? this.locationId,
      date: date ?? this.date,
      taskId: taskId ?? this.taskId,
      itemId: itemId ?? this.itemId,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'type': type.name});
    result.addAll({'description': description});
    result.addAll({'ammount': ammount});
    result.addAll({'itemUnit': itemUnit.name});
    result.addAll({'locationId': locationId});
    result.addAll({'date': date.toIso8601String()});
    result.addAll({'taskId': taskId});
    result.addAll({'itemId': itemId});

    return result;
  }

  factory ItemActionModel.fromMap(
    Map<String, dynamic> map,
    String id,
  ) {
    return ItemActionModel(
      id: id,
      type: ItemActionType.fromString(map['type']),
      description: map['description'] ?? '',
      ammount: map['ammount']?.toDouble() ?? 0.0,
      itemUnit: ItemUnit.fromString(map['itemUnit']),
      locationId: map['locationId'] ?? '',
      date: DateTime.parse(map['date']),
      taskId: map['taskId'] ?? '',
      itemId: map['itemId'] ?? '',
    );
  }
}
