import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:under_control_v2/features/assets/presentation/widgets/asset_details/shimmer_asset_action_list_tile.dart';
import 'package:under_control_v2/features/tasks/presentation/blocs/work_order/work_order_bloc.dart';
import 'package:under_control_v2/features/tasks/presentation/widgets/work_order_tile.dart';

import '../../../core/presentation/widgets/icon_title_row.dart';
import '../../../core/utils/get_user_premission.dart';
import '../../../core/utils/premission.dart';
import '../../../groups/domain/entities/feature.dart';
import '../../../tasks/domain/entities/work_order/work_order.dart';

class WorkOrdersLatest extends StatefulWidget {
  const WorkOrdersLatest({
    Key? key,
  }) : super(key: key);

  @override
  State<WorkOrdersLatest> createState() => _WorkOrdersLatestState();
}

class _WorkOrdersLatestState extends State<WorkOrdersLatest> {
  List<WorkOrder>? _workOrders;

  @override
  void didChangeDependencies() {
    final workOrdersState = context.watch<WorkOrderBloc>().state;
    if (workOrdersState is WorkOrderLoadedState) {
      _workOrders =
          workOrdersState.allWorkOrders.allWorkOrders.reversed.toList();
      if (_workOrders != null && _workOrders!.length > 5) {
        _workOrders = _workOrders!.sublist(0, 5);
      }
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final premission = getUserPremission(
      context: context,
      featureType: FeatureType.tasks,
      premissionType: PremissionType.read,
    );
    return !premission
        ? const SizedBox()
        : Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 16,
                ),
                decoration: BoxDecoration(
                    color: Theme.of(context).appBarTheme.backgroundColor,
                    boxShadow: const [
                      BoxShadow(
                        offset: Offset(0, 0),
                        blurRadius: 4,
                      )
                    ]),
                child: Row(
                  children: [
                    Expanded(
                      child: IconTitleRow(
                        icon: Icons.add_task,
                        iconColor: Colors.white,
                        iconBackground: Colors.red,
                        title:
                            '${AppLocalizations.of(context)!.work_orders} - ${AppLocalizations.of(context)!.item_details_latest_actions}',
                      ),
                    ),
                    if (_workOrders == null)
                      const SizedBox(
                        width: 25,
                        height: 25,
                        child: CircularProgressIndicator(),
                      ),
                  ],
                ),
              ),
              Column(
                children: [
                  if (_workOrders == null)
                    ListView.builder(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 5,
                      itemBuilder: (context, index) =>
                          const ShimmerAssetActionListTile(
                        isDashboardTile: true,
                      ),
                    ),
                  if (_workOrders != null && _workOrders!.isNotEmpty)
                    ListView.builder(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _workOrders!.length,
                      itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: WorkOrderTile(
                          workOrder: _workOrders![index],
                        ),
                      ),
                    ),
                  if (_workOrders != null && _workOrders!.isEmpty)
                    Container(
                      alignment: Alignment.center,
                      height: 50,
                      child: Text(
                        AppLocalizations.of(context)!
                            .no_actions_in_selected_locations,
                      ),
                    ),
                ],
              ),
            ],
          );
  }
}
