import 'package:equatable/equatable.dart';

import '../../data/models/item_amount_in_location_model.dart';

enum ItemUnit {
  pcs('pcs'),
  kg('kg'),
  pound('pound'),
  liter('liter'),
  gallon('gallon'),
  unknown('');

  final String name;

  const ItemUnit(this.name);

  factory ItemUnit.fromString(String name) {
    switch (name) {
      case 'pcs':
        return ItemUnit.pcs;
      case 'kg':
        return ItemUnit.kg;
      case 'pound':
        return ItemUnit.pound;
      case 'liter':
        return ItemUnit.liter;
      case 'gallon':
        return ItemUnit.gallon;
      default:
        return ItemUnit.unknown;
    }
  }
}

class Item extends Equatable {
  final String id;
  final String producer;
  final String name;
  final String description;
  final String category;
  final double price;
  final String itemPhoto;
  final String itemCode;
  final String itemBarCode;
  final List<String> sparePartFor;
  final ItemUnit itemUnit;
  final List<String> locations;
  final List<ItemAmountInLocationModel> amountInLocations;

  const Item({
    required this.category,
    required this.price,
    required this.id,
    required this.producer,
    required this.name,
    required this.description,
    required this.itemPhoto,
    required this.itemCode,
    required this.itemBarCode,
    required this.sparePartFor,
    required this.itemUnit,
    required this.locations,
    required this.amountInLocations,
  });

  @override
  List<Object> get props {
    return [
      id,
      producer,
      name,
      description,
      category,
      price,
      itemPhoto,
      itemCode,
      itemBarCode,
      sparePartFor,
      itemUnit,
      locations,
      amountInLocations,
    ];
  }

  @override
  String toString() {
    return 'Item(id: $id, producer: $producer, name: $name, description: $description, category: $category, price: $price, itemPhoto: $itemPhoto, itemCode: $itemCode, itemBarCode: $itemBarCode, sparePartFor: $sparePartFor, itemUnit: $itemUnit, locations: $locations, amountInLocations: $amountInLocations)';
  }
}
