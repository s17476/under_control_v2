import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:under_control_v2/features/authentication/presentation/blocs/authentication/authentication_bloc.dart';
import 'package:under_control_v2/features/core/error/failures.dart';
import 'package:under_control_v2/features/core/usecases/usecase.dart';
import 'package:under_control_v2/features/filter/presentation/blocs/filter/filter_bloc.dart';
import 'package:under_control_v2/features/inventory/data/models/items_stream_model.dart';
import 'package:under_control_v2/features/inventory/domain/usecases/get_items_stream.dart';
import 'package:under_control_v2/features/inventory/presentation/blocs/items/items_bloc.dart';

class MockFilterBloc extends Mock implements FilterBloc {}

class MockGetItemsStream extends Mock implements GetItemsStream {}

class MockAuthenticationBloc extends Mock
    implements Stream<AuthenticationState>, AuthenticationBloc {}

void main() {
  late MockAuthenticationBloc mockAuthenticationBloc;
  late MockFilterBloc mockFilterBloc;
  late MockGetItemsStream mockGetItemsStream;
  late ItemsBloc itemsBloc;

  const companyId = 'companyId';

  // const tItemModel = ItemModel(
  //   id: 'id',
  //   name: 'name',
  //   description: 'description',
  //   category: 'category',
  //   itemPhoto: 'itemPhoto',
  //   itemCode: 'itemCode',
  //   sparePartFor: [],
  //   itemUnit: ItemUnit.kg,
  //   locations: [],
  //   amountInLocations: [],
  // );

  const tItemsInLocationsParams = ItemsInLocationsParams(
    locations: [],
    companyId: companyId,
  );

  setUp(() {
    mockFilterBloc = MockFilterBloc();
    mockGetItemsStream = MockGetItemsStream();

    when(() => mockFilterBloc.stream).thenAnswer(
      (_) => Stream.fromFuture(
        Future.value(
          FilterEmptyState(),
        ),
      ),
    );
    mockAuthenticationBloc = MockAuthenticationBloc();
    when(() => mockAuthenticationBloc.stream).thenAnswer(
      (_) => Stream.fromFuture(
        Future.value(EmptyAuthenticationState()),
      ),
    );

    itemsBloc = ItemsBloc(
      authenticationBloc: mockAuthenticationBloc,
      filterBloc: mockFilterBloc,
      getChecklistsStream: mockGetItemsStream,
    );
  });

  setUpAll(() {
    registerFallbackValue(tItemsInLocationsParams);
  });

  group('Items BLoC', () {
    test(
      'should emit [ItemsEmptyState] as an initial state',
      () async {
        // assert
        expect(itemsBloc.state, ItemsEmptyState());
      },
    );

    group('GetItemsStream', () {
      blocTest<ItemsBloc, ItemsState>(
        'should emit [ItemsLoadingState]  when GetLAllChecklistsEvent is called',
        build: () => itemsBloc,
        act: (bloc) async {
          bloc.add(
            GetItemsEvent(
              companyId: companyId,
              selectedGroups: const [],
              selectedLocations: const [],
            ),
          );
          when(() => mockGetItemsStream(any())).thenAnswer(
            (_) async => Right(
              ItemsStreamModel(
                allItems: Stream.fromIterable([]),
              ),
            ),
          );
        },
        expect: () => [
          ItemsLoadingState(),
        ],
      );

      blocTest<ItemsBloc, ItemsState>(
        'should emit [ItemsErrorState]  when GetLAllChecklistsEvent is called',
        build: () => itemsBloc,
        act: (bloc) async {
          bloc.add(
            GetItemsEvent(
              companyId: companyId,
              selectedGroups: const [],
              selectedLocations: const [],
            ),
          );
          when(() => mockGetItemsStream(any())).thenAnswer(
            (_) async => const Left(DatabaseFailure()),
          );
        },
        expect: () => [
          ItemsLoadingState(),
          isA<ItemsErrorState>(),
        ],
      );
    });
  });
}
