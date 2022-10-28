import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:under_control_v2/features/core/error/failures.dart';
import 'package:under_control_v2/features/core/usecases/usecase.dart';
import 'package:under_control_v2/features/inventory/domain/entities/item_action/item_actions_stream.dart';
import 'package:under_control_v2/features/inventory/domain/repositories/dashboard_item_action_repository.dart';
import 'package:under_control_v2/features/inventory/domain/usecases/item_action/get_dashboard_item_actions_stream.dart';

class MockDashboardItemActionRepository extends Mock
    implements DashboardItemActionRepository {}

void main() {
  late GetDashboardItemsActionsStream usecase;
  late MockDashboardItemActionRepository repository;

  const companyId = 'companyId';

  const locations = ['loc1', 'loc2'];

  const tParams =
      ItemsInLocationsParams(locations: locations, companyId: companyId);

  setUpAll(() {
    registerFallbackValue(tParams);
  });

  setUp(
    () {
      repository = MockDashboardItemActionRepository();
      usecase = GetDashboardItemsActionsStream(repository: repository);
    },
  );

  group('Dashboard Inventory Actions', () {
    test(
      'should return [ItemActionsStream] from repository when GetdashboardItemActionStream is called',
      () async {
        // arrange
        when(() => repository.getDashboardItemActionsStream(any())).thenAnswer(
          (_) async => Right(
            ItemActionsStream(
              allItemActions: Stream.fromIterable([]),
            ),
          ),
        );
        // act
        final result = await usecase(tParams);
        // assert
        expect(result, isA<Right<Failure, ItemActionsStream>>());
      },
    );
  });
}
