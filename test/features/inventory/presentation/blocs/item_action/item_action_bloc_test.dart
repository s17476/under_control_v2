import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:under_control_v2/features/core/error/failures.dart';
import 'package:under_control_v2/features/core/usecases/usecase.dart';
import 'package:under_control_v2/features/inventory/data/models/item_model.dart';
import 'package:under_control_v2/features/inventory/domain/entities/item.dart';
import 'package:under_control_v2/features/inventory/domain/entities/item_action/item_actions_stream.dart';
import 'package:under_control_v2/features/inventory/domain/usecases/item_action/get_item_actions_stream.dart';
import 'package:under_control_v2/features/inventory/domain/usecases/item_action/get_last_five_item_actions_stream.dart';
import 'package:under_control_v2/features/inventory/presentation/blocs/item_action/item_action_bloc.dart';

class MockGetItemsActionsStream extends Mock implements GetItemsActionsStream {}

class MockGetLastFiveItemsActionsStream extends Mock
    implements GetLastFiveItemsActionsStream {}

void main() {
  late MockGetItemsActionsStream mockGetItemActionsStream;
  late MockGetLastFiveItemsActionsStream mockGetLastFiveItemActionsStream;
  late ItemActionBloc itemActionBloc;

  const companyId = 'companyId';

  const tItemModel = ItemModel(
    id: 'id',
    producer: 'producer',
    name: 'name',
    description: 'description',
    category: 'category',
    price: 0,
    alertQuantity: 0,
    itemPhoto: 'itemPhoto',
    itemCode: 'itemCode',
    itemBarCode: 'itemBarCode',
    sparePartFor: [],
    itemUnit: ItemUnit.pcs,
    locations: [],
    amountInLocations: [],
  );

  const tItemParams = ItemParams(
    item: tItemModel,
    companyId: companyId,
  );

  setUp(
    () {
      mockGetItemActionsStream = MockGetItemsActionsStream();
      mockGetLastFiveItemActionsStream = MockGetLastFiveItemsActionsStream();

      itemActionBloc = ItemActionBloc(
        getItemsActionsStream: mockGetItemActionsStream,
        getLastFiveItemsActionsStream: mockGetLastFiveItemActionsStream,
      );
    },
  );

  setUpAll(
    () {
      registerFallbackValue(tItemParams);
    },
  );

  group('ItemAction BLoC', () {
    test(
      'should emit [ItemActionEmptyState] as an initial state',
      () async {
        // assert
        expect(itemActionBloc.state, ItemActionEmptyState());
      },
    );

    group(
      'GetItemActionsStream',
      () {
        blocTest<ItemActionBloc, ItemActionState>(
          'should emit [ItemActionLoadingState]  when GetItemActionsEvent is called',
          build: () => itemActionBloc,
          act: (bloc) async {
            bloc.add(
              GetItemActionsEvent(
                item: tItemModel,
                companyId: companyId,
              ),
            );
            when(() => mockGetItemActionsStream(any())).thenAnswer(
              (_) async => Right(
                ItemActionsStream(
                  allItemActions: Stream.fromIterable([]),
                ),
              ),
            );
          },
          expect: () => [
            ItemActionLoadingState(),
          ],
        );
        blocTest<ItemActionBloc, ItemActionState>(
          'should emit [ItemActionErrorState] when GetItemActionsEvent is called',
          build: () => itemActionBloc,
          act: (bloc) async {
            bloc.add(
              GetItemActionsEvent(
                item: tItemModel,
                companyId: companyId,
              ),
            );
            when(() => mockGetItemActionsStream(any())).thenAnswer(
              (_) async => const Left(
                DatabaseFailure(),
              ),
            );
          },
          expect: () => [
            ItemActionLoadingState(),
            isA<ItemActionErrorState>(),
          ],
        );
      },
    );
  });
}
