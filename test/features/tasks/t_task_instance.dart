import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:under_control_v2/features/assets/utils/asset_status.dart';
import 'package:under_control_v2/features/core/usecases/usecase.dart';
import 'package:under_control_v2/features/core/utils/duration_unit.dart';
import 'package:under_control_v2/features/tasks/data/models/task/spare_part_item_model.dart';
import 'package:under_control_v2/features/tasks/data/models/task/task_model.dart';
import 'package:under_control_v2/features/tasks/data/models/task_action/task_action_model.dart';
import 'package:under_control_v2/features/tasks/data/models/task_action/user_action_model.dart';
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
  sparePartsAssets: const [],
  sparePartsItems: const [SparePartItemModel(itemId: 'itemId', quantity: 1)],
);

final tTaskModelToMap = {
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
  'sparePartsAssets': const [],
  'sparePartsItems': const [
    {'itemId': 'itemId', 'quantity': 1.0},
  ],
};

final tTaskModelFromMap = {
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
  'sparePartsAssets': const [],
  'sparePartsItems': const [
    {'itemId': 'itemId', 'quantity': 1.0},
  ],
};

final tTaskParams = TaskParams(task: tTaskModel, companyId: 'companyId');

final tUserActionModel = UserActionModel(
  userId: 'userId',
  startTime: tDate,
  stopTime: tDate,
);

final tUserActionModelToMap = {
  'userId': 'userId',
  'startTime': tDate,
  'stopTime': tDate,
};

final tUserActionModelFromMap = {
  'userId': 'userId',
  'startTime': Timestamp.fromDate(tDate),
  'stopTime': Timestamp.fromDate(tDate),
};

final tTaskActionModel = TaskActionModel(
  id: 'id',
  taskId: 'taskId',
  comment: 'comment',
  startTime: tDate,
  stopTime: tDate,
  images: const [],
  removedPartsAssets: const [],
  addedPartsAssets: const [],
  sparePartsItems: const [],
  usersActions: const [],
);

final tTaskActionModelToMap = {
  'taskId': 'taskId',
  'comment': 'comment',
  'startTime': tDate,
  'stopTime': tDate,
  'images': const [],
  'removedPartsAssets': const [],
  'addedPartsAssets': const [],
  'sparePartsItems': const [],
  'usersActions': const [],
};

final tTaskActionModelFromMap = {
  'taskId': 'taskId',
  'comment': 'comment',
  'startTime': Timestamp.fromDate(tDate),
  'stopTime': Timestamp.fromDate(tDate),
  'images': const [],
  'removedPartsAssets': const [],
  'addedPartsAssets': const [],
  'sparePartsItems': const [],
  'usersActions': const [],
};

final tTaskActionParams = TaskActionParams(
  taskAction: tTaskActionModel,
  companyId: 'companyId',
);
