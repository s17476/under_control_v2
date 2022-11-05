import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:under_control_v2/features/assets/presentation/widgets/asset_details/shimmer_asset_action_list_tile.dart';
import 'package:under_control_v2/features/tasks/domain/entities/task_priority.dart';
import 'package:under_control_v2/features/tasks/domain/entities/work_order/work_order.dart';
import 'package:under_control_v2/features/tasks/presentation/widgets/work_order_tile.dart';
import 'package:under_control_v2/features/tasks/utils/get_task_priority_icon.dart';

import '../../../core/utils/get_user_premission.dart';
import '../../../core/utils/premission.dart';
import '../../../core/utils/responsive_size.dart';
import '../../../groups/domain/entities/feature.dart';
import '../blocs/work_order/work_order_bloc.dart';

class TasksPage extends StatefulWidget {
  const TasksPage({
    Key? key,
  }) : super(key: key);

  @override
  State<TasksPage> createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> with ResponsiveSize {
  List<WorkOrder>? _workOrders;
  List<WorkOrder>? _filteredWorkOrders;
  int _index = 0;

  void _setIndex(int value) {
    setState(() {
      _index = value;
    });
  }

  void _filterWorkOrders() {
    switch (_index) {
      case 0:
        _filteredWorkOrders = _workOrders;
        break;
      case 1:
        _filteredWorkOrders = _workOrders
            ?.where((workOrder) => workOrder.priority == TaskPriority.low)
            .toList();
        break;
      case 2:
        _filteredWorkOrders = _workOrders
            ?.where((workOrder) => workOrder.priority == TaskPriority.medium)
            .toList();
        break;
      case 3:
        _filteredWorkOrders = _workOrders
            ?.where((workOrder) => workOrder.priority == TaskPriority.high)
            .toList();
        break;
      default:
        _filteredWorkOrders = _workOrders;
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final Color? tabBarIconColor = Theme.of(context).textTheme.bodyLarge!.color;
    const double tabBarIconSize = 32;
    final premission = getUserPremission(
      context: context,
      featureType: FeatureType.tasks,
      premissionType: PremissionType.read,
    );
    return DefaultTabController(
      length: 4,
      child: CustomScrollView(
        slivers: [
          SliverOverlapInjector(
            handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
          ),
          SliverToBoxAdapter(
            child: !premission
                ? Column(
                    children: [
                      SizedBox(
                        height: responsiveSizeVerticalPct(small: 40),
                      ),
                      SizedBox(
                        child: Text(
                          AppLocalizations.of(context)!
                              .premission_no_premission,
                        ),
                      ),
                    ],
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        color: Theme.of(context).appBarTheme.backgroundColor,
                        child: TabBar(
                          tabs: [
                            Tab(
                              icon: Icon(
                                Icons.all_inclusive,
                                size: tabBarIconSize,
                                color: tabBarIconColor,
                              ),
                            ),
                            Tab(
                              icon: getTaskPriorityIcon(
                                context,
                                TaskPriority.low,
                                30,
                                const EdgeInsets.all(0),
                                false,
                              ),
                            ),
                            Tab(
                              icon: getTaskPriorityIcon(
                                context,
                                TaskPriority.medium,
                                30,
                                const EdgeInsets.all(0),
                                false,
                              ),
                            ),
                            Tab(
                              icon: getTaskPriorityIcon(
                                context,
                                TaskPriority.high,
                                30,
                                const EdgeInsets.all(0),
                                false,
                              ),
                            ),
                          ],
                          onTap: _setIndex,
                          indicatorColor: tabBarIconColor,
                        ),
                      ),
                      // work orders list
                      BlocBuilder<WorkOrderBloc, WorkOrderState>(
                        builder: (context, state) {
                          if (state is WorkOrderLoadedState) {
                            if (state.allWorkOrders.allWorkOrders.isEmpty) {
                              return Column(
                                children: [
                                  SizedBox(
                                    height:
                                        responsiveSizeVerticalPct(small: 40),
                                  ),
                                  Text(
                                    AppLocalizations.of(context)!.item_no_items,
                                  ),
                                ],
                              );
                            }
                            _workOrders = state.allWorkOrders.allWorkOrders;
                            _filterWorkOrders();
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 4,
                                  ),
                                  child: Text(
                                    AppLocalizations.of(context)!.work_orders,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline4!
                                        .copyWith(fontSize: 20),
                                  ),
                                ),
                                ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: _filteredWorkOrders!.length,
                                  itemBuilder: (context, index) => Padding(
                                    padding: const EdgeInsets.only(
                                      top: 4,
                                      bottom: 4,
                                      right: 8,
                                      left: 2,
                                    ),
                                    child: WorkOrderTile(
                                      workOrder: _filteredWorkOrders![index],
                                    ),
                                  ),
                                ),
                              ],
                            );
                          } else {
                            // shows shimmer when loading
                            return ListView.separated(
                              padding: const EdgeInsets.only(top: 4),
                              separatorBuilder: (context, index) =>
                                  const SizedBox(
                                height: 4,
                              ),
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: 8,
                              itemBuilder: (context, index) =>
                                  // shimmer work order
                                  const ShimmerAssetActionListTile(),
                            );
                          }
                        },
                      ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}
