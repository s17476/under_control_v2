import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:under_control_v2/features/assets/presentation/widgets/asset_tile.dart';
import 'package:under_control_v2/features/tasks/utils/get_localized_task_priority_name.dart';
import 'package:under_control_v2/features/tasks/utils/get_task_priority_icon.dart';

import '../../../../assets/presentation/blocs/asset/asset_bloc.dart';
import '../../../../core/presentation/widgets/icon_title_row.dart';
import '../../../../core/utils/location_selection_helpers.dart';
import '../../../../core/utils/responsive_size.dart';
import '../../../../core/utils/size_config.dart';
import '../../../../inventory/presentation/widgets/internal_code_row.dart';
import '../../../../inventory/presentation/widgets/price_row.dart';
import '../../../../inventory/presentation/widgets/qr_code_row.dart';
import '../../../../inventory/presentation/widgets/shimmer_item_tile.dart';
import '../../../../locations/presentation/blocs/bloc/location_bloc.dart';
import '../../../domain/entities/work_order/work_order.dart';

class WorkOrderInfoTab extends StatelessWidget with ResponsiveSize {
  const WorkOrderInfoTab({
    Key? key,
    required this.workOrder,
  }) : super(key: key);

  final WorkOrder workOrder;

  @override
  Widget build(BuildContext context) {
    final detailedDateFormat = DateFormat('dd-MM-yyyy HH:mm');
    SizeConfig.init(context);
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              getTaskPriorityIcon(
                context,
                workOrder.priority,
                100,
              ),
              Expanded(
                child: Text(
                  getLocalizedTaskPriorityName(
                    context,
                    workOrder.priority,
                  ),
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Text('#${workOrder.count}'),
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
                  workOrder.title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                ),

                if (workOrder.description.isNotEmpty)
                  const SizedBox(
                    height: 4,
                  ),
                // description
                if (workOrder.description.isNotEmpty)
                  Text(
                    workOrder.description,
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
              children: [
                const Divider(
                  thickness: 1.5,
                ),
                // type
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      IconTitleRow(
                        icon: Icons.security,
                        iconColor: Colors.white,
                        iconBackground: Colors.black,
                        title: AppLocalizations.of(context)!.work_order_data,
                        titleFontSize: 16,
                      ),
                      const SizedBox(
                        height: 16,
                      ),

                      // connected asset
                      IconTitleRow(
                        icon: workOrder.assetId.isNotEmpty
                            ? Icons.precision_manufacturing
                            : Icons.handyman,
                        iconColor: Colors.white,
                        iconBackground: workOrder.assetId.isNotEmpty
                            ? Colors.blue
                            : Theme.of(context).primaryColor,
                        title: workOrder.assetId.isNotEmpty
                            ? AppLocalizations.of(context)!
                                .task_connected_asset_yes
                            : AppLocalizations.of(context)!
                                .task_connected_asset_no,
                        titleFontSize: 16,
                      ),
                      if (workOrder.assetId.isNotEmpty)
                        const SizedBox(
                          height: 8,
                        ),
                      if (workOrder.assetId.isNotEmpty)
                        BlocBuilder<AssetBloc, AssetState>(
                          builder: (context, state) {
                            if (state is AssetLoadedState) {
                              final asset =
                                  state.getAssetById(workOrder.assetId);
                              if (asset != null) {
                                return AssetTile(asset: asset, searchQuery: '');
                              }
                            }
                            return const ShimmerItemTile();
                          },
                        ),
                      // const SizedBox(
                      //   height: 16,
                      // ),
                      // is in use
                      // Row(
                      //   children: [
                      //     Expanded(
                      //       child: IconTitleRow(
                      //         icon: workOrder.isInUse
                      //             ? Icons.play_arrow
                      //             : Icons.pause,
                      //         iconColor: Colors.white,
                      //         iconBackground: workOrder.isInUse
                      //             ? Theme.of(context).primaryColor
                      //             : Colors.orange,
                      //         title:
                      //             AppLocalizations.of(context)!.asset_is_in_use,
                      //         titleFontSize: 16,
                      //       ),
                      //     ),
                      //     Text(
                      //       workOrder.isInUse
                      //           ? AppLocalizations.of(context)!.yes
                      //           : AppLocalizations.of(context)!.no,
                      //     ),
                      //   ],
                      // ),
                      // const SizedBox(
                      //   height: 16,
                      // ),
                      // is spare part
                      // Row(
                      //   children: [
                      //     Expanded(
                      //       child: IconTitleRow(
                      //         icon: workOrder.isSparePart
                      //             ? Icons.build
                      //             : Icons.done,
                      //         iconColor: Colors.white,
                      //         iconBackground: !workOrder.isSparePart
                      //             ? Theme.of(context).primaryColor
                      //             : Colors.orange,
                      //         title:
                      //             AppLocalizations.of(context)!.item_spare_part,
                      //         titleFontSize: 16,
                      //       ),
                      //     ),
                      //     Text(
                      //       workOrder.isSparePart
                      //           ? AppLocalizations.of(context)!
                      //               .item_spare_part_yes
                      //           : AppLocalizations.of(context)!
                      //               .item_spare_part_not,
                      //     ),
                      //   ],
                      // ),
                    ],
                  ),
                ),
                const Divider(
                  thickness: 1.5,
                ),
                // next inspection
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      IconTitleRow(
                        icon: Icons.search,
                        iconColor: Colors.white,
                        iconBackground: Colors.black,
                        title:
                            AppLocalizations.of(context)!.asset_next_inspection,
                        titleFontSize: 16,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                    ],
                  ),
                ),
                const Divider(
                  thickness: 1.5,
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      IconTitleRow(
                        icon: Icons.precision_manufacturing,
                        iconColor: Colors.grey.shade300,
                        iconBackground: Colors.black,
                        title: AppLocalizations.of(context)!.asset_data,
                        titleFontSize: 16,
                      ),

                      // add date
                      const SizedBox(
                        height: 16,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: IconTitleRow(
                              icon: Icons.location_on,
                              iconColor: Colors.white,
                              iconBackground: Theme.of(context).primaryColor,
                              title: AppLocalizations.of(context)!.location,
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
                                workOrder.locationId,
                                state.allLocations.allLocations,
                              ),
                              maxLines: 4,
                              overflow: TextOverflow.ellipsis,
                            );
                          }
                          return const SizedBox();
                        },
                      ),

                      // qr code
                      // if (workOrder.barCode.isNotEmpty)
                      //   const SizedBox(height: 16),
                      // if (workOrder.barCode.isNotEmpty)
                      //   QrCodeRow(code: workOrder.barCode),

                      // // internal code
                      // if (workOrder.internalCode.isNotEmpty)
                      //   const SizedBox(height: 16),
                      // if (workOrder.internalCode.isNotEmpty)
                      //   InternalCodeRow(code: workOrder.internalCode),

                      // // price
                      // if (workOrder.price > 0) const SizedBox(height: 16),
                      // if (workOrder.price > 0) PriceRow(price: workOrder.price),

                      // add date
                      const SizedBox(
                        height: 16,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: IconTitleRow(
                              icon: Icons.calendar_month,
                              iconColor: Colors.white,
                              iconBackground: Theme.of(context).primaryColor,
                              title:
                                  AppLocalizations.of(context)!.asset_add_date,
                              titleFontSize: 16,
                            ),
                          ),
                          Text(
                            detailedDateFormat.format(workOrder.date),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 36,
          ),
        ],
      ),
    );
  }
}
