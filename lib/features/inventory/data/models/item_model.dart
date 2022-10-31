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
    required super.alertQuantity,
    required super.itemPhoto,
    required super.itemCode,
    required super.itemBarCode,
    required super.documents,
    required super.instructions,
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
    double? alertQuantity,
    String? itemPhoto,
    String? itemCode,
    String? itemBarCode,
    List<String>? documents,
    List<String>? instructions,
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
      alertQuantity: alertQuantity ?? this.alertQuantity,
      itemPhoto: itemPhoto ?? this.itemPhoto,
      itemCode: itemCode ?? this.itemCode,
      itemBarCode: itemBarCode ?? this.itemBarCode,
      documents: documents ?? this.documents,
      instructions: instructions ?? this.instructions,
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
    result.addAll({'alertQuantity': alertQuantity});
    result.addAll({'itemPhoto': itemPhoto});
    result.addAll({'itemCode': itemCode});
    result.addAll({'itemBarCode': itemBarCode});
    result.addAll({'documents': documents});
    result.addAll({'instructions': instructions});
    result.addAll({'documents': documents});
    result.addAll({'instructions': instructions});
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
      price: map['price'] ?? 0,
      alertQuantity: map['alertQuantity'] ?? 0,
      itemPhoto: map['itemPhoto'] ?? '',
      itemCode: map['itemCode'] ?? '',
      itemBarCode: map['itemBarCode'] ?? '',
      documents: List<String>.from(map['documents'] ?? []),
      instructions: List<String>.from(map['instructions'] ?? []),
      sparePartFor: List<String>.from(map['sparePartFor'] ?? []),
      itemUnit: ItemUnit.fromString(map['itemUnit'] ?? ''),
      locations: List<String>.from(map['locations'] ?? []),
      amountInLocations: List<ItemAmountInLocationModel>.from(
        map['amountInLocations']
                ?.map((x) => ItemAmountInLocationModel.fromMap(x)) ??
            [],
      ),
    );
  }

  ItemModel deepCopy() {
    return copyWith(
      sparePartFor: [...sparePartFor],
      locations: [...locations],
      instructions: [...instructions],
      documents: [...documents],
      amountInLocations: amountInLocations
          .map((ItemAmountInLocationModel e) => e.copyWith())
          .toList(),
    );
  }

  factory ItemModel.fromItem(Item item) {
    return ItemModel(
      id: item.id,
      producer: item.producer,
      name: item.name,
      description: item.description,
      category: item.category,
      price: item.price,
      alertQuantity: item.alertQuantity,
      itemPhoto: item.itemPhoto,
      itemCode: item.itemCode,
      itemBarCode: item.itemBarCode,
      documents: item.documents,
      instructions: item.instructions,
      sparePartFor: item.sparePartFor,
      itemUnit: item.itemUnit,
      locations: item.locations,
      amountInLocations: item.amountInLocations,
    );
  }
}
