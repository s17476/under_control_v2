import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:under_control_v2/features/assets/data/models/asset_category/asset_category_model.dart';
import 'package:under_control_v2/features/assets/domain/entities/asset_category/assets_categories_stream.dart';
import 'package:under_control_v2/features/assets/domain/usecases/asset_category/get_assets_categories_stream.dart';
import 'package:under_control_v2/features/assets/presentation/blocs/asset_category/asset_category_bloc.dart';
import 'package:under_control_v2/features/core/error/failures.dart';
import 'package:under_control_v2/features/core/usecases/usecase.dart';
import 'package:under_control_v2/features/user_profile/presentation/blocs/user_profile/user_profile_bloc.dart';

class MockUserProfileBloc extends Mock
    implements Stream<UserProfileState>, UserProfileBloc {}

class MockGetAssetsCategoriesStream extends Mock
    implements GetAssetsCategoriesStream {}

void main() {
  late MockUserProfileBloc mockUserProfileBloc;
  late MockGetAssetsCategoriesStream mockGetAssetsCategoriesStream;
  late AssetCategoryBloc assetCategoryBloc;

  const companyId = 'companyId';

  const tAssetCategoryModel = AssetCategoryModel(id: 'id', name: 'name');

  const tAssetCategoryParams = AssetCategoryParams(
    assetCategory: tAssetCategoryModel,
    companyId: companyId,
  );

  setUp(
    () {
      mockUserProfileBloc = MockUserProfileBloc();
      mockGetAssetsCategoriesStream = MockGetAssetsCategoriesStream();

      when(() => mockUserProfileBloc.stream).thenAnswer(
        (_) => Stream.fromFuture(
          Future.value(UserProfileEmpty()),
        ),
      );

      assetCategoryBloc = AssetCategoryBloc(
        userProfileBloc: mockUserProfileBloc,
        getAssetsCategoriesStream: mockGetAssetsCategoriesStream,
      );
    },
  );

  setUpAll(
    () {
      registerFallbackValue(tAssetCategoryParams);
    },
  );

  group('AssetCategory BLoC', () {
    test(
      'should emit [AssetCategoryEmptyState] as an initial state',
      () async {
        // assert
        expect(assetCategoryBloc.state, AssetCategoryEmptyState());
      },
    );

    group(
      'GetAssetsCategoriesStream',
      () {
        blocTest<AssetCategoryBloc, AssetCategoryState>(
          'should emit [AssetCategoryLoadingState]  when GetAssetsCategoriesEvent is called',
          build: () => assetCategoryBloc,
          act: (bloc) async {
            bloc.add(GetAllAssetsCategoriesEvent());
            when(() => mockGetAssetsCategoriesStream(any())).thenAnswer(
              (_) async => Right(
                AssetsCategoriesStream(
                  allAssetsCategories: Stream.fromIterable([]),
                ),
              ),
            );
          },
          expect: () => [
            AssetCategoryLoadingState(),
          ],
        );
        blocTest<AssetCategoryBloc, AssetCategoryState>(
          'should emit [AssetCategoryErrorState] when GetLAllAssetsCategoriesEvent is called',
          build: () => assetCategoryBloc,
          act: (bloc) async {
            bloc.add(GetAllAssetsCategoriesEvent());
            when(() => mockGetAssetsCategoriesStream(any())).thenAnswer(
              (_) async => const Left(
                DatabaseFailure(),
              ),
            );
          },
          expect: () => [
            AssetCategoryLoadingState(),
            isA<AssetCategoryErrorState>(),
          ],
        );
      },
    );
  });
}
