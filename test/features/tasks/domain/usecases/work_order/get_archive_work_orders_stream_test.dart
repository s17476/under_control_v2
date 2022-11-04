import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:under_control_v2/features/core/error/failures.dart';
import 'package:under_control_v2/features/core/usecases/usecase.dart';
import 'package:under_control_v2/features/tasks/domain/entities/work_order/work_orders_stream.dart';
import 'package:under_control_v2/features/tasks/domain/repositories/work_order_repository.dart';
import 'package:under_control_v2/features/tasks/domain/usecases/work_order/get_archive_work_orders_stream.dart';

class MockWorkOrdersRepository extends Mock implements WorkOrdersRepository {}

void main() {
  late GetArchiveWorkOrdersStream usecase;
  late MockWorkOrdersRepository repository;

  const tItemsInLocationsParams = ItemsInLocationsParams(
    locations: [],
    companyId: 'companyId',
  );

  setUpAll(() {
    registerFallbackValue(tItemsInLocationsParams);
  });

  setUp(() {
    repository = MockWorkOrdersRepository();
    usecase = GetArchiveWorkOrdersStream(repository: repository);
  });

  group('Tasks', () {
    test(
      'should return [WorkOrdersStream] from repository when GetArchiveWorkOrdersStream is called',
      () async {
        // arrange
        when(() => repository.getArchiveWorkOrdersStream(any())).thenAnswer(
            (_) async => Right(
                WorkOrdersStream(allWorkOrders: Stream.fromIterable([]))));
        // act
        final result = await usecase(tItemsInLocationsParams);
        // assert
        expect(result, isA<Right<Failure, WorkOrdersStream>>());
      },
    );
  });
}
