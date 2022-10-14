import '../../../domain/entities/asset_category/asset_category.dart';

class AssetCategoryModel extends AssetCategory {
  const AssetCategoryModel({
    required super.id,
    required super.name,
  });

  AssetCategoryModel copyWith({
    String? id,
    String? name,
  }) {
    return AssetCategoryModel(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'name': name});

    return result;
  }

  factory AssetCategoryModel.fromMap(Map<String, dynamic> map, String id) {
    return AssetCategoryModel(
      id: id,
      name: map['name'] ?? '',
    );
  }
}
