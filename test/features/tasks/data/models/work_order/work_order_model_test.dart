import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:under_control_v2/features/tasks/data/models/work_order/work_order_model.dart';
import 'package:under_control_v2/features/tasks/domain/entities/task_priority.dart';
import 'package:under_control_v2/features/tasks/domain/entities/work_order/work_order.dart';

void main() {
  final date = DateTime.now();

  final tWorkOrderModel = WorkOrderModel(
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
  );

  final tWorkOrderModelToMap = {
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
  };

  final tWorkOrderModelFromMap = {
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
  };

  group('WorkOrderModel', () {
    test(
      'should be a subclass of [WorkOrder] entity',
      () async {
        // assert
        expect(tWorkOrderModel, isA<WorkOrder>());
      },
    );
    test(
      'should return a valid model from a map',
      () async {
        // act
        final result = WorkOrderModel.fromMap(tWorkOrderModelFromMap, 'id');
        // assert
        expect(result, tWorkOrderModel);
      },
    );
    test(
      'should return a map containing proper data',
      () async {
        // act
        final result = tWorkOrderModel.toMap();
        // assert
        expect(result, tWorkOrderModelToMap);
      },
    );
  });
}
