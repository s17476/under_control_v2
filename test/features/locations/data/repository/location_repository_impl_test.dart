import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:under_control_v2/features/core/usecases/usecase.dart';
import 'package:under_control_v2/features/locations/data/datasources/location_local_data_source.dart';
import 'package:under_control_v2/features/locations/data/datasources/location_remote_data_source.dart';
import 'package:under_control_v2/features/locations/data/models/location_model.dart';
import 'package:under_control_v2/features/locations/data/repositories/location_repository_impl.dart';
import 'package:under_control_v2/features/locations/domain/repositories/location_repository.dart';

class MockLocationRepository extends Mock implements LocationRepository {}

class MockLocationLocalDataSource extends Mock
    implements LocationLocalDataSource {}

class MockLocationRemoteDataSource extends Mock
    implements LocationRemoteDataSource {}

void main() {
  late MockLocationLocalDataSource mockLocationLocalDataSource;
  late MockLocationRemoteDataSource mockLocationRemoteDataSource;
  late LocationRepositoryImpl mockLocationRepository;

  setUp(() {
    mockLocationLocalDataSource = MockLocationLocalDataSource();
    mockLocationRemoteDataSource = MockLocationRemoteDataSource();
    mockLocationRepository = LocationRepositoryImpl(
      locationLocalDataSource: mockLocationLocalDataSource,
      locationRemoteDataSource: mockLocationRemoteDataSource,
    );
  });

  const tLocation = LocationModel(
    id: 'id',
    name: 'name',
    parentId: 'parentId',
    children: ['children'],
  );

  const tLocationParams = LocationParams(
    location: tLocation,
    comapnyId: 'comapnyId',
  );

  group('LocationRepositoryImpl', () {
    group('CacheLocation usecase', () {
      test(
        'should cache data locally',
        () async {
          // arrange
          when(() => mockLocationLocalDataSource.cacheLocation(any()))
              .thenAnswer((_) => Future.value());
          // act
          await mockLocationRepository.cacheLocation(tLocationParams);
          // assert
          verify(() => mockLocationLocalDataSource
              .cacheLocation(tLocationParams.location.id));
        },
      );
    });
  });
}
