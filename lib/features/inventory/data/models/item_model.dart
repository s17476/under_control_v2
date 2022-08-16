import 'package:under_control_v2/features/inventory/data/models/item_amount_in_location_model.dart';

import '../../domain/entities/item.dart';
import '../../domain/entities/item_amount_in_location.dart';

class ItemModel extends Item {
  const ItemModel({
    required super.id,
    required super.name,
    required super.description,
    required super.itemPhoto,
    required super.itemUnit,
    required super.locations,
    required super.amountInLocations,
  });

  ItemModel copyWith({
    String? id,
    String? name,
    String? description,
    String? itemPhoto,
    ItemUnit? itemUnit,
    List<String>? locations,
    List<ItemAmountInLocation>? amountInLocations,
  }) {
    return ItemModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      itemPhoto: itemPhoto ?? this.itemPhoto,
      itemUnit: itemUnit ?? this.itemUnit,
      locations: locations ?? this.locations,
      amountInLocations: amountInLocations ?? this.amountInLocations,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'name': name});
    result.addAll({'description': description});
    result.addAll({'itemPhoto': itemPhoto});
    result.addAll({'itemUnit': itemUnit.name});
    result.addAll({'locations': locations});
    result.addAll({
      'amountInLocations': amountInLocations
          .map((x) => (x as ItemAmountInLocationModel).toMap())
          .toList()
    });

    return result;
  }

  factory ItemModel.fromMap(Map<String, dynamic> map, String id) {
    return ItemModel(
      id: id,
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      itemPhoto: map['itemPhoto'] ?? '',
      itemUnit: ItemUnit.fromString(map['itemUnit']),
      locations: List<String>.from(map['locations']),
      amountInLocations: List<ItemAmountInLocation>.from(
          map['amountInLocations']
              ?.map((x) => ItemAmountInLocationModel.fromMap(x))),
    );
  }
}
