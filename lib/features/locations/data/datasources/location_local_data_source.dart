import 'package:shared_preferences/shared_preferences.dart';
import 'package:injectable/injectable.dart';

import '../../../core/error/exceptions.dart';

abstract class LocationLocalDataSource {
  Future<String> getCachedLocation();
  Future<void> cacheLocation(String locationId);
}

const ucCachedLocation = 'UC_CACHED_LOCATION';

@LazySingleton(as: LocationLocalDataSource)
class LocationLocalDataSourceImpl extends LocationLocalDataSource {
  final SharedPreferences source;

  LocationLocalDataSourceImpl({
    required this.source,
  });

  @override
  Future<void> cacheLocation(String locationId) {
    return source.setString(ucCachedLocation, locationId);
  }

  @override
  Future<String> getCachedLocation() {
    final locationId = source.getString(ucCachedLocation);
    if (locationId != null) {
      return Future.value(locationId);
    }
    throw CacheException();
  }
}
