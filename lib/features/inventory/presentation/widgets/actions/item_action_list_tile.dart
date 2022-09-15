import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

import '../../../../locations/presentation/blocs/bloc/location_bloc.dart';
import '../../../domain/entities/item_action/item_action.dart';
import '../../../../core/utils/double_apis.dart';

class ItemActionListTile extends StatelessWidget {
  const ItemActionListTile({
    Key? key,
    required this.action,
  }) : super(key: key);

  final ItemAction action;

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('dd-MM-yyyy  HH:mm');
    String? location;

    final locationsState = context.read<LocationBloc>().state;
    if (locationsState is LocationLoadedState) {
      location = locationsState.getLocationById(action.locationId)?.name;
    }

    return Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        child: Stack(
          alignment: Alignment.centerLeft,
          children: [
            // content box
            Container(
              margin: const EdgeInsets.only(left: 15),
              padding: const EdgeInsets.only(
                top: 4,
                bottom: 4,
                left: 24,
                right: 8,
              ),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // date time
                      Text(
                        dateFormat.format(action.date),
                        style: Theme.of(context).textTheme.caption,
                      ),
                      // location
                      Text(
                        location ??
                            AppLocalizations.of(context)!.location_unknown,
                        style: const TextStyle(fontSize: 18),
                        overflow: TextOverflow.ellipsis,
                      ),
                      // description
                      Text(
                        action.description,
                        style: Theme.of(context).textTheme.caption,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 6,
                      ),
                    ],
                  ),
                  Text(
                    action.ammount.toStringWithFixedDecimal(),
                    style: const TextStyle(fontSize: 24),
                  ),
                ],
              ),
            ),
            // icon box
            Container(
              decoration: BoxDecoration(
                gradient: action.type == ItemActionType.add
                    ? LinearGradient(
                        colors: [
                          Theme.of(context).primaryColor,
                          Theme.of(context).primaryColor.withAlpha(60),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      )
                    : LinearGradient(
                        colors: [
                          Colors.red,
                          Colors.red.withAlpha(60),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                // color: Theme.of(context).primaryColor.withAlpha(80),
                borderRadius: BorderRadius.circular(5),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black,
                    offset: Offset(2, 2),
                    blurRadius: 5,
                  )
                ],
              ),
              child: Icon(
                action.type == ItemActionType.add ? Icons.add : Icons.remove,
                size: 30,
              ),
            ),
          ],
        )
        // Row(
        //   children: [
        //     // action list tile
        //     Expanded(
        //       child: IconTitleRow(
        //         icon:
        //             action.type == ItemActionType.add ? Icons.add : Icons.remove,
        //         iconColor: Colors.white,
        //         iconBackground: action.type == ItemActionType.add
        //             ? Theme.of(context).primaryColor
        //             : Colors.red,
        //         title: action.description,
        //       ),
        //     ),
        //     Text(action.ammount.toString()),
        //   ],
        // ),
        );
  }
}
