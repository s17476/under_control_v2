import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:under_control_v2/features/knowledge_base/domain/entities/instruction.dart';

import '../../../../core/presentation/widgets/icon_title_row.dart';
import '../../../../groups/presentation/widgets/group_details/group_details_location_tile.dart';
import '../../../../locations/presentation/blocs/bloc/location_bloc.dart';

class InstructionLocations extends StatefulWidget {
  const InstructionLocations({
    Key? key,
    required this.instruction,
  }) : super(key: key);

  final Instruction instruction;

  @override
  State<InstructionLocations> createState() => _InstructionLocationsState();
}

class _InstructionLocationsState extends State<InstructionLocations> {
  bool _isExpanded = false;

  void toggleExpanded() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // title
        InkWell(
          onTap: toggleExpanded,
          child: Padding(
            padding: const EdgeInsets.only(
              top: 8,
              bottom: 8,
              left: 4,
              right: 4,
            ),
            child: Row(
              children: [
                Expanded(
                  child: IconTitleRow(
                    icon: Icons.location_on,
                    iconColor: Colors.white,
                    iconBackground: Colors.black,
                    title:
                        '${AppLocalizations.of(context)!.group_management_add_card_selected_locations}: ${widget.instruction.locations.length}',
                  ),
                ),
                Icon(
                  _isExpanded
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                ),
              ],
            ),
          ),
        ),
        // locations list
        AnimatedSize(
          duration: const Duration(milliseconds: 300),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 8),
            height: _isExpanded ? null : 0,
            child: BlocBuilder<LocationBloc, LocationState>(
              builder: (context, state) {
                if (state is LocationLoadedState) {
                  final topLevelItems = state.allLocations.allLocations
                      .where((location) => location.parentId.isEmpty)
                      .toList();
                  return ListView.builder(
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(0),
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: topLevelItems.length,
                    itemBuilder: (context, index) {
                      return GroupDetailsLocationTile(
                        selectedLocations: widget.instruction.locations,
                        allLocations: state.allLocations.allLocations,
                        location: topLevelItems[index],
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
