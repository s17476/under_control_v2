import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../assets/presentation/widgets/asset_details/shimmer_asset_action_list_tile.dart';
import '../../../core/presentation/widgets/icon_title_row.dart';
import '../../../core/utils/get_user_permission.dart';
import '../../../core/utils/permission.dart';
import '../../../groups/domain/entities/feature.dart';
import '../../../tasks/domain/entities/task/task.dart';
import '../../../tasks/presentation/blocs/task/task_bloc.dart';
import '../../../tasks/presentation/widgets/task_tile.dart';
import '../../../user_profile/domain/entities/user_profile.dart';
import '../../../user_profile/presentation/blocs/user_profile/user_profile_bloc.dart';

class MyTasks extends StatefulWidget {
  const MyTasks({
    Key? key,
  }) : super(key: key);

  @override
  State<MyTasks> createState() => _MyTasksState();
}

class _MyTasksState extends State<MyTasks> {
  List<Task>? _tasks;
  UserProfile? _userProfile;

  @override
  void didChangeDependencies() {
    final tomorrow = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day + 1,
    );
    final userState = context.watch<UserProfileBloc>().state;
    if (userState is Approved) {
      _userProfile = userState.userProfile;
    }
    final tasksState = context.watch<TaskBloc>().state;
    if (tasksState is TaskLoadedState && _userProfile != null) {
      // print(_userProfile!.userGroups);
      _tasks = tasksState.allTasks.allTasks
          .where((task) => task.executionDate.isBefore(tomorrow))
          .where((task) =>
              task.assignedUsers.contains(
                _userProfile!.id,
              ) ||
              task.assignedGroups.any(
                (groupId) => _userProfile!.userGroups.contains(
                  groupId,
                ),
              ))
          .toList();
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final permission = getUserPermission(
      context: context,
      featureType: FeatureType.tasks,
      permissionType: PermissionType.read,
    );
    return !permission
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
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: IconTitleRow(
                        icon: Icons.task_alt_sharp,
                        iconColor: Colors.white,
                        iconBackground: Theme.of(context).primaryColor,
                        title: AppLocalizations.of(context)!.status_my_tasks,
                      ),
                    ),
                    if (_tasks == null)
                      const SizedBox(
                        width: 25,
                        height: 25,
                        child: CircularProgressIndicator(),
                      ),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Theme.of(context).primaryColor.withAlpha(20),
                      Theme.of(context).scaffoldBackgroundColor
                    ],
                    stops: const [0, 0.005],
                  ),
                ),
                child: Column(
                  children: [
                    if (_tasks == null)
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
                    if (_tasks != null && _tasks!.isNotEmpty)
                      ListView.builder(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: _tasks!.length,
                        itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: TaskTile(
                            key: ValueKey(_tasks![index].id),
                            task: _tasks![index],
                          ),
                        ),
                      ),
                    if (_tasks != null && _tasks!.isEmpty)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          alignment: Alignment.center,
                          height: 50,
                          child: Text(
                            AppLocalizations.of(context)!
                                .status_my_tasks_no_tasks,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          );
  }
}
