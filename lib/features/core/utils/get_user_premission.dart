import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:under_control_v2/features/core/utils/premission.dart';
import 'package:under_control_v2/features/filter/presentation/blocs/filter/filter_bloc.dart';
import 'package:under_control_v2/features/groups/domain/entities/feature.dart';

import '../../groups/domain/entities/group.dart';

bool getUserPremission({
  required BuildContext context,
  required FeatureType featureType,
  required PremissionType premissionType,
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

      for (var group in state.allPossibleGroups) {}
    }
    return premission;
  } else {
    return false;
  }
}
