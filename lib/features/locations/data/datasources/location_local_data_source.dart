import 'package:shared_preferences/shared_preferences.dart';
import 'package:injectable/injectable.dart';
import 'package:under_control_v2/features/core/usecases/usecase.dart';

import '../../../core/error/exceptions.dart';

abstract class LocationLocalDataSource {
  Future<SelectedLocationsParams> getCachedLocation();
  Future<void> cacheLocation(SelectedLocationsParams selectedLocationsParams);
}

const ucCachedLocations = 'UC_CACHED_LOCATIONS';
const ucCachedChildren = 'UC_CACHED_CHILDREN';

@LazySingleton(as: LocationLocalDataSource)
class LocationLocalDataSourceImpl extends LocationLocalDataSource {
  final SharedPreferences source;

  LocationLocalDataSourceImpl({
    required this.source,
  });

  @override
  Future<void> cacheLocation(
      SelectedLocationsParams selectedLocationsParams) async {
    source.setStringList(ucCachedLocations, selectedLocationsParams.locations);
    source.setStringList(ucCachedChildren, selectedLocationsParams.children);
  }

  @override
  Future<SelectedLocationsParams> getCachedLocation() async {
    final locations = source.getStringList(ucCachedLocations);
    final children = source.getStringList(ucCachedChildren);
    if (locations != null && children != null) {
      return Future.value(
        SelectedLocationsParams(
          locations: locations,
          children: children,
        ),
      );
    }
    throw CacheException();
  }
}
