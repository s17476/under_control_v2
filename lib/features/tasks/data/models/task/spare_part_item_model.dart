import 'package:under_control_v2/features/tasks/domain/entities/task/spare_part_item.dart';

class SparePartItemModel extends SparePartItem {
  const SparePartItemModel({
    required super.itemId,
    required super.locationId,
    required super.quantity,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'itemId': itemId});
    result.addAll({'locationId': itemId});
    result.addAll({'quantity': quantity});

    return result;
  }

  factory SparePartItemModel.fromMap(Map<String, dynamic> map) {
    return SparePartItemModel(
      itemId: map['itemId'] ?? '',
      locationId: map['locationId'] ?? '',
      quantity: map['quantity']?.toDouble() ?? 0.0,
    );
  }
}
