import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../core/presentation/widgets/icon_title_row.dart';
import '../../../../locations/presentation/blocs/bloc/location_bloc.dart';
import '../../../domain/entities/item.dart';
import 'quantity_location_list_tile.dart';

class ItemsInLocations extends StatefulWidget {
  const ItemsInLocations({
    Key? key,
    required this.item,
  }) : super(key: key);

  final Item item;

  @override
  State<ItemsInLocations> createState() => _ItemsInLocationsState();
}

class _ItemsInLocationsState extends State<ItemsInLocations> {
  bool isExpanded = false;

  void toggleIsExpanded() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // title
        InkWell(
          onTap: toggleIsExpanded,
          child: Padding(
            padding: const EdgeInsets.all(
              8,
            ),
            child: Row(
              children: [
                Expanded(
                  child: IconTitleRow(
                    icon: Icons.location_on,
                    iconColor: Colors.white,
                    iconBackground: Colors.black,
                    title: AppLocalizations.of(context)!
                        .item_details_quantities_in_locations,
                    titleFontSize: 16,
                  ),
                ),
                Icon(
                  isExpanded
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                ),
              ],
            ),
          ),
        ),
        // members list
        AnimatedSize(
          duration: const Duration(milliseconds: 300),
          child: SizedBox(
            height: isExpanded ? null : 0,
            child: BlocBuilder<LocationBloc, LocationState>(
              builder: (context, state) {
                if (state is LocationLoadedState) {
                  final topLevelItems = state.allLocations.allLocations
                      .where((location) => location.parentId.isEmpty)
                      .toList();
                  return ListView.builder(
                    shrinkWrap: true,
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: topLevelItems.length,
                    itemBuilder: (context, index) {
                      return QuantityLocationslistTile(
                        location: topLevelItems[index],
                        allLocations: state.allLocations.allLocations,
                        item: widget.item,
                      );
                    },
                  );
                } else {
                  return const SizedBox();
                }
              },
            ),
          ),
        ),
      ],
    );
  }
}
