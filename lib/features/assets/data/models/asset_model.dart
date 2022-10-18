import '../../../core/utils/duration_unit.dart';
import '../../domain/entities/asset.dart';
import '../../utils/asset_status.dart';

class AssetModel extends Asset {
  const AssetModel({
    required super.id,
    required super.producer,
    required super.model,
    required super.description,
    required super.categoryId,
    required super.locationId,
    required super.internalCode,
    required super.barCode,
    required super.isInUse,
    required super.addDate,
    required super.currentStatus,
    required super.lastInspection,
    required super.durationUnit,
    required super.duration,
    required super.images,
    required super.documents,
    required super.spareParts,
    required super.currentParentId,
    required super.isSparePart,
  });

  AssetModel copyWith({
    String? id,
    String? producer,
    String? model,
    String? description,
    String? categoryId,
    String? locationId,
    String? internalCode,
    String? barCode,
    bool? isInUse,
    DateTime? addDate,
    AssetStatus? currentStatus,
    DateTime? lastInspection,
    DurationUnit? durationUnit,
    int? duration,
    List<String>? images,
    List<String>? documents,
    List<String>? spareParts,
    String? currentParentId,
    bool? isSparePart,
  }) {
    return AssetModel(
      id: id ?? this.id,
      producer: producer ?? this.producer,
      model: model ?? this.model,
      description: description ?? this.description,
      categoryId: categoryId ?? this.categoryId,
      locationId: locationId ?? this.locationId,
      internalCode: internalCode ?? this.internalCode,
      barCode: barCode ?? this.barCode,
      isInUse: isInUse ?? this.isInUse,
      addDate: addDate ?? this.addDate,
      currentStatus: currentStatus ?? this.currentStatus,
      lastInspection: lastInspection ?? this.lastInspection,
      durationUnit: durationUnit ?? this.durationUnit,
      duration: duration ?? this.duration,
      images: images ?? this.images,
      documents: documents ?? this.documents,
      spareParts: spareParts ?? this.spareParts,
      currentParentId: currentParentId ?? this.currentParentId,
      isSparePart: isSparePart ?? this.isSparePart,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'producer': producer});
    result.addAll({'model': model});
    result.addAll({'description': description});
    result.addAll({'categoryId': categoryId});
    result.addAll({'locationId': locationId});
    result.addAll({'internalCode': internalCode});
    result.addAll({'barCode': barCode});
    result.addAll({'isInUse': isInUse});
    result.addAll({'addDate': addDate.toIso8601String()});
    result.addAll({'currentStatus': currentStatus.name});
    result.addAll({'lastInspection': lastInspection.toIso8601String()});
    result.addAll({'durationUnit': durationUnit.name});
    result.addAll({'duration': duration});
    result.addAll({'images': images});
    result.addAll({'documents': documents});
    result.addAll({'spareParts': spareParts});
    result.addAll({'currentParentId': currentParentId});
    result.addAll({'isSparePart': isSparePart});

    return result;
  }

  factory AssetModel.fromMap(Map<String, dynamic> map, String id) {
    return AssetModel(
      id: id,
      producer: map['producer'] ?? '',
      model: map['model'] ?? '',
      description: map['description'] ?? '',
      categoryId: map['categoryId'] ?? '',
      locationId: map['locationId'] ?? '',
      internalCode: map['internalCode'] ?? '',
      barCode: map['barCode'] ?? '',
      isInUse: map['isInUse'] ?? false,
      addDate: DateTime.parse(map['addDate']),
      currentStatus: AssetStatus.fromString(map['currentStatus']),
      lastInspection: DateTime.parse(map['lastInspection']),
      durationUnit: DurationUnit.fromString(map['durationUnit']),
      duration: map['duration']?.toInt() ?? 0,
      images: List<String>.from(map['images']),
      documents: List<String>.from(map['documents']),
      spareParts: List<String>.from(map['spareParts']),
      currentParentId: map['currentParentId'] ?? '',
      isSparePart: map['possibleParents'] ?? false,
    );
  }

  AssetModel deepCopy() {
    return copyWith(
      documents: [...documents],
      images: [...images],
      spareParts: [...spareParts],
    );
  }
}
