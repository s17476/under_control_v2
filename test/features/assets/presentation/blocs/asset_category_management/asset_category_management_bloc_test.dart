import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:under_control_v2/features/assets/data/models/asset_category/asset_category_model.dart';
import 'package:under_control_v2/features/assets/domain/usecases/asset_category/add_asset_category.dart';
import 'package:under_control_v2/features/assets/domain/usecases/asset_category/delete_asset_category.dart';
import 'package:under_control_v2/features/assets/domain/usecases/asset_category/update_asset_category.dart';
import 'package:under_control_v2/features/assets/presentation/blocs/asset_category_management/asset_category_management_bloc.dart';
import 'package:under_control_v2/features/core/error/failures.dart';
import 'package:under_control_v2/features/core/usecases/usecase.dart';
import 'package:under_control_v2/features/user_profile/domain/entities/user_profile.dart';
import 'package:under_control_v2/features/user_profile/presentation/blocs/user_profile/user_profile_bloc.dart';

class MockUserProfileBloc extends Mock
    implements Stream<UserProfileState>, UserProfileBloc {}

class MockAddAssetCategory extends Mock implements AddAssetCategory {}

class MockUpdateAssetCategory extends Mock implements UpdateAssetCategory {}

class MockDeleteAssetCategory extends Mock implements DeleteAssetCategory {}

void main() {
  late MockUserProfileBloc mockUserProfileBloc;

  late MockAddAssetCategory mockAddAssetCategory;
  late MockUpdateAssetCategory mockUpdateAssetCategory;
  late MockDeleteAssetCategory mockDeleteAssetCategory;

  late AssetCategoryManagementBloc assetCategoryManagementBloc;

  const companyId = 'companyId';

  AssetCategoryModel tAssetCategoryModel = const AssetCategoryModel(
    id: 'id',
    name: 'name',
  );

  AssetCategoryParams tAssetCategoryParams = AssetCategoryParams(
    assetCategory: tAssetCategoryModel,
    companyId: companyId,
  );

  setUp(
    () {
      mockAddAssetCategory = MockAddAssetCategory();
      mockUpdateAssetCategory = MockUpdateAssetCategory();
      mockDeleteAssetCategory = MockDeleteAssetCategory();

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

      assetCategoryManagementBloc = AssetCategoryManagementBloc(
        userProfileBloc: mockUserProfileBloc,
        addAssetCategory: mockAddAssetCategory,
        updateAssetCategory: mockUpdateAssetCategory,
        deleteAssetCategory: mockDeleteAssetCategory,
      );
    },
  );

  setUpAll(
    () {
      registerFallbackValue(tAssetCategoryParams);
    },
  );

  group('AssetCategory Management BLoC', () {
    test(
      'should emit [AssetCategoryManagementEmptyState] as an initial state',
      () async {
        // assert
        expect(
          assetCategoryManagementBloc.state,
          AssetCategoryManagementEmptyState(),
        );
      },
    );

    group('AddAssetCategory', () {
      blocTest<AssetCategoryManagementBloc, AssetCategoryManagementState>(
        'should emit [AssetCategoryManagementSuccessfulState] when AddAssetCategory is called',
        build: () => assetCategoryManagementBloc,
        act: (bloc) async {
          when(() => mockAddAssetCategory(any()))
              .thenAnswer((_) async => const Right(''));
          bloc.add(AddAssetCategoryEvent(assetCategory: tAssetCategoryModel));
        },
        expect: () => [
          AssetCategoryManagementLoadingState(),
          isA<AssetCategoryManagementSuccessState>(),
        ],
      );
      blocTest<AssetCategoryManagementBloc, AssetCategoryManagementState>(
        'should emit [AssetCategoryManagementErrorState] when AddAssetCategory is called',
        build: () => assetCategoryManagementBloc,
        act: (bloc) async {
          when(() => mockAddAssetCategory(any()))
              .thenAnswer((_) async => const Left(DatabaseFailure()));
          bloc.add(
            AddAssetCategoryEvent(assetCategory: tAssetCategoryModel),
          );
        },
        expect: () => [
          AssetCategoryManagementLoadingState(),
          isA<AssetCategoryManagementErrorState>(),
        ],
      );
    });

    group('UpdateAssetCategory', () {
      blocTest<AssetCategoryManagementBloc, AssetCategoryManagementState>(
        'should emit [AssetCategoryManagementSuccessfulState] when UpdateAssetCategory is called',
        build: () => assetCategoryManagementBloc,
        act: (bloc) async {
          when(() => mockUpdateAssetCategory(any()))
              .thenAnswer((_) async => Right(VoidResult()));
          bloc.add(
              UpdateAssetCategoryEvent(assetCategory: tAssetCategoryModel));
        },
        expect: () => [
          AssetCategoryManagementLoadingState(),
          isA<AssetCategoryManagementSuccessState>(),
        ],
      );
      blocTest<AssetCategoryManagementBloc, AssetCategoryManagementState>(
        'should emit [AssetCategoryManagementErrorState] when UpdateAssetCategory is called',
        build: () => assetCategoryManagementBloc,
        act: (bloc) async {
          when(() => mockUpdateAssetCategory(any()))
              .thenAnswer((_) async => const Left(DatabaseFailure()));
          bloc.add(
            UpdateAssetCategoryEvent(assetCategory: tAssetCategoryModel),
          );
        },
        expect: () => [
          AssetCategoryManagementLoadingState(),
          isA<AssetCategoryManagementErrorState>(),
        ],
      );
    });

    group('DeleteAssetCategory', () {
      blocTest<AssetCategoryManagementBloc, AssetCategoryManagementState>(
        'should emit [AssetCategoryManagementSuccessfulState] when DeleteAssetCategory is called',
        build: () => assetCategoryManagementBloc,
        act: (bloc) async {
          when(() => mockDeleteAssetCategory(any()))
              .thenAnswer((_) async => Right(VoidResult()));
          bloc.add(
            DeleteAssetCategoryEvent(assetCategory: tAssetCategoryModel),
          );
        },
        expect: () => [
          AssetCategoryManagementLoadingState(),
          isA<AssetCategoryManagementSuccessState>(),
        ],
      );
      blocTest<AssetCategoryManagementBloc, AssetCategoryManagementState>(
        'should emit [AssetCategoryManagementErrorState] when DeleteAssetCategory is called',
        build: () => assetCategoryManagementBloc,
        act: (bloc) async {
          when(() => mockDeleteAssetCategory(any()))
              .thenAnswer((_) async => const Left(DatabaseFailure()));
          bloc.add(
              DeleteAssetCategoryEvent(assetCategory: tAssetCategoryModel));
        },
        expect: () => [
          AssetCategoryManagementLoadingState(),
          isA<AssetCategoryManagementErrorState>(),
        ],
      );
    });
  });
}
