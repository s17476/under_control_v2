import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:under_control_v2/features/core/error/failures.dart';
import 'package:under_control_v2/features/core/usecases/usecase.dart';
import 'package:under_control_v2/features/inventory/data/models/item_category/item_category_model.dart';
import 'package:under_control_v2/features/inventory/domain/usecases/item_category/add_item_category.dart';
import 'package:under_control_v2/features/inventory/domain/usecases/item_category/delete_item_category.dart';
import 'package:under_control_v2/features/inventory/domain/usecases/item_category/update_item_category.dart';
import 'package:under_control_v2/features/inventory/presentation/blocs/item_category_management/item_category_management_bloc.dart';
import 'package:under_control_v2/features/user_profile/domain/entities/user_profile.dart';
import 'package:under_control_v2/features/user_profile/presentation/blocs/user_profile/user_profile_bloc.dart';

class MockUserProfileBloc extends Mock
    implements Stream<UserProfileState>, UserProfileBloc {}

class MockAddItemCategory extends Mock implements AddItemCategory {}

class MockUpdateItemCategory extends Mock implements UpdateItemCategory {}

class MockDeleteItemCategory extends Mock implements DeleteItemCategory {}

void main() {
  late MockUserProfileBloc mockUserProfileBloc;

  late MockAddItemCategory mockAddItemCategory;
  late MockUpdateItemCategory mockUpdateItemCategory;
  late MockDeleteItemCategory mockDeleteItemCategory;

  late ItemCategoryManagementBloc itemCategoryManagementBloc;

  const companyId = 'companyId';

  ItemCategoryModel tItemCategoryModel = const ItemCategoryModel(
    id: 'id',
    name: 'name',
  );

  ItemCategoryParams tItemCategoryParams = ItemCategoryParams(
    itemCategory: tItemCategoryModel,
    companyId: companyId,
  );

  setUp(
    () {
      mockAddItemCategory = MockAddItemCategory();
      mockUpdateItemCategory = MockUpdateItemCategory();
      mockDeleteItemCategory = MockDeleteItemCategory();

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
            deviceTokens: const [],
            rejected: false,
            suspended: false,
            userGroups: const [],
          ),
        ),
      );

      itemCategoryManagementBloc = ItemCategoryManagementBloc(
        userProfileBloc: mockUserProfileBloc,
        addItemCategory: mockAddItemCategory,
        updateItemCategory: mockUpdateItemCategory,
        deleteItemCategory: mockDeleteItemCategory,
      );
    },
  );

  setUpAll(
    () {
      registerFallbackValue(tItemCategoryParams);
    },
  );

  group('ItemCategory Management BLoC', () {
    test(
      'should emit [ItemCategoryManagementEmptyState] as an initial state',
      () async {
        // assert
        expect(itemCategoryManagementBloc.state,
            ItemCategoryManagementEmptyState());
      },
    );

    group('AddItemCategory', () {
      blocTest<ItemCategoryManagementBloc, ItemCategoryManagementState>(
        'should emit [ItemCategoryManagementSuccessfulState] when AddItemCategory is called',
        build: () => itemCategoryManagementBloc,
        act: (bloc) async {
          when(() => mockAddItemCategory(any()))
              .thenAnswer((_) async => const Right(''));
          bloc.add(AddItemCategoryEvent(itemCategory: tItemCategoryModel));
        },
        expect: () => [
          ItemCategoryManagementLoadingState(),
          isA<ItemCategoryManagementSuccessState>(),
        ],
      );
      blocTest<ItemCategoryManagementBloc, ItemCategoryManagementState>(
        'should emit [ItemCategoryManagementErrorState] when AddItemCategory is called',
        build: () => itemCategoryManagementBloc,
        act: (bloc) async {
          when(() => mockAddItemCategory(any()))
              .thenAnswer((_) async => const Left(DatabaseFailure()));
          bloc.add(AddItemCategoryEvent(itemCategory: tItemCategoryModel));
        },
        expect: () => [
          ItemCategoryManagementLoadingState(),
          isA<ItemCategoryManagementErrorState>(),
        ],
      );
    });

    group('UpdateItemCategory', () {
      blocTest<ItemCategoryManagementBloc, ItemCategoryManagementState>(
        'should emit [ItemCategoryManagementSuccessfulState] when UpdateItemCategory is called',
        build: () => itemCategoryManagementBloc,
        act: (bloc) async {
          when(() => mockUpdateItemCategory(any()))
              .thenAnswer((_) async => Right(VoidResult()));
          bloc.add(UpdateItemCategoryEvent(itemCategory: tItemCategoryModel));
        },
        expect: () => [
          ItemCategoryManagementLoadingState(),
          isA<ItemCategoryManagementSuccessState>(),
        ],
      );
      blocTest<ItemCategoryManagementBloc, ItemCategoryManagementState>(
        'should emit [ItemCategoryManagementErrorState] when UpdateItemCategory is called',
        build: () => itemCategoryManagementBloc,
        act: (bloc) async {
          when(() => mockUpdateItemCategory(any()))
              .thenAnswer((_) async => const Left(DatabaseFailure()));
          bloc.add(UpdateItemCategoryEvent(itemCategory: tItemCategoryModel));
        },
        expect: () => [
          ItemCategoryManagementLoadingState(),
          isA<ItemCategoryManagementErrorState>(),
        ],
      );
    });

    group('DeleteItemCategory', () {
      blocTest<ItemCategoryManagementBloc, ItemCategoryManagementState>(
        'should emit [ItemCategoryManagementSuccessfulState] when DeleteItemCategory is called',
        build: () => itemCategoryManagementBloc,
        act: (bloc) async {
          when(() => mockDeleteItemCategory(any()))
              .thenAnswer((_) async => Right(VoidResult()));
          bloc.add(DeleteItemCategoryEvent(itemCategory: tItemCategoryModel));
        },
        expect: () => [
          ItemCategoryManagementLoadingState(),
          isA<ItemCategoryManagementSuccessState>(),
        ],
      );
      blocTest<ItemCategoryManagementBloc, ItemCategoryManagementState>(
        'should emit [ItemCategoryManagementErrorState] when DeleteItemCategory is called',
        build: () => itemCategoryManagementBloc,
        act: (bloc) async {
          when(() => mockDeleteItemCategory(any()))
              .thenAnswer((_) async => const Left(DatabaseFailure()));
          bloc.add(DeleteItemCategoryEvent(itemCategory: tItemCategoryModel));
        },
        expect: () => [
          ItemCategoryManagementLoadingState(),
          isA<ItemCategoryManagementErrorState>(),
        ],
      );
    });
  });
}
