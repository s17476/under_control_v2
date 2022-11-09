import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:under_control_v2/features/assets/utils/asset_status.dart';
import 'package:under_control_v2/features/core/usecases/usecase.dart';
import 'package:under_control_v2/features/core/utils/duration_unit.dart';
import 'package:under_control_v2/features/tasks/data/models/task_model.dart';
import 'package:under_control_v2/features/tasks/domain/entities/task_priority.dart';
import 'package:under_control_v2/features/tasks/domain/entities/task_type.dart';

final tDate = DateTime(2022);

final tTaskModel = TaskModel(
  id: 'id',
  parentId: 'parentId',
  count: 1,
  date: tDate,
  executionDate: tDate,
  title: 'title',
  description: 'description',
  locationId: 'locationId',
  userId: 'userId',
  assetId: 'assetId',
  workOrderId: 'workOrderId',
  images: const [],
  instructions: const [],
  video: 'video',
  priority: TaskPriority.high,
  type: TaskType.reparation,
  assetStatus: AssetStatus.ok,
  isFinished: false,
  isCancelled: false,
  isSuccessful: false,
  isInProgress: false,
  isCyclictask: false,
  durationUnit: DurationUnit.unknown,
  duration: 0,
  actions: const [],
  assignedGroups: const [],
  assignedUsers: const [],
);

final tTaskModelToMap = {
  'id': 'id',
  'parentId': 'parentId',
  'count': 1,
  'date': tDate,
  'executionDate': tDate,
  'title': 'title',
  'description': 'description',
  'locationId': 'locationId',
  'userId': 'userId',
  'assetId': 'assetId',
  'workOrderId': 'workOrderId',
  'images': const [],
  'instructions': const [],
  'video': 'video',
  'priority': TaskPriority.high.name,
  'type': TaskType.reparation.name,
  'assetStatus': AssetStatus.ok.name,
  'isFinished': false,
  'isCancelled': false,
  'isSuccessful': false,
  'isInProgress': false,
  'isCyclictask': false,
  'durationUnit': DurationUnit.unknown.name,
  'duration': 0,
  'actions': const [],
  'assignedGroups': const [],
  'assignedUsers': const [],
};

final tTaskModelFromMap = {
  'id': 'id',
  'parentId': 'parentId',
  'count': 1,
  'date': Timestamp.fromDate(tDate),
  'executionDate': Timestamp.fromDate(tDate),
  'title': 'title',
  'description': 'description',
  'locationId': 'locationId',
  'userId': 'userId',
  'assetId': 'assetId',
  'workOrderId': 'workOrderId',
  'images': const [],
  'instructions': const [],
  'video': 'video',
  'priority': TaskPriority.high.name,
  'type': TaskType.reparation.name,
  'assetStatus': AssetStatus.ok.name,
  'isFinished': false,
  'isCancelled': false,
  'isSuccessful': false,
  'isInProgress': false,
  'isCyclictask': false,
  'durationUnit': DurationUnit.unknown.name,
  'duration': 0,
  'actions': const [],
  'assignedGroups': const [],
  'assignedUsers': const [],
};

final tTaskParams = TaskParams(task: tTaskModel, companyId: 'companyId');
