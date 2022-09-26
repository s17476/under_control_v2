import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../filter/presentation/blocs/filter/filter_bloc.dart';
import '../../groups/data/models/feature_model.dart';
import '../../groups/domain/entities/feature.dart';
import '../../groups/domain/entities/group.dart';
import 'premission.dart';

bool getUserPremission({
  required BuildContext context,
  required FeatureType featureType,
  required PremissionType premissionType,
  String locationId = '',
}) {
  final state = context.read<FilterBloc>().state;

  if (state is FilterLoadedState) {
    List<Group> groups = [];
    bool premission = false;
    // user is an admin and all possible groups are selected
    // or user is an admin and no groups are selected
    if (state.isAdmin &&
        (state.groups.isEmpty ||
            state.groups
                    .where((group) => state.allPossibleGroups.contains(group))
                    .length ==
                state.allPossibleGroups.length)) {
      premission = true;
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

      // check premission
      for (var feature in features) {
        if (premissionType == PremissionType.read && feature.read) {
          premission = true;
        }
        if (premissionType == PremissionType.create && feature.create) {
          premission = true;
        }
        if (premissionType == PremissionType.edit && feature.edit) {
          premission = true;
        }
        if (premissionType == PremissionType.delete && feature.delete) {
          premission = true;
        }
      }
    }
    return premission;
  } else {
    return false;
  }
}
