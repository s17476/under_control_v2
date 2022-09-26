import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:under_control_v2/features/filter/presentation/blocs/filter/filter_bloc.dart';

import '../domain/entities/item.dart';

/// Calculates quantity of given item in selected locations.
///
/// Returns [double].
double getItemQuantityInLocations(BuildContext context, Item item) {
  double result = 0;
  final state = context.read<FilterBloc>().state;
  if (state is FilterLoadedState) {
    for (var amountInLocation in item.amountInLocations) {
      if (state.locations
          .map((loc) => loc.id)
          .contains(amountInLocation.locationId)) {
        result += amountInLocation.amount;
      }
    }
  }
  return result;
}
