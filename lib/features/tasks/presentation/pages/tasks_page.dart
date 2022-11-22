import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:under_control_v2/features/tasks/domain/entities/task/task.dart';
import 'package:under_control_v2/features/tasks/domain/entities/work_request/work_request.dart';
import 'package:under_control_v2/features/tasks/presentation/blocs/work_request/work_request_bloc.dart';
import 'package:under_control_v2/features/user_profile/presentation/blocs/user_profile/user_profile_bloc.dart';

import '../../../assets/presentation/widgets/asset_details/shimmer_asset_action_list_tile.dart';
import '../../../core/utils/get_user_premission.dart';
import '../../../core/utils/premission.dart';
import '../../../core/utils/responsive_size.dart';
import '../../../groups/domain/entities/feature.dart';
import '../../../user_profile/domain/entities/user_profile.dart';
import '../../domain/entities/task_priority.dart';
import '../../domain/entities/task_type.dart';
import '../../utils/get_task_priority_icon.dart';
import '../../utils/get_task_type_icon.dart';
import '../blocs/task/task_bloc.dart';
import '../blocs/task_filter/task_filter_bloc.dart';
import '../widgets/tasks_tab_view.dart';
import '../widgets/work_requests_tab_view.dart';

class TasksPage extends StatelessWidget with ResponsiveSize {
  const TasksPage({
    Key? key,
    required this.isTasksFilterVisible,
    required this.tasksFilterHeight,
  }) : super(key: key);

  final bool isTasksFilterVisible;
  final double tasksFilterHeight;

  @override
  Widget build(BuildContext context) {
    final premission = getUserPremission(
      context: context,
      featureType: FeatureType.tasks,
      premissionType: PremissionType.read,
    );
    return CustomScrollView(
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
                        AppLocalizations.of(context)!.premission_no_premission,
                      ),
                    ),
                  ],
                )
              : Column(
                  children: [
                    AnimatedContainer(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      duration: const Duration(milliseconds: 300),
                      height: isTasksFilterVisible ? tasksFilterHeight : 0,
                    ),
                    BlocBuilder<TaskFilterBloc, TaskFilterState>(
                      builder: (context, state) {
                        if (state is TaskFilterInitialState) {
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
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            WorkRequestsTabView(
                              workRequests: state.workRequests,
                            ),
                            const Divider(
                              thickness: 1.5,
                            ),
                            TasksTabView(
                              tasks: state.tasks,
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
        ),
      ],
    );
  }
}

// class TasksPage extends StatefulWidget {
//   const TasksPage({
//     Key? key,
//   }) : super(key: key);

//   @override
//   State<TasksPage> createState() => _TasksPageState();
// }

// class _TasksPageState extends State<TasksPage>
//     with ResponsiveSize, SingleTickerProviderStateMixin {
//   List<WorkRequest>? _workRequests;
//   List<WorkRequest> _filteredWorkRequests = [];
//   List<Task>? _tasks;
//   List<Task> _filteredTasks = [];
//   int _ownerIndex = 0;
//   int _priorityIndex = 0;
//   int _taskTypeIndex = 0;
//   late TabController _ownerTabController;
//   late UserProfile _userProfile;

//   void _setOwnerIndex(int value) {
//     setState(() {
//       _ownerIndex = value;
//     });
//   }

//   void _setPriorityIndex(int value) {
//     setState(() {
//       _priorityIndex = value;
//     });
//   }

//   void _setTaskTypeIndex(int value) {
//     setState(() {
//       _taskTypeIndex = value;
//     });
//   }

//   void _filter() {
//     // filter owner
//     switch (_ownerIndex) {
//       // all tasks
//       case 0:
//         _filteredTasks = _tasks ?? [];
//         break;
//       // user tasks
//       case 1:
//         _filteredTasks = _tasks
//                 ?.where(
//                   (task) => task.assignedUsers.contains(
//                     _userProfile.id,
//                   ),
//                 )
//                 .toList() ??
//             [];
//         break;
//       // groups tasks
//       case 2:
//         _filteredTasks = _tasks
//                 ?.where(
//                   (task) => task.assignedGroups.any(
//                     (groupId) => _userProfile.userGroups.contains(
//                       groupId,
//                     ),
//                   ),
//                 )
//                 .toList() ??
//             [];
//         break;
//       default:
//         _filteredTasks = _tasks ?? [];
//         break;
//     }

//     // filter priority
//     switch (_priorityIndex) {
//       case 0:
//         _filteredWorkRequests = _workRequests ?? [];
//         break;
//       case 1:
//         _filteredTasks = _filteredTasks
//             .where((task) => task.priority == TaskPriority.low)
//             .toList();
//         _filteredWorkRequests = _workRequests
//                 ?.where((task) => task.priority == TaskPriority.low)
//                 .toList() ??
//             [];
//         break;
//       case 2:
//         _filteredTasks = _filteredTasks
//             .where((task) => task.priority == TaskPriority.medium)
//             .toList();
//         _filteredWorkRequests = _workRequests
//                 ?.where((task) => task.priority == TaskPriority.medium)
//                 .toList() ??
//             [];
//         break;
//       case 3:
//         _filteredTasks = _filteredTasks
//             .where((task) => task.priority == TaskPriority.high)
//             .toList();
//         _filteredWorkRequests = _workRequests
//                 ?.where((task) => task.priority == TaskPriority.high)
//                 .toList() ??
//             [];
//         break;
//       default:
//         _filteredWorkRequests = _workRequests ?? [];
//         break;
//     }

//     // filter by task type
//     switch (_taskTypeIndex) {
//       case 0:
//         break;
//       case 1:
//         _filteredTasks = _filteredTasks
//             .where((task) => task.type == TaskType.maintenance)
//             .toList();
//         break;
//       case 2:
//         _filteredTasks = _filteredTasks
//             .where((task) => task.type == TaskType.reparation)
//             .toList();
//         break;
//       case 3:
//         _filteredTasks = _filteredTasks
//             .where((task) => task.type == TaskType.inspection)
//             .toList();
//         break;
//       case 4:
//         _filteredTasks = _filteredTasks
//             .where((task) => task.type == TaskType.event)
//             .toList();
//         break;
//       default:
//         break;
//     }
//   }

//   Color _getNestedIndicatorColor() {
//     switch (_priorityIndex) {
//       case 0:
//         return Colors.white;
//       case 1:
//         return const Color.fromARGB(255, 28, 154, 97);
//       case 2:
//         return Colors.yellow;
//       case 3:
//         return Colors.red;
//       default:
//         return Colors.white;
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//     _ownerTabController = TabController(length: 3, vsync: this);
//   }

//   @override
//   void didChangeDependencies() {
//     final workRequestsState = context.watch<WorkRequestBloc>().state;
//     if (workRequestsState is WorkRequestLoadedState) {
//       _workRequests = workRequestsState.allWorkRequests.allWorkRequests;
//     }
//     final tasksState = context.watch<TaskBloc>().state;
//     if (tasksState is TaskLoadedState) {
//       _tasks = tasksState.allTasks.allTasks;
//     }
//     final userState = context.watch<UserProfileBloc>().state;
//     if (userState is Approved) {
//       _userProfile = userState.userProfile;
//     }
//     super.didChangeDependencies();
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     _ownerTabController.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final Color? tabBarIconColor = Theme.of(context).textTheme.bodyLarge!.color;
//     const double tabBarIconSize = 32;
//     final premission = getUserPremission(
//       context: context,
//       featureType: FeatureType.tasks,
//       premissionType: PremissionType.read,
//     );
//     _filter();
//     return Stack(
//       children: [
//         CustomScrollView(
//           slivers: [
//             SliverOverlapInjector(
//               handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
//             ),
//             SliverToBoxAdapter(
//               child: !premission
//                   ? Column(
//                       children: [
//                         SizedBox(
//                           height: responsiveSizeVerticalPct(small: 40),
//                         ),
//                         SizedBox(
//                           child: Text(
//                             AppLocalizations.of(context)!
//                                 .premission_no_premission,
//                           ),
//                         ),
//                       ],
//                     )
//                   : Column(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         const SizedBox(
//                           height: 150,
//                         ),
//                         if (_workRequests != null && _workRequests!.isNotEmpty)
//                           WorkRequestsTabView(
//                             workRequests: _filteredWorkRequests,
//                           ),
//                         const Divider(
//                           thickness: 1.5,
//                         ),
//                         if (_tasks != null && _tasks!.isNotEmpty)
//                           TasksTabView(
//                             tasks: _filteredTasks,
//                           ),
//                         if (_tasks == null && _workRequests == null)
//                           ListView.separated(
//                             padding: const EdgeInsets.only(top: 4),
//                             separatorBuilder: (context, index) =>
//                                 const SizedBox(
//                               height: 4,
//                             ),
//                             physics: const NeverScrollableScrollPhysics(),
//                             shrinkWrap: true,
//                             itemCount: 8,
//                             itemBuilder: (context, index) =>
//                                 // shimmer work order
//                                 const ShimmerAssetActionListTile(),
//                           ),
//                       ],
//                     ),
//             ),
//           ],
//         ),
//         Container(
//           color: Theme.of(context).appBarTheme.backgroundColor,
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               // owner tab bar
//               TabBar(
//                 tabs: [
//                   Tab(
//                     icon: Icon(
//                       Icons.all_inclusive,
//                       size: tabBarIconSize,
//                       color: tabBarIconColor,
//                     ),
//                   ),
//                   Tab(
//                     icon: Icon(
//                       Icons.person,
//                       size: tabBarIconSize,
//                       color: tabBarIconColor,
//                     ),
//                   ),
//                   Tab(
//                     icon: Icon(
//                       Icons.group,
//                       size: tabBarIconSize,
//                       color: tabBarIconColor,
//                     ),
//                   ),
//                 ],
//                 controller: _ownerTabController,
//                 indicatorColor: tabBarIconColor,
//                 onTap: _setOwnerIndex,
//               ),
//               PriorityTabBar(
//                 setIndex: _setPriorityIndex,
//                 color: tabBarIconColor,
//                 iconSize: tabBarIconSize,
//               ),

//               TypeTabBar(
//                 setIndex: _setTaskTypeIndex,
//                 color: tabBarIconColor,
//                 iconSize: tabBarIconSize,
//                 indicatorColor: _getNestedIndicatorColor(),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }

// class PriorityTabBar extends StatefulWidget {
//   const PriorityTabBar({
//     Key? key,
//     required this.setIndex,
//     this.iconSize,
//     this.color,
//   }) : super(key: key);

//   final Function(int) setIndex;
//   final double? iconSize;
//   final Color? color;

//   @override
//   State<PriorityTabBar> createState() => _PriorityTabBarState();
// }

// class _PriorityTabBarState extends State<PriorityTabBar>
//     with SingleTickerProviderStateMixin {
//   late TabController _priorityTabController;

//   @override
//   void initState() {
//     _priorityTabController = TabController(length: 4, vsync: this);
//     super.initState();
//   }

//   @override
//   void dispose() {
//     _priorityTabController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.5),
//       child: TabBar(
//         tabs: [
//           Tab(
//             icon: Icon(
//               Icons.all_inclusive,
//               size: widget.iconSize,
//               color: widget.color,
//             ),
//           ),
//           Tab(
//             icon: getTaskPriorityIcon(
//               context,
//               TaskPriority.low,
//               30,
//               const EdgeInsets.all(0),
//               false,
//             ),
//           ),
//           Tab(
//             icon: getTaskPriorityIcon(
//               context,
//               TaskPriority.medium,
//               30,
//               const EdgeInsets.all(0),
//               false,
//             ),
//           ),
//           Tab(
//             icon: getTaskPriorityIcon(
//               context,
//               TaskPriority.high,
//               30,
//               const EdgeInsets.all(0),
//               false,
//             ),
//           ),
//         ],
//         controller: _priorityTabController,
//         indicatorColor: widget.color,
//         onTap: widget.setIndex,
//       ),
//     );
//   }
// }

// class TypeTabBar extends StatefulWidget {
//   const TypeTabBar({
//     Key? key,
//     required this.setIndex,
//     this.iconSize,
//     this.color,
//     this.indicatorColor,
//   }) : super(key: key);

//   final Function(int) setIndex;
//   final double? iconSize;
//   final Color? color;
//   final Color? indicatorColor;

//   @override
//   State<TypeTabBar> createState() => _TypeTabBarState();
// }

// class _TypeTabBarState extends State<TypeTabBar>
//     with SingleTickerProviderStateMixin {
//   late TabController _typeTabController;

//   @override
//   void initState() {
//     _typeTabController = TabController(length: 5, vsync: this);
//     super.initState();
//   }

//   @override
//   void dispose() {
//     _typeTabController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Theme.of(context).scaffoldBackgroundColor,
//       child: TabBar(
//         tabs: [
//           Tab(
//             icon: Icon(
//               Icons.all_inclusive,
//               size: widget.iconSize,
//               color: widget.color,
//             ),
//           ),
//           Tab(
//             icon: getTaskTypeIcon(
//               context,
//               TaskType.maintenance,
//               28,
//               true,
//               widget.color,
//             ),
//           ),
//           Tab(
//             icon: getTaskTypeIcon(
//               context,
//               TaskType.reparation,
//               28,
//               true,
//               widget.color,
//             ),
//           ),
//           Tab(
//             icon: getTaskTypeIcon(
//               context,
//               TaskType.inspection,
//               28,
//               true,
//               widget.color,
//             ),
//           ),
//           Tab(
//             icon: getTaskTypeIcon(
//               context,
//               TaskType.event,
//               28,
//               true,
//               widget.color,
//             ),
//           ),
//         ],
//         controller: _typeTabController,
//         onTap: widget.setIndex,
//         indicatorColor: widget.indicatorColor,
//       ),
//     );
//   }
// }
