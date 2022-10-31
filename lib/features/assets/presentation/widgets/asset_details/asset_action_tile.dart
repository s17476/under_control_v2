import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../company_profile/presentation/blocs/company_profile/company_profile_bloc.dart';
import '../../../../core/presentation/widgets/cached_user_avatar.dart';
import '../../../../user_profile/domain/entities/user_profile.dart';
import '../../../domain/entities/asset_action/asset_action.dart';
import '../../../utils/get_asset_status_icon.dart';
import '../../blocs/asset/asset_bloc.dart';
import '../../pages/asset_detail_page.dart';

class AssetActionTile extends StatelessWidget {
  const AssetActionTile({
    Key? key,
    required this.action,
    this.isDashboardTile = false,
  }) : super(key: key);

  final AssetAction action;
  final bool isDashboardTile;

  @override
  Widget build(BuildContext context) {
    UserProfile? user;

    final userState = context.read<CompanyProfileBloc>().state;
    if (userState is CompanyProfileLoaded) {
      user = userState.getUserById(action.userId);
    }

    final dateFormat = DateFormat('dd-MM-yyyy HH:mm');
    return Stack(
      alignment: Alignment.centerLeft,
      children: [
        Container(
          margin: const EdgeInsets.only(left: 20),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Material(
            borderRadius: BorderRadius.circular(10),
            child: InkWell(
              onTap: isDashboardTile
                  ? () {
                      Navigator.pushNamed(
                        context,
                        AssetDetailsPage.routeName,
                        arguments: action.assetId,
                      );
                    }
                  : () {},
              borderRadius: BorderRadius.circular(10),
              child: Container(
                padding: const EdgeInsets.only(
                  left: 18,
                  right: 8,
                  top: 8,
                  bottom: 8,
                ),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // date
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        dateFormat.format(action.dateTime),
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ),
                    if (isDashboardTile)
                      BlocBuilder<AssetBloc, AssetState>(
                        builder: (context, state) {
                          if (state is AssetLoadedState) {
                            final asset = state.getAssetById(action.assetId);
                            if (asset != null) {
                              return Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text(
                                  '${asset.internalCode} - ${asset.producer} - ${asset.model}',
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Theme.of(context).highlightColor,
                                  ),
                                ),
                              );
                            }
                          }
                          return Text(action.assetId);
                        },
                      ),
                    // connected task
                    if (action.connectedTask.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(action.connectedTask),
                      ),
                    // add/edit action
                    if (action.connectedTask.isEmpty)
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          action.isCreate
                              ? AppLocalizations.of(context)!.created
                              : AppLocalizations.of(context)!.edited,
                        ),
                      ),
                    // is asset in use
                    Row(
                      children: [
                        Padding(
                          padding: action.isAssetInUse
                              ? const EdgeInsets.all(0)
                              : const EdgeInsets.only(left: 4.0),
                          child: Icon(
                            action.isAssetInUse
                                ? Icons.play_arrow
                                : Icons.pause,
                            color: Theme.of(context).textTheme.caption!.color,
                          ),
                        ),
                        Text(
                          action.isAssetInUse
                              ? AppLocalizations.of(context)!.asset_in_use
                              : AppLocalizations.of(context)!.asset_not_in_use,
                          style: Theme.of(context).textTheme.caption!.copyWith(
                                fontSize: 14,
                              ),
                        ),
                      ],
                    ),
                    // user
                    if (user != null)
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 4,
                              right: 4,
                              left: 8,
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
            ),
          ),
        ),
        SizedBox(
          height: 40,
          width: 40,
          child: getAssetStatusIcon(
            context,
            action.assetStatus,
            18,
          ),
        ),
      ],
    );
  }
}
