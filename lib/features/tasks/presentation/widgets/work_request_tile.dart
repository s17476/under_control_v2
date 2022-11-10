import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

import '../../../assets/presentation/blocs/asset/asset_bloc.dart';
import '../../../company_profile/presentation/blocs/company_profile/company_profile_bloc.dart';
import '../../../core/presentation/widgets/cached_user_avatar.dart';
import '../../../user_profile/domain/entities/user_profile.dart';
import '../../domain/entities/work_request/work_request.dart';
import '../../utils/get_task_priority_icon.dart';
import '../pages/work_request_details_page.dart';

class WorkRequestTile extends StatelessWidget {
  const WorkRequestTile({
    Key? key,
    required this.workRequest,
  }) : super(key: key);

  final WorkRequest workRequest;

  @override
  Widget build(BuildContext context) {
    UserProfile? user;

    final userState = context.read<CompanyProfileBloc>().state;
    if (userState is CompanyProfileLoaded) {
      user = userState.getUserById(workRequest.userId);
    }

    final dateFormat = DateFormat('dd-MM-yyyy HH:mm');
    return Stack(
      alignment: Alignment.centerLeft,
      children: [
        Container(
          margin: const EdgeInsets.only(left: 25),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Material(
            borderRadius: BorderRadius.circular(10),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  WorkRequestDetailsPage.routeName,
                  arguments: workRequest.id,
                );
              },
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
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              dateFormat.format(workRequest.date),
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ),
                          Text(
                            '#${workRequest.count}',
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ],
                      ),
                    ),
                    // shows asset data if work order is connected to an asset
                    if (workRequest.assetId.isNotEmpty)
                      BlocBuilder<AssetBloc, AssetState>(
                        builder: (context, state) {
                          if (state is AssetLoadedState) {
                            final asset =
                                state.getAssetById(workRequest.assetId);
                            if (asset != null) {
                              return Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.precision_manufacturing,
                                      size: 16,
                                      color: Theme.of(context).highlightColor,
                                    ),
                                    const SizedBox(
                                      width: 4,
                                    ),
                                    Text(
                                      '${asset.internalCode} - ${asset.producer} - ${asset.model}',
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Theme.of(context).highlightColor,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }
                          }
                          return const Text('');
                        },
                      ),
                    // shows info if work order is not connected to an asset
                    if (workRequest.assetId.isEmpty)
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.handyman,
                              size: 16,
                              color: Theme.of(context).textTheme.caption!.color,
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            Text(
                              AppLocalizations.of(context)!
                                  .task_connected_asset_no,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context)
                                  .textTheme
                                  .caption!
                                  .copyWith(fontSize: 16),
                            ),
                          ],
                        ),
                      ),

                    // title
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        workRequest.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        // style: Theme.of(context)
                        //     .textTheme
                        //     .caption!
                        //     .copyWith(fontSize: 16),
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),

                    // description
                    if (workRequest.description.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          workRequest.description,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context)
                              .textTheme
                              .caption!
                              .copyWith(fontSize: 12),
                        ),
                      ),

                    // user
                    if (user != null)
                      Row(
                        children: [
                          Expanded(
                            child: Row(
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
                          ),
                          // image icon
                          if (workRequest.images.isNotEmpty)
                            Row(
                              children: [
                                if (workRequest.images.length > 1)
                                  Text(
                                    '${workRequest.images.length}x',
                                    style: Theme.of(context)
                                        .textTheme
                                        .caption!
                                        .copyWith(fontSize: 14),
                                  ),
                                FaIcon(
                                  FontAwesomeIcons.image,
                                  size: 18,
                                  color: Theme.of(context)
                                      .textTheme
                                      .caption!
                                      .color,
                                ),
                                const SizedBox(
                                  width: 4,
                                ),
                              ],
                            ),
                          // video icon
                          if (workRequest.video.isNotEmpty)
                            FaIcon(
                              FontAwesomeIcons.play,
                              size: 18,
                              color: Theme.of(context).textTheme.caption!.color,
                            ),
                        ],
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
        getTaskPriorityIcon(
            context, workRequest.priority, 50, const EdgeInsets.all(0)),
        if (workRequest.cancelled)
          Positioned(
            right: 16,
            child: Transform.rotate(
              angle: -math.pi / 8,
              child: Text(
                AppLocalizations.of(context)!.cancelled,
                style: TextStyle(
                  color: Theme.of(context).highlightColor,
                  backgroundColor: Colors.black,
                  fontSize: 20,
                ),
              ),
            ),
          )
      ],
    );
  }
}
