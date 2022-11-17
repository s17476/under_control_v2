import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../assets/presentation/widgets/asset_details/shimmer_asset_action_list_tile.dart';
import '../../../core/utils/responsive_size.dart';
import '../../domain/entities/task_priority.dart';
import '../../domain/entities/work_request/work_request.dart';
import '../../utils/get_task_priority_icon.dart';
import '../blocs/work_request/work_request_bloc.dart';
import 'work_request_tile.dart';

class WorkRequestsTabView extends StatefulWidget {
  const WorkRequestsTabView({Key? key}) : super(key: key);

  @override
  State<WorkRequestsTabView> createState() => _WorkRequestsTabViewState();
}

class _WorkRequestsTabViewState extends State<WorkRequestsTabView>
    with SingleTickerProviderStateMixin, ResponsiveSize {
  late TabController _tabController;
  List<WorkRequest>? _workRequests;
  List<WorkRequest>? _filteredWorkRequests;
  int _index = 0;

  void _setIndex(int value) {
    setState(() {
      _index = value;
    });
  }

  void _filterWorkRequests() {
    switch (_index) {
      case 0:
        _filteredWorkRequests = _workRequests;
        break;
      case 1:
        _filteredWorkRequests = _workRequests
            ?.where((workRequest) => workRequest.priority == TaskPriority.low)
            .toList();
        break;
      case 2:
        _filteredWorkRequests = _workRequests
            ?.where(
                (workRequest) => workRequest.priority == TaskPriority.medium)
            .toList();
        break;
      case 3:
        _filteredWorkRequests = _workRequests
            ?.where((workRequest) => workRequest.priority == TaskPriority.high)
            .toList();
        break;
      default:
        _filteredWorkRequests = _workRequests;
        break;
    }
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Color? tabBarIconColor = Theme.of(context).textTheme.bodyLarge!.color;
    const double tabBarIconSize = 32;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          color: Theme.of(context).appBarTheme.backgroundColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TabBar(
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
                controller: _tabController,
                onTap: _setIndex,
                indicatorColor: tabBarIconColor,
              ),
            ],
          ),
        ),
        // work orders list
        BlocBuilder<WorkRequestBloc, WorkRequestState>(
          builder: (context, state) {
            if (state is WorkRequestLoadedState) {
              if (state.allWorkRequests.allWorkRequests.isEmpty) {
                return Column(
                  children: [
                    SizedBox(
                      height: responsiveSizeVerticalPct(small: 40),
                    ),
                    Text(
                      AppLocalizations.of(context)!.item_no_items,
                    ),
                  ],
                );
              }
              _workRequests = state.allWorkRequests.allWorkRequests;
              _filterWorkRequests();
              return AnimatedSize(
                duration: const Duration(milliseconds: 300),
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: _filteredWorkRequests!.length,
                  itemBuilder: (context, index) => Padding(
                    key: ValueKey(_filteredWorkRequests![index].id),
                    padding: const EdgeInsets.only(
                      top: 8,
                      bottom: 4,
                      right: 8,
                      left: 2,
                    ),
                    child: WorkRequestTile(
                      workRequest: _filteredWorkRequests![index],
                    ),
                  ),
                ),
              );
            } else {
              // shows shimmer when loading
              return ListView.separated(
                padding: const EdgeInsets.only(top: 4),
                separatorBuilder: (context, index) => const SizedBox(
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
    );
  }
}
