import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:under_control_v2/features/authentication/presentation/blocs/authentication/authentication_bloc.dart';
import 'package:under_control_v2/features/core/error/failures.dart';
import 'package:under_control_v2/features/core/usecases/usecase.dart';
import 'package:under_control_v2/features/inventory/data/models/item_category/item_category_model.dart';
import 'package:under_control_v2/features/inventory/domain/entities/item_category/items_categories_stream.dart';
import 'package:under_control_v2/features/inventory/domain/usecases/item_category/get_items_categories_stream.dart';
import 'package:under_control_v2/features/inventory/presentation/blocs/item_category/item_category_bloc.dart';
import 'package:under_control_v2/features/user_profile/presentation/blocs/user_profile/user_profile_bloc.dart';

class MockUserProfileBloc extends Mock
    implements Stream<UserProfileState>, UserProfileBloc {}

class MockGetItemsCategoriesStream extends Mock
    implements GetItemsCategoriesStream {}

class MockAuthenticationBloc extends Mock
    implements Stream<AuthenticationState>, AuthenticationBloc {}

void main() {
  late MockAuthenticationBloc mockAuthenticationBloc;
  late MockUserProfileBloc mockUserProfileBloc;
  late MockGetItemsCategoriesStream mockGetItemsCategoriesStream;
  late ItemCategoryBloc itemCategoryBloc;

  const companyId = 'companyId';

  const tItemCategoryModel = ItemCategoryModel(id: 'id', name: 'name');

  const tItemcategoryParams = ItemCategoryParams(
    itemCategory: tItemCategoryModel,
    companyId: companyId,
  );

  setUp(
    () {
      mockUserProfileBloc = MockUserProfileBloc();
      mockGetItemsCategoriesStream = MockGetItemsCategoriesStream();

      when(() => mockUserProfileBloc.stream).thenAnswer(
        (_) => Stream.fromFuture(
          Future.value(UserProfileEmpty()),
        ),
      );
      mockAuthenticationBloc = MockAuthenticationBloc();
      when(() => mockAuthenticationBloc.stream).thenAnswer(
        (_) => Stream.fromFuture(
          Future.value(EmptyAuthenticationState()),
        ),
      );

      itemCategoryBloc = ItemCategoryBloc(
        authenticationBloc: mockAuthenticationBloc,
        userProfileBloc: mockUserProfileBloc,
        getItemsCategoriesStream: mockGetItemsCategoriesStream,
      );
    },
  );

  setUpAll(
    () {
      registerFallbackValue(tItemcategoryParams);
    },
  );

  group('ItemCategory BLoC', () {
    test(
      'should emit [ItemCategoryEmptyState] as an initial state',
      () async {
        // assert
        expect(itemCategoryBloc.state, ItemCategoryEmptyState());
      },
    );

    group(
      'GetItemsCategoriesStream',
      () {
        blocTest<ItemCategoryBloc, ItemCategoryState>(
          'should emit [ItemCategoryLoadingState]  when GetLAllChecklistsEvent is called',
          build: () => itemCategoryBloc,
          act: (bloc) async {
            bloc.add(GetAllItemsCategoriesEvent());
            when(() => mockGetItemsCategoriesStream(any())).thenAnswer(
              (_) async => Right(
                ItemsCategoriesStream(
                  allItemsCategories: Stream.fromIterable([]),
                ),
              ),
            );
          },
          expect: () => [
            ItemCategoryLoadingState(),
          ],
        );
        blocTest<ItemCategoryBloc, ItemCategoryState>(
          'should emit [ItemCategoryErrorState] when GetLAllItemsCategoriesEvent is called',
          build: () => itemCategoryBloc,
          act: (bloc) async {
            bloc.add(GetAllItemsCategoriesEvent());
            when(() => mockGetItemsCategoriesStream(any())).thenAnswer(
              (_) async => const Left(
                DatabaseFailure(),
              ),
            );
          },
          expect: () => [
            ItemCategoryLoadingState(),
            isA<ItemCategoryErrorState>(),
          ],
        );
      },
    );
  });
}
