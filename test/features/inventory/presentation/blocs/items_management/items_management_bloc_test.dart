import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:under_control_v2/features/company_profile/presentation/blocs/company_profile/company_profile_bloc.dart';
import 'package:under_control_v2/features/core/error/failures.dart';
import 'package:under_control_v2/features/core/usecases/usecase.dart';
import 'package:under_control_v2/features/inventory/data/models/item_model.dart';
import 'package:under_control_v2/features/inventory/domain/entities/item.dart';
import 'package:under_control_v2/features/inventory/domain/usecases/add_item.dart';
import 'package:under_control_v2/features/inventory/domain/usecases/delete_item.dart';
import 'package:under_control_v2/features/inventory/domain/usecases/update_item.dart';
import 'package:under_control_v2/features/inventory/presentation/blocs/items_management/items_management_bloc.dart';

class MockCompanyProfileBloc extends Mock
    implements Stream<CompanyProfileState>, CompanyProfileBloc {}

class MockAddItem extends Mock implements AddItem {}

class MockDeleteItem extends Mock implements DeleteItem {}

class MockUpdateItem extends Mock implements UpdateItem {}

void main() {
  late MockCompanyProfileBloc mockCompanyProfileBloc;

  late MockAddItem mockAddItem;
  late MockDeleteItem mockDeleteItem;
  late MockUpdateItem mockUpdateItem;

  late ItemsManagementBloc itemsManagementBloc;

  const companyId = 'companyId';

  const tItemModel = ItemModel(
    id: 'id',
    name: 'name',
    description: 'description',
    category: 'category',
    itemPhoto: 'itemPhoto',
    itemCode: 'itemCode',
    sparePartFor: [],
    itemUnit: ItemUnit.pcs,
    locations: [],
    amountInLocations: [],
  );

  const tItemParams = ItemParams(
    item: tItemModel,
    companyId: companyId,
  );

  setUp(() {
    mockCompanyProfileBloc = MockCompanyProfileBloc();

    mockAddItem = MockAddItem();
    mockDeleteItem = MockDeleteItem();
    mockUpdateItem = MockUpdateItem();

    when(() => mockCompanyProfileBloc.stream).thenAnswer(
      (_) => Stream.fromFuture(
        Future.value(CompanyProfileEmpty()),
      ),
    );

    itemsManagementBloc = ItemsManagementBloc(
      companyProfileBloc: mockCompanyProfileBloc,
      addItem: mockAddItem,
      deleteItem: mockDeleteItem,
      updateItem: mockUpdateItem,
    );
  });

  setUpAll(() {
    registerFallbackValue(tItemParams);
  });

  group('Item Management BLoC', () {
    test(
      'should emit [ItemManagementEmptyState] as an initial state',
      () async {
        // assert
        expect(itemsManagementBloc.state, ItemsManagementEmptyState());
      },
    );

    group('AddItem', () {
      blocTest<ItemsManagementBloc, ItemsManagementState>(
        'should emit [ItemManagementSuccessfulStete]',
        build: () => itemsManagementBloc,
        act: (bloc) async {
          when(() => mockAddItem(any()))
              .thenAnswer((_) async => const Right(''));
          bloc.add(const AddItemEvent(item: tItemModel));
        },
        expect: () => [
          ItemsManagementLoadingState(),
          isA<ItemsManagementSuccessState>(),
        ],
      );
      blocTest<ItemsManagementBloc, ItemsManagementState>(
        'should emit [ItemManagementErrorStete]',
        build: () => itemsManagementBloc,
        act: (bloc) async {
          when(() => mockAddItem(any())).thenAnswer(
            (_) async => const Left(
              DatabaseFailure(),
            ),
          );
          bloc.add(const AddItemEvent(item: tItemModel));
        },
        expect: () => [
          ItemsManagementLoadingState(),
          isA<ItemsManagementErrorState>(),
        ],
      );
    });
    group('DeleteItem', () {
      blocTest<ItemsManagementBloc, ItemsManagementState>(
        'should emit [ItemManagementSuccessfulStete]',
        build: () => itemsManagementBloc,
        act: (bloc) async {
          when(() => mockDeleteItem(any()))
              .thenAnswer((_) async => Right(VoidResult()));
          bloc.add(const DeleteItemEvent(item: tItemModel));
        },
        expect: () => [
          ItemsManagementLoadingState(),
          isA<ItemsManagementSuccessState>(),
        ],
      );
      blocTest<ItemsManagementBloc, ItemsManagementState>(
        'should emit [ItemManagementErrorStete]',
        build: () => itemsManagementBloc,
        act: (bloc) async {
          when(() => mockDeleteItem(any())).thenAnswer(
            (_) async => const Left(
              DatabaseFailure(),
            ),
          );
          bloc.add(const DeleteItemEvent(item: tItemModel));
        },
        expect: () => [
          ItemsManagementLoadingState(),
          isA<ItemsManagementErrorState>(),
        ],
      );
    });
    group('UpdateItem', () {
      blocTest<ItemsManagementBloc, ItemsManagementState>(
        'should emit [ItemManagementSuccessfulStete]',
        build: () => itemsManagementBloc,
        act: (bloc) async {
          when(() => mockUpdateItem(any()))
              .thenAnswer((_) async => Right(VoidResult()));
          bloc.add(const UpdateItemEvent(item: tItemModel));
        },
        expect: () => [
          ItemsManagementLoadingState(),
          isA<ItemsManagementSuccessState>(),
        ],
      );
      blocTest<ItemsManagementBloc, ItemsManagementState>(
        'should emit [ItemManagementErrorStete]',
        build: () => itemsManagementBloc,
        act: (bloc) async {
          when(() => mockUpdateItem(any())).thenAnswer(
            (_) async => const Left(
              DatabaseFailure(),
            ),
          );
          bloc.add(const UpdateItemEvent(item: tItemModel));
        },
        expect: () => [
          ItemsManagementLoadingState(),
          isA<ItemsManagementErrorState>(),
        ],
      );
    });
  });
}
