import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:under_control_v2/features/assets/domain/usecases/check_code_availability.dart';
import 'package:under_control_v2/features/assets/presentation/cubits/cubit/asset_internal_number_cubit.dart';
import 'package:under_control_v2/features/core/error/failures.dart';
import 'package:under_control_v2/features/core/usecases/usecase.dart';

class MockCheckCodeAvailability extends Mock implements CheckCodeAvailability {}

void main() {
  late MockCheckCodeAvailability mockCheckCodeAvailability;
  late AssetInternalNumberCubit assetInternalNumberCubit;

  setUp(() {
    mockCheckCodeAvailability = MockCheckCodeAvailability();
    assetInternalNumberCubit =
        AssetInternalNumberCubit(mockCheckCodeAvailability);
  });

  const tCode = 'internalCode';
  const tCompanyId = 'companyId';
  const tCodeParams = CodeParams(
    internalCode: tCode,
    companyId: tCompanyId,
  );

  setUpAll(() {
    registerFallbackValue(tCodeParams);
  });

  group('AssetinternalNumberCubit', () {
    test(
      'should emit [AssetInternalNumber] as an initial state',
      () async {
        // assert
        expect(assetInternalNumberCubit.state, AssetInternalNumberEmptyState());
      },
    );

    group('checkAssetCodeAvailability', () {
      blocTest<AssetInternalNumberCubit, AssetInternalNumberState>(
        'should emit [AssetInternalNumberLoadedState] when checkAssetCodeAvailability is called',
        build: () => assetInternalNumberCubit,
        act: (cubit) async {
          when(() => mockCheckCodeAvailability(any()))
              .thenAnswer((_) async => const Right(true));
          cubit.checkAssetCodeAvailability(
            code: tCode,
            companyId: tCompanyId,
          );
        },
        expect: () => [
          AssetInternalNumberLoadingState(),
          isA<AssetInternalNumberLoadedState>(),
        ],
      );

      blocTest<AssetInternalNumberCubit, AssetInternalNumberState>(
        'should emit [AssetInternalNumberErrorState] when checkAssetCodeAvailability is called',
        build: () => assetInternalNumberCubit,
        act: (cubit) async {
          when(() => mockCheckCodeAvailability(any()))
              .thenAnswer((_) async => const Left(DatabaseFailure()));
          cubit.checkAssetCodeAvailability(
            code: tCode,
            companyId: tCompanyId,
          );
        },
        expect: () => [
          AssetInternalNumberLoadingState(),
          isA<AssetInternalNumberErrorState>(),
        ],
      );
    });
  });
}
