import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:under_control_v2/features/core/error/exceptions.dart';
import 'package:under_control_v2/features/locations/data/datasources/location_local_data_source.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  late MockSharedPreferences mockSharedPreferences;
  late LocationLocalDataSource dataSource;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    dataSource = LocationLocalDataSourceImpl(source: mockSharedPreferences);
  });

  const locationId = 'locationId';

  group(
    'LocationLocalDatasource',
    () {
      group('getCachedLocation', () {
        test(
          'should return cached location id from SharedPreferences if there is one in the cache',
          () async {
            // arrange
            when(() => mockSharedPreferences.getString(any()))
                .thenReturn(locationId);
            // act
            final result = await dataSource.getCachedLocation();
            // assert
            verify(() => mockSharedPreferences.getString(ucCachedLocation));
            expect(result, locationId);
          },
        );

        test(
          'should throw CacheException when there is no cached value',
          () async {
            // arrange
            when(() => mockSharedPreferences.getString(any())).thenReturn(null);
            // act
            final call = dataSource.getCachedLocation;
            // assert
            expect(() => call(), throwsA(const TypeMatcher<CacheException>()));
          },
        );
      });
      group('cacheLocation', () {
        test(
          'should store tLocationModel in SharedPreferences to cache the data',
          () async {
            // arrange
            SharedPreferences.setMockInitialValues({});
            final SharedPreferences sharedPreferences =
                await SharedPreferences.getInstance();
            dataSource = LocationLocalDataSourceImpl(source: sharedPreferences);
            // act
            await dataSource.cacheLocation(locationId);
            // assert
            final expectedLocation = await dataSource.getCachedLocation();
            expect(expectedLocation, locationId);
          },
        );
      });
    },
  );
}
