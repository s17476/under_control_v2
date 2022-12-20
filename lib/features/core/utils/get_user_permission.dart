import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../filter/presentation/blocs/filter/filter_bloc.dart';
import '../../groups/data/models/feature_model.dart';
import '../../groups/domain/entities/feature.dart';
import '../../groups/domain/entities/group.dart';
import 'permission.dart';

bool getUserPermission({
  required BuildContext context,
  required FeatureType featureType,
  required PermissionType permissionType,
  String locationId = '',
}) {
  final state = context.read<FilterBloc>().state;

  if (state is FilterLoadedState) {
    List<Group> groups = [];
    bool permission = false;
    // user is an admin and all possible groups are selected
    if (state.isAdmin && state.groups.isEmpty) {
      permission = true;
      // user is not an admin
    } else {
      if (state.isAdmin) {
        groups = state.groups;
      } else {
        groups = state.allPossibleGroups;
      }

      // gets features
      List<FeatureModel> features = [];

      // without location
      if (locationId.isEmpty) {
        for (var group in groups) {
          features.addAll(
            group.features
                .where((feature) => feature.type == featureType)
                .toList(),
          );
        }
        // depending on location
      } else {
        for (var group in groups) {
          // print('group');
          // print(group.name);
          features.addAll(
            group.features
                .where((feature) =>
                    feature.type == featureType &&
                    group.locations.contains(locationId))
                .toList(),
          );
        }
      }
      // print('features');
      // print(features);

      // check permission
      for (var feature in features) {
        if (permissionType == PermissionType.read && feature.read) {
          permission = true;
        }
        if (permissionType == PermissionType.create && feature.create) {
          permission = true;
        }
        if (permissionType == PermissionType.edit && feature.edit) {
          permission = true;
        }
        if (permissionType == PermissionType.delete && feature.delete) {
          permission = true;
        }
      }
    }
    return permission;
  } else {
    return false;
  }
}
