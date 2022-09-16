import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

import '../../../../company_profile/presentation/blocs/company_profile/company_profile_bloc.dart';
import '../../../../core/presentation/widgets/cached_user_avatar.dart';
import '../../../../locations/presentation/blocs/bloc/location_bloc.dart';
import '../../../../user_profile/domain/entities/user_profile.dart';
import '../../../domain/entities/item_action/item_action.dart';
import '../../../../core/utils/double_apis.dart';

class ItemActionListTile extends StatelessWidget {
  const ItemActionListTile({
    Key? key,
    required this.action,
  }) : super(key: key);

  final ItemAction action;

  List<Color> getGradient(BuildContext context, ItemActionType itemActionType) {
    print(itemActionType);
    if (itemActionType == ItemActionType.add) {
      return [
        Theme.of(context).primaryColor,
        Theme.of(context).primaryColor.withAlpha(60),
      ];
    } else if (itemActionType == ItemActionType.remove) {
      return [
        Colors.red,
        Colors.red.withAlpha(60),
      ];
    }
    return [
      Colors.blue.shade700,
      Colors.blue.shade700.withAlpha(60),
    ];
  }

  Widget getIcon(BuildContext context, ItemActionType itemActionType) {
    const iconSize = 30.0;
    switch (itemActionType) {
      case ItemActionType.add:
        return const Icon(
          Icons.add,
          size: iconSize,
        );
      case ItemActionType.remove:
        return const Icon(
          Icons.remove,
          size: iconSize,
        );
      case ItemActionType.moveAdd:
        return SizedBox(
          width: iconSize,
          height: iconSize,
          child: Stack(
            children: const [
              Positioned(
                right: 0,
                bottom: 0,
                child: Icon(
                  Icons.compare_arrows,
                  size: 22,
                ),
              ),
              Positioned(
                left: 0,
                top: 0,
                child: Icon(
                  Icons.add,
                  size: 22,
                ),
              ),
            ],
          ),
        );
      case ItemActionType.moveRemove:
        return SizedBox(
          width: iconSize,
          height: iconSize,
          child: Stack(
            children: const [
              Positioned(
                right: 0,
                bottom: 0,
                child: Icon(
                  Icons.compare_arrows,
                  size: 22,
                ),
              ),
              Positioned(
                left: 0,
                top: 0,
                child: Icon(
                  Icons.remove,
                  size: 22,
                ),
              ),
            ],
          ),
        );
      default:
        return const SizedBox();
    }
  }

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('dd-MM-yyyy  HH:mm');
    String? location;

    UserProfile? user;

    final locationsState = context.read<LocationBloc>().state;
    if (locationsState is LocationLoadedState) {
      location = locationsState.getLocationById(action.locationId)?.name;
    }

    final userState = context.read<CompanyProfileBloc>().state;
    if (userState is CompanyProfileLoaded) {
      user = userState.getUserById(action.userId);
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
                  Expanded(
                    child: Column(
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
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 4,
                                right: 4,
                              ),
                              child: CachedUserAvatar(
                                size: 20,
                                imageUrl: user!.avatarUrl,
                              ),
                            ),
                            Text(
                              '${user.firstName} ${user.lastName}',
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ],
                        ),
                      ],
                    ),
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
                gradient: LinearGradient(
                  colors: getGradient(context, action.type),
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
              child: getIcon(context, action.type),
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
