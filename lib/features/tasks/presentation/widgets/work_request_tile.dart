import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

import '../../../assets/presentation/blocs/asset/asset_bloc.dart';
import '../../../company_profile/presentation/blocs/company_profile/company_profile_bloc.dart';
import '../../../core/presentation/widgets/cached_user_avatar.dart';
import '../../../notifications/domain/entities/uc_notification.dart';
import '../../../notifications/presentation/blocs/uc_notification_management/uc_notification_management_bloc.dart';
import '../../../user_profile/domain/entities/user_profile.dart';
import '../../domain/entities/work_request/work_request.dart';
import '../../utils/get_task_priority_icon.dart';
import '../pages/work_request_details_page.dart';

class WorkRequestTile extends StatelessWidget {
  const WorkRequestTile({
    Key? key,
    required this.workRequest,
    this.notification,
  }) : super(key: key);

  final WorkRequest workRequest;
  final UcNotification? notification;

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
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (notification != null)
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                    color: notification!.read
                        ? Colors.black
                        : const Color.fromARGB(255, 179, 0, 0),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.warning, size: 16),
                      const SizedBox(
                        width: 4,
                      ),
                      Text(
                        AppLocalizations.of(context)!
                            .notifications_work_requests_tile,
                        style: Theme.of(context)
                            .textTheme
                            .displaySmall!
                            .copyWith(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              Container(
                // margin: const EdgeInsets.only(left: 25),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: notification != null
                      ? const BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                          topRight: Radius.circular(10),
                        )
                      : BorderRadius.circular(10),
                ),
                child: Material(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                  child: InkWell(
                    onTap: () {
                      if (notification != null) {
                        context.read<UcNotificationManagementBloc>().add(
                              MarkAsReadEvent(
                                notificationId: notification!.id,
                              ),
                            );
                      }
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
                                Icon(
                                  Icons.add,
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .color,
                                  size: 12,
                                ),
                                Expanded(
                                  child: Text(
                                    dateFormat.format(workRequest.date),
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
                                  ),
                                ),
                                Text(
                                  '#${workRequest.count}',
                                  style: Theme.of(context).textTheme.bodySmall,
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
                                            color: Theme.of(context)
                                                .highlightColor,
                                          ),
                                          const SizedBox(
                                            width: 4,
                                          ),
                                          Expanded(
                                            child: Text(
                                              '${asset.producer} - ${asset.model}',
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: Theme.of(context)
                                                    .highlightColor,
                                              ),
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
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .color,
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
                                        .bodySmall!
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
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ),

                          const SizedBox(
                            height: 4,
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
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall,
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
                                              .bodySmall!
                                              .copyWith(fontSize: 14),
                                        ),
                                      FaIcon(
                                        FontAwesomeIcons.image,
                                        size: 18,
                                        color: Theme.of(context)
                                            .textTheme
                                            .bodySmall!
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
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .color,
                                  ),
                              ],
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
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
          ),
        if (!workRequest.cancelled && workRequest.taskId.isNotEmpty)
          Positioned(
            right: 0,
            child: Checkbox(
              value: true,
              onChanged: (_) {
                Navigator.pushNamed(
                  context,
                  WorkRequestDetailsPage.routeName,
                  arguments: workRequest.id,
                );
              },
              activeColor: Theme.of(context).primaryColor,
            ),
          )
      ],
    );
  }
}
