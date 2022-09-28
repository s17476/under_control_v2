import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../domain/entities/location.dart';
import '../../../utils/bottom_modal_sheet.dart';

class AddLocationCard extends StatelessWidget {
  final Color color;
  final Location? parentLocation;
  const AddLocationCard({
    Key? key,
    this.color = const Color.fromRGBO(0, 240, 130, 100),
    this.parentLocation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: InkWell(
        onTap: () {
          showAddLocationModalBottomSheet(
            context: context,
            parentLocation: parentLocation,
          );
        },
        customBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Theme.of(context).cardColor,
          ),
          child: Row(
            children: [
              Container(
                width: 32,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                  ),
                  color: color,
                ),
                child: const Icon(
                  Icons.add,
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    const SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: Text(
                        parentLocation == null
                            ? AppLocalizations.of(context)!
                                .location_management_add_card
                            : AppLocalizations.of(context)!
                                    .location_management_add_sub_card +
                                parentLocation!.name,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: TextStyle(color: Colors.grey.shade100),
                      ),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
