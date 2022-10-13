import '../../domain/entities/item.dart';
import 'item_amount_in_location_model.dart';

class ItemModel extends Item {
  const ItemModel({
    required super.id,
    required super.producer,
    required super.name,
    required super.description,
    required super.category,
    required super.price,
    required super.itemPhoto,
    required super.itemCode,
    required super.itemBarCode,
    required super.sparePartFor,
    required super.itemUnit,
    required super.locations,
    required super.amountInLocations,
  });

  ItemModel copyWith({
    String? id,
    String? producer,
    String? name,
    String? description,
    String? category,
    double? price,
    String? itemPhoto,
    String? itemCode,
    String? itemBarCode,
    List<String>? sparePartFor,
    ItemUnit? itemUnit,
    List<String>? locations,
    List<ItemAmountInLocationModel>? amountInLocations,
  }) {
    return ItemModel(
      id: id ?? this.id,
      producer: producer ?? this.producer,
      name: name ?? this.name,
      description: description ?? this.description,
      category: category ?? this.category,
      price: price ?? this.price,
      itemPhoto: itemPhoto ?? this.itemPhoto,
      itemCode: itemCode ?? this.itemCode,
      itemBarCode: itemBarCode ?? this.itemBarCode,
      sparePartFor: sparePartFor ?? this.sparePartFor,
      itemUnit: itemUnit ?? this.itemUnit,
      locations: locations ?? this.locations,
      amountInLocations: amountInLocations ?? this.amountInLocations,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'producer': producer});
    result.addAll({'name': name});
    result.addAll({'description': description});
    result.addAll({'category': category});
    result.addAll({'price': price});
    result.addAll({'itemPhoto': itemPhoto});
    result.addAll({'itemCode': itemCode});
    result.addAll({'itemBarCode': itemBarCode});
    result.addAll({'sparePartFor': sparePartFor});
    result.addAll({'itemUnit': itemUnit.name});
    result.addAll({'locations': locations});
    result.addAll({
      'amountInLocations': amountInLocations.map((x) => x.toMap()).toList()
    });

    return result;
  }

  factory ItemModel.fromMap(Map<String, dynamic> map, String id) {
    return ItemModel(
      id: id,
      producer: map['producer'] ?? '',
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      category: map['category'] ?? '',
      price: map['price'] ?? '',
      itemPhoto: map['itemPhoto'] ?? '',
      itemCode: map['itemCode'] ?? '',
      itemBarCode: map['itemBarCode'] ?? '',
      sparePartFor: List<String>.from(map['sparePartFor']),
      itemUnit: ItemUnit.fromString(map['itemUnit']),
      locations: List<String>.from(map['locations']),
      amountInLocations: List<ItemAmountInLocationModel>.from(
          map['amountInLocations']
              ?.map((x) => ItemAmountInLocationModel.fromMap(x))),
    );
  }

  ItemModel deepCopy() {
    return copyWith(
      sparePartFor: [...sparePartFor],
      locations: [...locations],
      amountInLocations: amountInLocations
          .map((ItemAmountInLocationModel e) => e.copyWith())
          .toList(),
    );
  }
}
