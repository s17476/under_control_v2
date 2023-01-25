import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:under_control_v2/features/assets/data/models/asset_model.dart';
import 'package:under_control_v2/features/assets/domain/usecases/add_asset.dart';
import 'package:under_control_v2/features/assets/domain/usecases/delete_asset.dart';
import 'package:under_control_v2/features/assets/domain/usecases/update_asset.dart';
import 'package:under_control_v2/features/assets/presentation/blocs/asset_management/asset_management_bloc.dart';
import 'package:under_control_v2/features/assets/utils/asset_status.dart';
import 'package:under_control_v2/features/core/error/failures.dart';
import 'package:under_control_v2/features/core/usecases/usecase.dart';
import 'package:under_control_v2/features/core/utils/duration_unit.dart';
import 'package:under_control_v2/features/user_profile/domain/entities/user_profile.dart';
import 'package:under_control_v2/features/user_profile/presentation/blocs/user_profile/user_profile_bloc.dart';

class MockUserProfileBloc extends Mock
    implements Stream<UserProfileState>, UserProfileBloc {}

class MockAddAsset extends Mock implements AddAsset {}

class MockDeleteAsset extends Mock implements DeleteAsset {}

class MockUpdateAsset extends Mock implements UpdateAsset {}

void main() {
  late MockUserProfileBloc mockUserProfileBloc;

  late MockAddAsset mockAddAsset;
  late MockDeleteAsset mockDeleteAsset;
  late MockUpdateAsset mockUpdateAsset;

  late AssetManagementBloc assetManagementBloc;

  const tCompanyId = 'companyId';

  AssetModel tAssetModel = AssetModel(
    id: 'id',
    producer: 'producer',
    model: 'model',
    description: 'description',
    categoryId: 'categoryId',
    locationId: 'locationId',
    internalCode: 'internalCode',
    barCode: 'barCode',
    price: 0,
    isInUse: true,
    addDate: DateTime.now(),
    currentStatus: AssetStatus.ok,
    lastInspection: DateTime.now(),
    durationUnit: DurationUnit.day,
    duration: 1,
    images: const [],
    documents: const [],
    spareParts: const [],
    instructions: const [],
    currentParentId: 'currentParentId',
    isSparePart: true,
  );

  AssetParams tAssetParams = AssetParams(
    asset: tAssetModel,
    companyId: tCompanyId,
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
          deviceTokens: const [],
          rejected: false,
          suspended: false,
          userGroups: const [],
        ),
      ),
    );

    mockAddAsset = MockAddAsset();
    mockDeleteAsset = MockDeleteAsset();
    mockUpdateAsset = MockUpdateAsset();

    assetManagementBloc = AssetManagementBloc(
      userProfileBloc: mockUserProfileBloc,
      addAsset: mockAddAsset,
      deleteAsset: mockDeleteAsset,
      updateAsset: mockUpdateAsset,
    );
  });

  setUpAll(() {
    registerFallbackValue(tAssetParams);
  });

  group('AssetManagement BLoC', () {
    test(
      'should emit [AssetManagementEmptyState] as an initial state',
      () async {
        // assert
        expect(assetManagementBloc.state, isA<AssetManagementEmptyState>());
      },
    );

    group('AddAssetEvent', () {
      blocTest<AssetManagementBloc, AssetManagementState>(
        'should emit [AssetManagementSuccessfulState] when AddAsset is called',
        build: () => assetManagementBloc,
        act: (bloc) async {
          when(() => mockAddAsset(any())).thenAnswer(
            (_) async => const Right(''),
          );
          bloc.add(
            AddAssetEvent(
              asset: tAssetModel,
              documents: const [],
              images: const [],
            ),
          );
        },
        expect: () => [
          AssetManagementLoadingState(),
          isA<AssetManagementSuccessState>(),
        ],
      );
      blocTest<AssetManagementBloc, AssetManagementState>(
        'should emit [AssetManagementErrorState] when AddAsset is called',
        build: () => assetManagementBloc,
        act: (bloc) async {
          when(() => mockAddAsset(any())).thenAnswer(
            (_) async => const Left(DatabaseFailure()),
          );
          bloc.add(
            AddAssetEvent(
              asset: tAssetModel,
              documents: const [],
              images: const [],
            ),
          );
        },
        expect: () => [
          AssetManagementLoadingState(),
          isA<AssetManagementErrorState>(),
        ],
      );
    });

    group('DeleteAssetEvent', () {
      blocTest<AssetManagementBloc, AssetManagementState>(
        'should emit [AssetManagementSuccessfulState] when DeleteAsset is called',
        build: () => assetManagementBloc,
        act: (bloc) async {
          when(() => mockDeleteAsset(any())).thenAnswer(
            (_) async => Right(VoidResult()),
          );
          bloc.add(DeleteAssetEvent(asset: tAssetModel));
        },
        expect: () => [
          AssetManagementLoadingState(),
          isA<AssetManagementSuccessState>(),
        ],
      );
      blocTest<AssetManagementBloc, AssetManagementState>(
        'should emit [AssetManagementErrorState] when DeleteAsset is called',
        build: () => assetManagementBloc,
        act: (bloc) async {
          when(() => mockDeleteAsset(any())).thenAnswer(
            (_) async => const Left(DatabaseFailure()),
          );
          bloc.add(DeleteAssetEvent(asset: tAssetModel));
        },
        expect: () => [
          AssetManagementLoadingState(),
          isA<AssetManagementErrorState>(),
        ],
      );
    });

    group('UpdateAssetEvent', () {
      blocTest<AssetManagementBloc, AssetManagementState>(
        'should emit [AssetManagementSuccessfulState] when UpdateAsset is called',
        build: () => assetManagementBloc,
        act: (bloc) async {
          when(() => mockUpdateAsset(any())).thenAnswer(
            (_) async => Right(VoidResult()),
          );
          bloc.add(
            UpdateAssetEvent(
              asset: tAssetModel,
              documents: const [],
              images: const [],
            ),
          );
        },
        expect: () => [
          AssetManagementLoadingState(),
          isA<AssetManagementSuccessState>(),
        ],
      );
      blocTest<AssetManagementBloc, AssetManagementState>(
        'should emit [AssetManagementErrorState] when UpdateAsset is called',
        build: () => assetManagementBloc,
        act: (bloc) async {
          when(() => mockUpdateAsset(any())).thenAnswer(
            (_) async => const Left(DatabaseFailure()),
          );
          bloc.add(
            UpdateAssetEvent(
              asset: tAssetModel,
              documents: const [],
              images: const [],
            ),
          );
        },
        expect: () => [
          AssetManagementLoadingState(),
          isA<AssetManagementErrorState>(),
        ],
      );
    });
  });
}
