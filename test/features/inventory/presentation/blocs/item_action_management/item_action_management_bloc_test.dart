import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:under_control_v2/features/company_profile/presentation/blocs/company_profile/company_profile_bloc.dart';
import 'package:under_control_v2/features/core/error/failures.dart';
import 'package:under_control_v2/features/core/usecases/usecase.dart';
import 'package:under_control_v2/features/inventory/data/models/item_action/item_action_model.dart';
import 'package:under_control_v2/features/inventory/data/models/item_amount_in_location_model.dart';
import 'package:under_control_v2/features/inventory/data/models/item_model.dart';
import 'package:under_control_v2/features/inventory/domain/entities/item.dart';
import 'package:under_control_v2/features/inventory/domain/entities/item_action/item_action.dart';
import 'package:under_control_v2/features/inventory/domain/usecases/item_action/add_item_action.dart';
import 'package:under_control_v2/features/inventory/domain/usecases/item_action/delete_item_action.dart';
import 'package:under_control_v2/features/inventory/domain/usecases/item_action/move_item_action.dart';
import 'package:under_control_v2/features/inventory/domain/usecases/item_action/update_item_action.dart';
import 'package:under_control_v2/features/inventory/presentation/blocs/item_action_management/item_action_management_bloc.dart';
import 'package:under_control_v2/features/user_profile/domain/entities/user_profile.dart';
import 'package:under_control_v2/features/user_profile/presentation/blocs/user_profile/user_profile_bloc.dart';

class MockUserProfileBloc extends Mock
    implements Stream<UserProfileState>, UserProfileBloc {}

class MockAddItemAction extends Mock implements AddItemAction {}

class MockUpdateItemAction extends Mock implements UpdateItemAction {}

class MockDeleteItemAction extends Mock implements DeleteItemAction {}

class MockMoveItemAction extends Mock implements MoveItemAction {}

void main() {
  late MockUserProfileBloc mockUserProfileBloc;

  late MockAddItemAction mockAddItemAction;
  late MockUpdateItemAction mockUpdateItemAction;
  late MockDeleteItemAction mockDeleteItemAction;
  late MockMoveItemAction mockMoveItemAction;

  late ItemActionManagementBloc itemActionManagementBloc;

  const companyId = 'companyId';

  const item = ItemModel(
    category: 'category',
    price: 0,
    alertQuantity: 0,
    id: 'id',
    producer: 'producer',
    name: 'name',
    description: 'description',
    itemPhoto: 'itemPhoto',
    itemCode: 'itemCode',
    itemBarCode: 'itemBarCode',
    instructions: [],
    documents: [],
    sparePartFor: [],
    itemUnit: ItemUnit.pcs,
    locations: [],
    amountInLocations: [
      ItemAmountInLocationModel(
        amount: 0,
        locationId: 'locationId',
      ),
    ],
  );

  final itemAction = ItemActionModel(
    id: 'id',
    type: ItemActionType.add,
    description: 'description',
    ammount: 0,
    itemUnit: ItemUnit.pcs,
    locationId: 'locationId',
    date: DateTime.now(),
    itemId: 'itemId',
    userId: 'userId',
  );

  final tItemActionParams = ItemActionParams(
    updatedItem: item,
    itemAction: itemAction,
    companyId: companyId,
  );

  final tMoveItemActionParams = MoveItemActionParams(
    updatedItem: item,
    moveFromItemAction: itemAction,
    moveToItemAction: itemAction,
    companyId: companyId,
  );

  setUp(() {
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

    mockAddItemAction = MockAddItemAction();
    mockUpdateItemAction = MockUpdateItemAction();
    mockDeleteItemAction = MockDeleteItemAction();
    mockMoveItemAction = MockMoveItemAction();

    itemActionManagementBloc = ItemActionManagementBloc(
      userProfileBloc: mockUserProfileBloc,
      addItemAction: mockAddItemAction,
      updateItemAction: mockUpdateItemAction,
      deleteItemAction: mockDeleteItemAction,
      moveItemAction: mockMoveItemAction,
    );
  });

  setUpAll(
    () {
      registerFallbackValue(tItemActionParams);
      registerFallbackValue(tMoveItemActionParams);
    },
  );

  group('ItemAction Management BLoC', () {
    test(
      'should emit [ItemActionManagementEmptyState] as an initial state',
      () async {
        // assert
        expect(
          itemActionManagementBloc.state,
          ItemActionManagementEmptyState(),
        );
      },
    );

    group('AddItemAction', () {
      blocTest<ItemActionManagementBloc, ItemActionManagementState>(
        'should emit [ItemActionManagementSuccessfulState] when AddItemAction is called',
        build: () => itemActionManagementBloc,
        act: (bloc) async {
          when(() => mockAddItemAction(any()))
              .thenAnswer((_) async => const Right(''));
          bloc.add(
            AddItemActionEvent(
              item: item,
              itemAction: itemAction,
            ),
          );
        },
        expect: () => [
          ItemActionManagementLoadingState(),
          isA<ItemActionManagementSuccessState>(),
        ],
      );
      blocTest<ItemActionManagementBloc, ItemActionManagementState>(
        'should emit [ItemActionManagementErrorState] when AddItemAction is called',
        build: () => itemActionManagementBloc,
        act: (bloc) async {
          when(() => mockAddItemAction(any()))
              .thenAnswer((_) async => const Left(DatabaseFailure()));
          bloc.add(
            AddItemActionEvent(
              item: item,
              itemAction: itemAction,
            ),
          );
        },
        expect: () => [
          ItemActionManagementLoadingState(),
          isA<ItemActionManagementErrorState>(),
        ],
      );
    });

    group('UpdateItemAction', () {
      blocTest<ItemActionManagementBloc, ItemActionManagementState>(
        'should emit [ItemActionManagementSuccessfulState] when UpdateItemAction is called',
        build: () => itemActionManagementBloc,
        act: (bloc) async {
          when(() => mockUpdateItemAction(any()))
              .thenAnswer((_) async => Right(VoidResult()));
          bloc.add(
            UpdateItemActionEvent(
              item: item,
              itemAction: itemAction,
              oldItemAction: itemAction,
            ),
          );
        },
        expect: () => [
          ItemActionManagementLoadingState(),
          isA<ItemActionManagementSuccessState>(),
        ],
      );
      blocTest<ItemActionManagementBloc, ItemActionManagementState>(
        'should emit [ItemActionManagementErrorState] when UpdateItemAction is called',
        build: () => itemActionManagementBloc,
        act: (bloc) async {
          when(() => mockUpdateItemAction(any()))
              .thenAnswer((_) async => const Left(DatabaseFailure()));
          bloc.add(
            UpdateItemActionEvent(
              item: item,
              itemAction: itemAction,
              oldItemAction: itemAction,
            ),
          );
        },
        expect: () => [
          ItemActionManagementLoadingState(),
          isA<ItemActionManagementErrorState>(),
        ],
      );
    });

    group('MoveItemAction', () {
      blocTest<ItemActionManagementBloc, ItemActionManagementState>(
        'should emit [ItemActionManagementSuccessfulState] when MoveItemAction is called',
        build: () => itemActionManagementBloc,
        act: (bloc) async {
          when(() => mockMoveItemAction(any()))
              .thenAnswer((_) async => Right(VoidResult()));
          bloc.add(
            MoveItemActionEvent(
              item: item,
              itemAction: itemAction,
              oldItemAction: itemAction,
            ),
          );
        },
        expect: () => [
          ItemActionManagementLoadingState(),
          isA<ItemActionManagementSuccessState>(),
        ],
      );
      blocTest<ItemActionManagementBloc, ItemActionManagementState>(
        'should emit [ItemActionManagementErrorState] when MoveItemAction is called',
        build: () => itemActionManagementBloc,
        act: (bloc) async {
          when(() => mockMoveItemAction(any()))
              .thenAnswer((_) async => const Left(DatabaseFailure()));
          bloc.add(
            MoveItemActionEvent(
              item: item,
              itemAction: itemAction,
              oldItemAction: itemAction,
            ),
          );
        },
        expect: () => [
          ItemActionManagementLoadingState(),
          isA<ItemActionManagementErrorState>(),
        ],
      );
    });

    group('DeleteItemAction', () {
      blocTest<ItemActionManagementBloc, ItemActionManagementState>(
        'should emit [ItemActionManagementSuccessfulState] when DeleteItemAction is called',
        build: () => itemActionManagementBloc,
        act: (bloc) async {
          when(() => mockDeleteItemAction(any()))
              .thenAnswer((_) async => Right(VoidResult()));
          bloc.add(
            DeleteItemActionEvent(
              item: item,
              itemAction: itemAction,
            ),
          );
        },
        expect: () => [
          ItemActionManagementLoadingState(),
          isA<ItemActionManagementSuccessState>(),
        ],
      );
      blocTest<ItemActionManagementBloc, ItemActionManagementState>(
        'should emit [ItemActionManagementErrorState] when DeleteItemAction is called',
        build: () => itemActionManagementBloc,
        act: (bloc) async {
          when(() => mockDeleteItemAction(any()))
              .thenAnswer((_) async => const Left(DatabaseFailure()));
          bloc.add(
            DeleteItemActionEvent(
              item: item,
              itemAction: itemAction,
            ),
          );
        },
        expect: () => [
          ItemActionManagementLoadingState(),
          isA<ItemActionManagementErrorState>(),
        ],
      );
    });
  });
}
