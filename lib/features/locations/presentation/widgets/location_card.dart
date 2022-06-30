import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:under_control_v2/features/locations/presentation/blocs/bloc/location_bloc.dart';
import 'package:under_control_v2/features/locations/presentation/widgets/add_location_card.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../domain/entities/location.dart';
import 'bottom_modal_sheet.dart';

class LocationCard extends StatefulWidget {
  final List<Location> allLocations;
  final Location location;
  final Color color;
  const LocationCard({
    Key? key,
    required this.allLocations,
    required this.location,
    required this.color,
  }) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  State<LocationCard> createState() => _LocationCardState();
}

class _LocationCardState extends State<LocationCard> {
  _LocationCardState();
  bool expanded = false;

  @override
  Widget build(BuildContext context) {
    final children = widget.allLocations
        .where((location) => location.parentId == widget.location.id);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: InkWell(
            onTap: () {
              setState(() {
                expanded = !expanded;
              });
            },
            customBorder: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Container(
              height: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Theme.of(context).cardColor,
              ),
              child: Row(
                children: [
                  Container(
                    width: 16,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                      ),
                      color: widget.color,
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: Text(
                      widget.location.name,
                      style: Theme.of(context).textTheme.headline6,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          showAddLocationModalBottomSheet(
                            context: context,
                            currentLocation: widget.location,
                          );
                        },
                        icon: const Icon(
                          Icons.edit,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              actionsAlignment: MainAxisAlignment.spaceEvenly,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              title: Text(
                                AppLocalizations.of(context)!
                                    .location_management_add_location_message_delete_confirm,
                              ),
                              content: Text(
                                AppLocalizations.of(context)!
                                    .location_management_add_location_message_delete_question(
                                  widget.location.name,
                                ),
                              ),
                              actions: [
                                TextButton(
                                  child: Text(
                                    AppLocalizations.of(context)!.cancel,
                                    style: TextStyle(
                                      color: Theme.of(context)
                                          .textTheme
                                          .headline1!
                                          .color,
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                                TextButton(
                                  child: Text(
                                    AppLocalizations.of(context)!.delete,
                                    style: const TextStyle(
                                      color: Colors.amber,
                                    ),
                                  ),
                                  onPressed: () {
                                    context.read<LocationBloc>().add(
                                          DeleteLocationEvent(
                                            location: widget.location,
                                          ),
                                        );
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                        icon: const Icon(
                          Icons.delete,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        AnimatedSize(
          curve: Curves.fastOutSlowIn,
          duration: const Duration(milliseconds: 300),
          child: Container(
            width: double.infinity,
            height: expanded ? null : 0,
            padding: const EdgeInsets.only(left: 16),
            child: Column(
              children: [
                for (var location in children)
                  LocationCard(
                    allLocations: widget.allLocations,
                    location: location,
                    color: widget.color,
                    key: Key(location.id),
                  ),
                AddLocationCard(
                  color: widget.color,
                  parentLocation: widget.location,
                  key: Key(
                    '${widget.location.id}add',
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
