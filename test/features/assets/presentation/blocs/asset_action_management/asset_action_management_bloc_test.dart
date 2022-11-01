import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:under_control_v2/features/assets/data/models/asset_action/asset_action_model.dart';
import 'package:under_control_v2/features/assets/data/models/asset_model.dart';
import 'package:under_control_v2/features/assets/domain/usecases/asset_action/add_asset_action.dart';
import 'package:under_control_v2/features/assets/domain/usecases/asset_action/delete_asset_action.dart';
import 'package:under_control_v2/features/assets/domain/usecases/asset_action/update_asset_action.dart';
import 'package:under_control_v2/features/assets/presentation/blocs/asset_action_management/asset_action_management_bloc.dart';
import 'package:under_control_v2/features/assets/utils/asset_status.dart';
import 'package:under_control_v2/features/company_profile/presentation/blocs/company_profile/company_profile_bloc.dart';
import 'package:under_control_v2/features/core/error/failures.dart';
import 'package:under_control_v2/features/core/usecases/usecase.dart';
import 'package:under_control_v2/features/core/utils/duration_unit.dart';

class MockCompanyProfileBloc extends Mock
    implements Stream<CompanyProfileState>, CompanyProfileBloc {}

class MockAddAssetAction extends Mock implements AddAssetAction {}

class MockUpdateAssetAction extends Mock implements UpdateAssetAction {}

class MockDeleteAssetAction extends Mock implements DeleteAssetAction {}

void main() {
  late MockCompanyProfileBloc mockCompanyProfileBloc;

  late MockAddAssetAction mockAddAssetAction;
  late MockDeleteAssetAction mockDeleteAssetAction;
  late MockUpdateAssetAction mockUpdateAssetAction;

  late AssetActionManagementBloc assetActionManagementBloc;

  const tCompanyId = 'companyId';

  final tAsset = AssetModel(
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
    durationUnit: DurationUnit.year,
    duration: 1,
    images: const [],
    documents: const [],
    spareParts: const [],
    instructions: const [],
    currentParentId: 'currentParentId',
    isSparePart: true,
  );

  final tAssetAction = AssetActionModel(
    id: 'id',
    assetId: 'assetId',
    dateTime: DateTime.now(),
    userId: 'description',
    locationId: 'locationId',
    isAssetInUse: true,
    isCreate: false,
    assetStatus: AssetStatus.ok,
    connectedTask: 'connectedTask',
    connectedWorkOrder: 'connectedWorkOrder',
  );

  final tAssetActionParams = AssetActionParams(
    updatedAsset: tAsset,
    assetAction: tAssetAction,
    companyId: tCompanyId,
  );

  setUp(() {
    mockCompanyProfileBloc = MockCompanyProfileBloc();
    when(() => mockCompanyProfileBloc.stream).thenAnswer(
      (_) => Stream.fromFuture(
        Future.value(CompanyProfileEmpty()),
      ),
    );

    mockAddAssetAction = MockAddAssetAction();
    mockDeleteAssetAction = MockDeleteAssetAction();
    mockUpdateAssetAction = MockUpdateAssetAction();

    assetActionManagementBloc = AssetActionManagementBloc(
      companyProfileBloc: mockCompanyProfileBloc,
      addAssetAction: mockAddAssetAction,
      updateAssetAction: mockUpdateAssetAction,
      deleteAssetAction: mockDeleteAssetAction,
    );
  });

  setUpAll(() {
    registerFallbackValue(tAssetActionParams);
  });

  group('AssetAction Management BLoC', () {
    test(
      'should emit [AssetActionManagementEmptyState] as an initial state',
      () async {
        // assert
        expect(
          assetActionManagementBloc.state,
          AssetActionManagementEmptyState(),
        );
      },
    );

    group('AddAssetAction', () {
      blocTest<AssetActionManagementBloc, AssetActionManagementState>(
        'should emit [AssetActionManagementSuccessfulSate] when AddAssetAction is called',
        build: () => assetActionManagementBloc,
        act: (bloc) async {
          when(() => mockAddAssetAction(any()))
              .thenAnswer((_) async => const Right(''));
          bloc.add(
            AddAssetActionEvent(
              asset: tAsset,
              assetAction: tAssetAction,
            ),
          );
        },
        expect: () => [
          AssetActionManagementLoadingState(),
          isA<AssetActionManagementSuccessState>(),
        ],
      );
      blocTest<AssetActionManagementBloc, AssetActionManagementState>(
        'should emit [AssetActionManagementErrorSate] when AddAssetAction is called',
        build: () => assetActionManagementBloc,
        act: (bloc) async {
          when(() => mockAddAssetAction(any()))
              .thenAnswer((_) async => const Left(DatabaseFailure()));
          bloc.add(
            AddAssetActionEvent(
              asset: tAsset,
              assetAction: tAssetAction,
            ),
          );
        },
        expect: () => [
          AssetActionManagementLoadingState(),
          isA<AssetActionManagementErrorState>(),
        ],
      );
    });
    group('DeleteAssetAction', () {
      blocTest<AssetActionManagementBloc, AssetActionManagementState>(
        'should emit [Voidresult] when DeleteAssetAction is called',
        build: () => assetActionManagementBloc,
        act: (bloc) async {
          when(() => mockDeleteAssetAction(any()))
              .thenAnswer((_) async => Right(VoidResult()));
          bloc.add(
            DeleteAssetActionEvent(
              asset: tAsset,
              assetAction: tAssetAction,
            ),
          );
        },
        expect: () => [
          AssetActionManagementLoadingState(),
          isA<AssetActionManagementSuccessState>(),
        ],
      );
      blocTest<AssetActionManagementBloc, AssetActionManagementState>(
        'should emit [AssetActionManagementErrorSate] when DeleteAssetAction is called',
        build: () => assetActionManagementBloc,
        act: (bloc) async {
          when(() => mockDeleteAssetAction(any()))
              .thenAnswer((_) async => const Left(DatabaseFailure()));
          bloc.add(
            DeleteAssetActionEvent(
              asset: tAsset,
              assetAction: tAssetAction,
            ),
          );
        },
        expect: () => [
          AssetActionManagementLoadingState(),
          isA<AssetActionManagementErrorState>(),
        ],
      );
    });
    group('UpdateAssetAction', () {
      blocTest<AssetActionManagementBloc, AssetActionManagementState>(
        'should emit [Voidresult] when UpdateAssetAction is called',
        build: () => assetActionManagementBloc,
        act: (bloc) async {
          when(() => mockUpdateAssetAction(any()))
              .thenAnswer((_) async => Right(VoidResult()));
          bloc.add(
            UpdateAssetActionEvent(
              asset: tAsset,
              oldAssetAction: tAssetAction,
              assetAction: tAssetAction,
            ),
          );
        },
        expect: () => [
          AssetActionManagementLoadingState(),
          isA<AssetActionManagementSuccessState>(),
        ],
      );
      blocTest<AssetActionManagementBloc, AssetActionManagementState>(
        'should emit [AssetActionManagementErrorSate] when UpdateAssetAction is called',
        build: () => assetActionManagementBloc,
        act: (bloc) async {
          when(() => mockUpdateAssetAction(any()))
              .thenAnswer((_) async => const Left(DatabaseFailure()));
          bloc.add(
            UpdateAssetActionEvent(
              asset: tAsset,
              oldAssetAction: tAssetAction,
              assetAction: tAssetAction,
            ),
          );
        },
        expect: () => [
          AssetActionManagementLoadingState(),
          isA<AssetActionManagementErrorState>(),
        ],
      );
    });
  });
}
