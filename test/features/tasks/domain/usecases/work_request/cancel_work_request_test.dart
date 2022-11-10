import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:under_control_v2/features/assets/utils/asset_status.dart';
import 'package:under_control_v2/features/core/error/failures.dart';
import 'package:under_control_v2/features/core/usecases/usecase.dart';
import 'package:under_control_v2/features/tasks/domain/entities/task_priority.dart';
import 'package:under_control_v2/features/tasks/domain/entities/work_request/work_request.dart';
import 'package:under_control_v2/features/tasks/domain/repositories/work_request_repository.dart';
import 'package:under_control_v2/features/tasks/domain/usecases/work_order/cancel_work_request.dart';

class MockWorkRequestsRepository extends Mock
    implements WorkRequestsRepository {}

void main() {
  late CancelWorkRequest usecase;
  late MockWorkRequestsRepository repository;

  final tWorkRequestParams = WorkRequestParams(
    workRequest: WorkRequest(
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
    registerFallbackValue(tWorkRequestParams);
  });

  setUp(() {
    repository = MockWorkRequestsRepository();
    usecase = CancelWorkRequest(repository: repository);
  });

  group('Tasks', () {
    test(
      'should return [VoidResult] from repository when CancelWorkRequest is called',
      () async {
        // arrange
        when(() => repository.cancelWorkRequest(any()))
            .thenAnswer((_) async => Right(VoidResult()));
        // act
        final result = await usecase(tWorkRequestParams);
        // assert
        expect(result, isA<Right<Failure, VoidResult>>());
      },
    );
  });
}
