import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

import '../../../../company_profile/presentation/blocs/company_profile/company_profile_bloc.dart';
import '../../../../core/presentation/widgets/cached_user_avatar.dart';
import '../../../../core/utils/double_apis.dart';
import '../../../../locations/presentation/blocs/bloc/location_bloc.dart';
import '../../../../user_profile/domain/entities/user_profile.dart';
import '../../../domain/entities/item.dart';
import '../../../domain/entities/item_action/item_action.dart';
import '../../../utils/get_action_gradient.dart';
import '../../../utils/get_action_icon.dart';
import '../../blocs/items/items_bloc.dart';
import '../../pages/item_details_page.dart';

class ItemActionListTile extends StatelessWidget {
  const ItemActionListTile({
    Key? key,
    required this.action,
    this.isDashboardTile = false,
  }) : super(key: key);

  final ItemAction action;
  final bool isDashboardTile;

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('dd-MM-yyyy  HH:mm');
    String? location;
    Item? item;
    UserProfile? user;

    if (isDashboardTile) {
      final itemsState = context.read<ItemsBloc>().state;
      if (itemsState is ItemsLoadedState) {
        item = itemsState.getItemById(action.itemId);
      }
    }

    final locationsState = context.read<LocationBloc>().state;
    if (locationsState is LocationLoadedState) {
      location = locationsState.getLocationById(action.locationId)?.name;
    }

    final userState = context.read<CompanyProfileBloc>().state;
    if (userState is CompanyProfileLoaded) {
      user = userState.getUserById(action.userId);
    }

    return InkWell(
      child: Container(
          margin: const EdgeInsets.symmetric(vertical: 4),
          child: Stack(
            alignment: Alignment.centerLeft,
            children: [
              // content box
              GestureDetector(
                onTap: isDashboardTile && item != null
                    ? () => Navigator.pushNamed(
                          context,
                          ItemDetailsPage.routeName,
                          arguments: item,
                        )
                    : () {},
                child: Container(
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
                            // item
                            if (item != null)
                              Text(
                                item.name,
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Theme.of(context).highlightColor,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            // location
                            Text(
                              location ??
                                  AppLocalizations.of(context)!
                                      .location_unknown,
                              style: TextStyle(
                                  fontSize: isDashboardTile ? 14 : 18),
                              overflow: TextOverflow.ellipsis,
                            ),
                            // description
                            Text(
                              action.description,
                              style: Theme.of(context).textTheme.caption,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 6,
                            ),
                            if (user != null)
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      top: 4,
                                      right: 4,
                                    ),
                                    child: CachedUserAvatar(
                                      size: 20,
                                      imageUrl: user.avatarUrl,
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
                child: getActionIcon(context, action.type),
              ),
            ],
          )),
    );
  }
}
