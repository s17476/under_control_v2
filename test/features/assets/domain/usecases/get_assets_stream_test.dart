import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:under_control_v2/features/assets/domain/entities/assets_stream.dart';
import 'package:under_control_v2/features/assets/domain/repositories/asset_repository.dart';
import 'package:under_control_v2/features/assets/domain/usecases/get_assets_stream.dart';
import 'package:under_control_v2/features/core/error/failures.dart';
import 'package:under_control_v2/features/core/usecases/usecase.dart';
import 'package:under_control_v2/features/knowledge_base/domain/entities/instructions_stream.dart';
import 'package:under_control_v2/features/knowledge_base/domain/usecases/get_instructions_stream.dart';

class MockAssetRepository extends Mock implements AssetRepository {}

void main() {
  late GetAssetsStream usecase;
  late MockAssetRepository repository;

  const tAssetsInLocationsParams = AssetsInLocationsParams(
    locations: [],
    companyId: 'companyId',
  );

  setUpAll(() {
    registerFallbackValue(tAssetsInLocationsParams);
  });

  setUp(() {
    repository = MockAssetRepository();
    usecase = GetAssetsStream(repository: repository);
  });

  group('Assets', () {
    test(
      'should return [AssetsStream] from repository when GetInstructionsStream is called',
      () async {
        // arrange
        when(() => repository.getAssetsStream(any())).thenAnswer(
          (_) async => Right(
            AssetsStream(
              allAssets: Stream.fromIterable([]),
            ),
          ),
        );
        // act
        final result = await usecase(tAssetsInLocationsParams);
        // assert
        expect(result, isA<Right<Failure, AssetsStream>>());
      },
    );
  });
}
