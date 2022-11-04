import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

import '../../../../assets/presentation/blocs/asset/asset_bloc.dart';
import '../../../../assets/presentation/widgets/asset_tile.dart';
import '../../../../company_profile/presentation/blocs/company_profile/company_profile_bloc.dart';
import '../../../../core/presentation/widgets/icon_title_row.dart';
import '../../../../core/presentation/widgets/user_info_card.dart';
import '../../../../core/presentation/widgets/user_list_tile.dart';
import '../../../../core/utils/location_selection_helpers.dart';
import '../../../../core/utils/size_config.dart';
import '../../../../inventory/presentation/widgets/shimmer_item_tile.dart';
import '../../../../locations/presentation/blocs/bloc/location_bloc.dart';
import '../../../../user_profile/domain/entities/user_profile.dart';
import '../../../domain/entities/work_order/work_order.dart';
import '../../../utils/get_localized_task_priority_name.dart';
import '../../../utils/get_task_priority_icon.dart';

class WorkOrderInfoTab extends StatefulWidget {
  const WorkOrderInfoTab({
    Key? key,
    required this.workOrder,
  }) : super(key: key);

  final WorkOrder workOrder;

  @override
  State<WorkOrderInfoTab> createState() => _WorkOrderInfoTabState();
}

class _WorkOrderInfoTabState extends State<WorkOrderInfoTab> {
  UserProfile? _userProfile;
  bool _isUserInfoCardVisible = false;

  void _showUserInfoCard() {
    setState(() {
      _isUserInfoCardVisible = true;
    });
  }

  void _hideUserInfoCard() {
    setState(() {
      _isUserInfoCardVisible = false;
    });
  }

  @override
  void didChangeDependencies() {
    if (_userProfile == null) {
      final companyState = context.read<CompanyProfileBloc>().state;
      if (companyState is CompanyProfileLoaded) {
        _userProfile = companyState.getUserById(widget.workOrder.userId);
      }
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final detailedDateFormat = DateFormat('dd-MM-yyyy HH:mm');
    SizeConfig.init(context);
    return WillPopScope(
      onWillPop: () async {
        if (_isUserInfoCardVisible) {
          _hideUserInfoCard();
          return false;
        }
        return true;
      },
      child: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    getTaskPriorityIcon(
                      context,
                      widget.workOrder.priority,
                      100,
                    ),
                    Expanded(
                      child: Text(
                        getLocalizedTaskPriorityName(
                          context,
                          widget.workOrder.priority,
                        ),
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(right: 16),
                      height: 100,
                      child: Text(
                        '#${widget.workOrder.count}',
                        style: Theme.of(context)
                            .textTheme
                            .caption!
                            .copyWith(fontSize: 14),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8.0,
                    horizontal: 16,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // title
                      Text(
                        widget.workOrder.title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                      ),

                      if (widget.workOrder.description.isNotEmpty)
                        const SizedBox(
                          height: 4,
                        ),
                      // description
                      if (widget.workOrder.description.isNotEmpty)
                        Text(
                          widget.workOrder.description,
                          style: const TextStyle(fontSize: 14),
                          maxLines: 6,
                          overflow: TextOverflow.ellipsis,
                        ),
                    ],
                  ),
                ),

                // work order data
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Divider(
                        thickness: 1.5,
                      ),

                      // type
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            IconTitleRow(
                              icon: Icons.security,
                              iconColor: Colors.white,
                              iconBackground: Colors.black,
                              title:
                                  AppLocalizations.of(context)!.work_order_data,
                              titleFontSize: 16,
                            ),
                            const SizedBox(
                              height: 16,
                            ),

                            // add date
                            Row(
                              children: [
                                Expanded(
                                  child: IconTitleRow(
                                    icon: Icons.calendar_month,
                                    iconColor: Colors.white,
                                    iconBackground:
                                        Theme.of(context).primaryColor,
                                    title: AppLocalizations.of(context)!
                                        .asset_add_date,
                                    titleFontSize: 16,
                                  ),
                                ),
                                Text(
                                  detailedDateFormat
                                      .format(widget.workOrder.date),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 16,
                            ),

                            // location
                            Row(
                              children: [
                                Expanded(
                                  child: IconTitleRow(
                                    icon: Icons.location_on,
                                    iconColor: Colors.white,
                                    iconBackground:
                                        Theme.of(context).primaryColor,
                                    title:
                                        AppLocalizations.of(context)!.location,
                                    titleFontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            BlocBuilder<LocationBloc, LocationState>(
                              builder: (context, state) {
                                if (state is LocationLoadedState) {
                                  return Text(
                                    getBreadcrumbsForLocation(
                                      widget.workOrder.locationId,
                                      state.allLocations.allLocations,
                                    ),
                                    maxLines: 4,
                                    overflow: TextOverflow.ellipsis,
                                  );
                                }
                                return const SizedBox();
                              },
                            ),
                            const SizedBox(
                              height: 16,
                            ),

                            // connected asset
                            IconTitleRow(
                              icon: widget.workOrder.assetId.isNotEmpty
                                  ? Icons.precision_manufacturing
                                  : Icons.handyman,
                              iconColor: Colors.white,
                              iconBackground:
                                  widget.workOrder.assetId.isNotEmpty
                                      ? Colors.blue
                                      : Theme.of(context).primaryColor,
                              title: widget.workOrder.assetId.isNotEmpty
                                  ? AppLocalizations.of(context)!
                                      .task_connected_asset_yes
                                  : AppLocalizations.of(context)!
                                      .task_connected_asset_no,
                              titleFontSize: 16,
                            ),
                            if (widget.workOrder.assetId.isNotEmpty)
                              const SizedBox(
                                height: 8,
                              ),

                            // asset tile
                            if (widget.workOrder.assetId.isNotEmpty)
                              BlocBuilder<AssetBloc, AssetState>(
                                builder: (context, state) {
                                  if (state is AssetLoadedState) {
                                    final asset = state
                                        .getAssetById(widget.workOrder.assetId);
                                    if (asset != null) {
                                      return AssetTile(
                                        asset: asset,
                                        searchQuery: '',
                                        margin: const EdgeInsets.only(top: 4),
                                      );
                                    }
                                  }
                                  return const ShimmerItemTile();
                                },
                              ),
                            const SizedBox(
                              height: 8,
                            ),

                            const Divider(
                              thickness: 1.5,
                            ),

                            // user
                            if (_userProfile != null)
                              UserListTile(
                                user: _userProfile!,
                                onTap: (_) => _showUserInfoCard(),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            // user info card
            if (_isUserInfoCardVisible)
              UserInfoCard(
                onDismiss: _hideUserInfoCard,
                user: _userProfile!,
              ),
          ],
        ),
      ),
    );
  }
}
