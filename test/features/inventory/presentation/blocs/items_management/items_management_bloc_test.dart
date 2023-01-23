import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:under_control_v2/features/core/error/failures.dart';
import 'package:under_control_v2/features/core/usecases/usecase.dart';
import 'package:under_control_v2/features/inventory/data/models/item_model.dart';
import 'package:under_control_v2/features/inventory/domain/entities/item.dart';
import 'package:under_control_v2/features/inventory/domain/usecases/add_item.dart';
import 'package:under_control_v2/features/inventory/domain/usecases/add_item_photo.dart';
import 'package:under_control_v2/features/inventory/domain/usecases/delete_item.dart';
import 'package:under_control_v2/features/inventory/domain/usecases/delete_item_photo.dart';
import 'package:under_control_v2/features/inventory/domain/usecases/update_item.dart';
import 'package:under_control_v2/features/inventory/domain/usecases/update_item_photo.dart';
import 'package:under_control_v2/features/inventory/presentation/blocs/items_management/items_management_bloc.dart';
import 'package:under_control_v2/features/user_profile/domain/entities/user_profile.dart';
import 'package:under_control_v2/features/user_profile/presentation/blocs/user_profile/user_profile_bloc.dart';

class MockUserProfileBloc extends Mock
    implements Stream<UserProfileState>, UserProfileBloc {}

class MockAddItem extends Mock implements AddItem {}

class MockDeleteItem extends Mock implements DeleteItem {}

class MockUpdateItem extends Mock implements UpdateItem {}

class MockAddItemPhoto extends Mock implements AddItemPhoto {}

class MockDeleteItemPhoto extends Mock implements DeleteItemPhoto {}

class MockUpdateItemPhoto extends Mock implements UpdateItemPhoto {}

void main() {
  late MockUserProfileBloc mockUserProfileBloc;

  late MockAddItem mockAddItem;
  late MockDeleteItem mockDeleteItem;
  late MockUpdateItem mockUpdateItem;
  late MockAddItemPhoto mockAddItemPhoto;
  late MockDeleteItemPhoto mockDeleteItemPhoto;
  late MockUpdateItemPhoto mockUpdateItemPhoto;

  late ItemsManagementBloc itemsManagementBloc;

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
    instructions: [],
    documents: [],
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
    mockAddItem = MockAddItem();
    mockDeleteItem = MockDeleteItem();
    mockUpdateItem = MockUpdateItem();
    mockAddItemPhoto = MockAddItemPhoto();
    mockDeleteItemPhoto = MockDeleteItemPhoto();
    mockUpdateItemPhoto = MockUpdateItemPhoto();

    mockUserProfileBloc = MockUserProfileBloc();
    when(() => mockUserProfileBloc.stream).thenAnswer(
      (_) => Stream.fromFuture(
        Future.value(UserProfileEmpty()),
      ),
    );
    when(() => mockUserProfileBloc.state).thenReturn(
      Approved(
        userProfile: UserProfile(
          id: '',
          administrator: false,
          approved: true,
          avatarUrl: '',
          companyId: '',
          email: '',
          firstName: '',
          isActive: true,
          joinDate: DateTime.now(),
          lastName: '',
          phoneNumber: '',
          locations: const [],
          rejected: false,
          suspended: false,
          userGroups: const [],
        ),
      ),
    );

    itemsManagementBloc = ItemsManagementBloc(
      userProfileBloc: mockUserProfileBloc,
      addItem: mockAddItem,
      deleteItem: mockDeleteItem,
      updateItem: mockUpdateItem,
      addItemPhoto: mockAddItemPhoto,
      deleteItemPhoto: mockDeleteItemPhoto,
      updateItemPhoto: mockUpdateItemPhoto,
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
          when(() => mockAddItemPhoto(any()))
              .thenAnswer((_) async => const Right(''));
          when(() => mockAddItem(any()))
              .thenAnswer((_) async => const Right(''));
          bloc.add(const AddItemEvent(item: tItemModel, documents: []));
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
          when(() => mockAddItemPhoto(any()))
              .thenAnswer((_) async => const Right(''));
          when(() => mockAddItem(any())).thenAnswer(
            (_) async => const Left(
              DatabaseFailure(),
            ),
          );
          bloc.add(const AddItemEvent(item: tItemModel, documents: []));
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
          when(() => mockAddItemPhoto(any()))
              .thenAnswer((_) async => const Right(''));
          when(() => mockUpdateItem(any()))
              .thenAnswer((_) async => Right(VoidResult()));
          bloc.add(const UpdateItemEvent(item: tItemModel, documents: []));
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
          when(() => mockAddItemPhoto(any()))
              .thenAnswer((_) async => const Right(''));
          when(() => mockUpdateItem(any())).thenAnswer(
            (_) async => const Left(
              DatabaseFailure(),
            ),
          );
          bloc.add(const UpdateItemEvent(item: tItemModel, documents: []));
        },
        expect: () => [
          ItemsManagementLoadingState(),
          isA<ItemsManagementErrorState>(),
        ],
      );
    });
  });
}
