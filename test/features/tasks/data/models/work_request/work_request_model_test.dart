import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:under_control_v2/features/assets/utils/asset_status.dart';
import 'package:under_control_v2/features/tasks/data/models/work_request/work_request_model.dart';
import 'package:under_control_v2/features/tasks/domain/entities/task_priority.dart';
import 'package:under_control_v2/features/tasks/domain/entities/work_request/work_request.dart';

void main() {
  final date = DateTime.now();

  final tWorkRequestModel = WorkRequestModel(
    id: 'id',
    title: 'title',
    description: 'description',
    date: date,
    locationId: 'locationId',
    userId: 'userId',
    assetId: 'assetId',
    images: const [],
    video: 'video',
    priority: TaskPriority.high,
    count: 0,
    taskId: 'taskId',
    assetStatus: AssetStatus.ok,
    cancelled: false,
  );

  final tWorkRequestModelToMap = {
    'title': 'title',
    'description': 'description',
    'date': date,
    'locationId': 'locationId',
    'userId': 'userId',
    'assetId': 'assetId',
    'images': [],
    'video': 'video',
    'priority': TaskPriority.high.name,
    'count': 0,
    'taskId': 'taskId',
    'assetStatus': AssetStatus.ok.name,
    'cancelled': false,
  };

  final tWorkRequestModelFromMap = {
    'title': 'title',
    'description': 'description',
    'date': Timestamp.fromDate(date),
    'locationId': 'locationId',
    'userId': 'userId',
    'assetId': 'assetId',
    'images': [],
    'video': 'video',
    'priority': TaskPriority.high.name,
    'count': 0,
    'taskId': 'taskId',
    'assetStatus': AssetStatus.ok.name,
    'cancelled': false,
  };

  group('WorkRequestModel', () {
    test(
      'should be a subclass of [WorkRequest] entity',
      () async {
        // assert
        expect(tWorkRequestModel, isA<WorkRequest>());
      },
    );
    test(
      'should return a valid model from a map',
      () async {
        // act
        final result = WorkRequestModel.fromMap(tWorkRequestModelFromMap, 'id');
        // assert
        expect(result, tWorkRequestModel);
      },
    );
    test(
      'should return a map containing proper data',
      () async {
        // act
        final result = tWorkRequestModel.toMap();
        // assert
        expect(result, tWorkRequestModelToMap);
      },
    );
  });
}
