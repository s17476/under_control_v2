import 'package:equatable/equatable.dart';

import 'package:under_control_v2/features/assets/utils/asset_status.dart';
import 'package:under_control_v2/features/core/utils/duration_unit.dart';

class Asset extends Equatable {
  final String id;
  final String producer;
  final String model;
  final String description;
  final String categoryId;
  final String locationId;
  final String internalCode;
  final String barCode;
  final bool isInUse;
  final DateTime addDate;
  final AssetStatus currentStatus;
  final DateTime lastInspection;
  final DurationUnit durationUnit;
  final int duration;
  final List<String> images;
  final List<String> doucments;
  final List<String> spareParts;
  final String currentParentId;
  final List<String> possibleParents;

  const Asset({
    required this.id,
    required this.producer,
    required this.model,
    required this.description,
    required this.categoryId,
    required this.locationId,
    required this.internalCode,
    required this.barCode,
    required this.isInUse,
    required this.addDate,
    required this.currentStatus,
    required this.lastInspection,
    required this.durationUnit,
    required this.duration,
    required this.images,
    required this.doucments,
    required this.spareParts,
    required this.currentParentId,
    required this.possibleParents,
  });

  @override
  List<Object> get props {
    return [
      id,
      producer,
      model,
      description,
      categoryId,
      locationId,
      internalCode,
      barCode,
      isInUse,
      addDate,
      currentStatus,
      lastInspection,
      durationUnit,
      duration,
      images,
      doucments,
      spareParts,
      currentParentId,
      possibleParents,
    ];
  }

  @override
  String toString() {
    return 'Asset(id: $id, producer: $producer, model: $model, description: $description, categoryId: $categoryId, locationId: $locationId, internalCode: $internalCode, barCode: $barCode, isInUse: $isInUse, addDate: $addDate, currentStatus: $currentStatus, lastInspection: $lastInspection, durationUnit: $durationUnit, duration: $duration, images: $images, doucments: $doucments, spareParts: $spareParts, currentParentId: $currentParentId, possibleParents: $possibleParents)';
  }
}
