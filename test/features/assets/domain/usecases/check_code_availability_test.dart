import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:under_control_v2/features/assets/domain/repositories/asset_repository.dart';
import 'package:under_control_v2/features/assets/domain/usecases/check_code_availability.dart';
import 'package:under_control_v2/features/core/error/failures.dart';
import 'package:under_control_v2/features/core/usecases/usecase.dart';

class MockAssetRepository extends Mock implements AssetRepository {}

void main() {
  late CheckCodeAvailability usecase;
  late MockAssetRepository repository;

  const tCompanyId = 'companyId';

  const tCode = 'newCode';

  const tCodeParams = CodeParams(
    internalCode: tCode,
    companyId: tCompanyId,
  );

  setUpAll(() {
    registerFallbackValue(tCodeParams);
  });

  setUp(() {
    repository = MockAssetRepository();
    usecase = CheckCodeAvailability(repository: repository);
  });

  group('Assets', () {
    test(
      'should return [bool] from repository when CheckCodeAvailability is called',
      () async {
        // arrange
        when(() => repository.checkCodeAvailability(any()))
            .thenAnswer((_) async => const Right(true));
        // act
        final result = await usecase(tCodeParams);
        // assert
        expect(result, isA<Right<Failure, bool>>());
      },
    );
  });
}
