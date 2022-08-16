import '../../domain/entities/item_category.dart';

class ItemCategoryModel extends ItemCategory {
  const ItemCategoryModel({
    required super.id,
    required super.name,
  });

  ItemCategoryModel copyWith({
    String? id,
    String? name,
  }) {
    return ItemCategoryModel(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'name': name});

    return result;
  }

  factory ItemCategoryModel.fromMap(Map<String, dynamic> map, String id) {
    return ItemCategoryModel(
      id: id,
      name: map['name'] ?? '',
    );
  }
}
