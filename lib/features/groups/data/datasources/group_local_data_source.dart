import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/error/exceptions.dart';
import '../../../core/usecases/usecase.dart';

abstract class GroupLocalDataSource {
  Future<SelectedGroupsParams> getCachedGroups();
  Future<void> cacheGroups(SelectedGroupsParams selectedGroupsParams);
}

const ucCachedGroups = 'UC_CACHED_GROUPS';

@LazySingleton(as: GroupLocalDataSource)
class GroupLocalDataSourceImpl extends GroupLocalDataSource {
  final SharedPreferences source;

  GroupLocalDataSourceImpl({
    required this.source,
  });

  @override
  Future<void> cacheGroups(SelectedGroupsParams selectedGroupsParams) async {
    source.setStringList(ucCachedGroups, selectedGroupsParams.groups);
  }

  @override
  Future<SelectedGroupsParams> getCachedGroups() async {
    final groups = source.getStringList(ucCachedGroups);
    if (groups != null) {
      return Future.value(
        SelectedGroupsParams(groups: groups),
      );
    }
    throw CacheException();
  }
}
