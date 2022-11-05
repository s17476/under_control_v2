import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:under_control_v2/features/assets/utils/asset_status.dart';
import 'package:under_control_v2/features/core/error/failures.dart';
import 'package:under_control_v2/features/core/usecases/usecase.dart';
import 'package:under_control_v2/features/tasks/domain/entities/task_priority.dart';
import 'package:under_control_v2/features/tasks/domain/entities/work_order/work_order.dart';
import 'package:under_control_v2/features/tasks/domain/repositories/work_order_repository.dart';
import 'package:under_control_v2/features/tasks/domain/usecases/work_order/add_work_order.dart';

class MockWorkOrdersRepository extends Mock implements WorkOrdersRepository {}

void main() {
  late AddWorkOrder usecase;
  late MockWorkOrdersRepository repository;

  final tWorkOrderParams = WorkOrderParams(
    workOrder: WorkOrder(
      id: 'id',
      title: 'title',
      description: 'description',
      date: DateTime.now(),
      locationId: 'locationId',
      userId: 'userId',
      assetId: 'assetId',
      images: const [],
      video: 'video',
      priority: TaskPriority.low,
      count: 0,
      taskId: 'taskId',
      assetStatus: AssetStatus.ok,
      cancelled: false,
    ),
    companyId: 'companyId',
  );

  setUpAll(() {
    registerFallbackValue(tWorkOrderParams);
  });

  setUp(() {
    repository = MockWorkOrdersRepository();
    usecase = AddWorkOrder(repository: repository);
  });

  group('Tasks', () {
    test(
      'should return [String] from repository when AddWorkOrder is called',
      () async {
        // arrange
        when(() => repository.addWorkOrder(any()))
            .thenAnswer((_) async => const Right(''));
        // act
        final result = await usecase(tWorkOrderParams);
        // assert
        expect(result, isA<Right<Failure, String>>());
      },
    );
  });
}
