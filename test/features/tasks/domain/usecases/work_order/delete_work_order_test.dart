import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:under_control_v2/features/core/error/failures.dart';
import 'package:under_control_v2/features/core/usecases/usecase.dart';
import 'package:under_control_v2/features/tasks/domain/entities/task_priority.dart';
import 'package:under_control_v2/features/tasks/domain/entities/work_order/work_order.dart';
import 'package:under_control_v2/features/tasks/domain/repositories/work_order_repository.dart';
import 'package:under_control_v2/features/tasks/domain/usecases/work_order/delete_work_order.dart';

class MockWorkOrdersRepository extends Mock implements WorkOrdersRepository {}

void main() {
  late DeleteWorkOrder usecase;
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
      cancelled: false,
    ),
    companyId: 'companyId',
  );

  setUpAll(() {
    registerFallbackValue(tWorkOrderParams);
  });

  setUp(() {
    repository = MockWorkOrdersRepository();
    usecase = DeleteWorkOrder(repository: repository);
  });

  group('Tasks', () {
    test(
      'should return [VoidResult] from repository when DeleteWorkOrder is called',
      () async {
        // arrange
        when(() => repository.deleteWorkOrder(any()))
            .thenAnswer((_) async => Right(VoidResult()));
        // act
        final result = await usecase(tWorkOrderParams);
        // assert
        expect(result, isA<Right<Failure, VoidResult>>());
      },
    );
  });
}
