import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:under_control_v2/features/core/error/failures.dart';
import 'package:under_control_v2/features/core/usecases/usecase.dart';
import 'package:under_control_v2/features/tasks/domain/entities/work_request/work_requests_stream.dart';
import 'package:under_control_v2/features/tasks/domain/repositories/work_request_repository.dart';
import 'package:under_control_v2/features/tasks/domain/usecases/work_order/get_archive_work_requests_stream.dart';

class MockWorkRequestsRepository extends Mock
    implements WorkRequestsRepository {}

void main() {
  late GetArchiveWorkRequestsStream usecase;
  late MockWorkRequestsRepository repository;

  const tItemsInLocationsParams = ItemsInLocationsParams(
    locations: [],
    companyId: 'companyId',
  );

  setUpAll(() {
    registerFallbackValue(tItemsInLocationsParams);
  });

  setUp(() {
    repository = MockWorkRequestsRepository();
    usecase = GetArchiveWorkRequestsStream(repository: repository);
  });

  group('Tasks', () {
    test(
      'should return [WorkRequestsStream] from repository when GetArchiveWorkRequestsStream is called',
      () async {
        // arrange
        when(() => repository.getArchiveWorkRequestsStream(any())).thenAnswer(
            (_) async => Right(
                WorkRequestsStream(allWorkRequests: Stream.fromIterable([]))));
        // act
        final result = await usecase(tItemsInLocationsParams);
        // assert
        expect(result, isA<Right<Failure, WorkRequestsStream>>());
      },
    );
  });
}
