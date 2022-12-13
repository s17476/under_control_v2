import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../filter/presentation/blocs/filter/filter_bloc.dart';
import '../../tasks/presentation/blocs/reserved_spare_parts/reserved_spare_parts_bloc.dart';
import '../domain/entities/item.dart';

/// Calculates quantity of given item in selected locations.
///
/// Returns [double].
double getItemQuantityInLocations(
    BuildContext context, Item item, bool subtractReserved) {
  double result = 0;
  final state = context.read<FilterBloc>().state;
  if (state is FilterLoadedState) {
    for (var amountInLocation in item.amountInLocations) {
      double reservedQuantity = 0;
      if (subtractReserved) {
        final reservedState = context.read<ReservedSparePartsBloc>().state;
        if (reservedState is ReservedSparePartsActiveState) {
          reservedQuantity = reservedState.getReservedQuantity(
              item.id, amountInLocation.locationId);
        }
      }
      if (state.locations
          .map((loc) => loc.id)
          .contains(amountInLocation.locationId)) {
        result += amountInLocation.amount - reservedQuantity;
      }
    }
  }
  return result;
}
