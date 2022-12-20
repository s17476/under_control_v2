import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../core/presentation/widgets/home_page/app_bar_animated_icon.dart';
import '../../../core/presentation/widgets/loading_widget.dart';
import '../../../core/utils/choice.dart';
import '../../../core/utils/get_cached_firebase_storage_file.dart';
import '../../../core/utils/get_user_permission.dart';
import '../../../core/utils/permission.dart';
import '../../../core/utils/responsive_size.dart';
import '../../../groups/domain/entities/feature.dart';
import '../../domain/entities/task/task.dart';
import '../../utils/show_task_cancel_dialog.dart';
import '../../utils/work_request_management_bloc_listener.dart';
import '../blocs/task/task_bloc.dart';
import '../blocs/task_archive/task_archive_bloc.dart';
import '../blocs/work_request_management/work_request_management_bloc.dart';
import '../widgets/task_details/task_actions_tab.dart';
import '../widgets/task_details/task_info_tab.dart';
import '../widgets/task_details/task_instructions_tab.dart';
import '../widgets/task_details/task_spare_part_tab.dart';
import '../widgets/work_request_details/images_tab.dart';
import '../widgets/work_request_details/video_tab.dart';
import 'add_task_page.dart';

class TaskDetailsPage extends StatefulWidget {
  const TaskDetailsPage({Key? key}) : super(key: key);

  static const routeName = '/task-details';

  @override
  State<TaskDetailsPage> createState() => _TaskDetailsPageState();
}

class _TaskDetailsPageState extends State<TaskDetailsPage> with ResponsiveSize {
  Task? _task;
  // late UserProfile _currentUser;

  List<Choice> _choices = [];

  int _tabsCount = 2;

  @override
  void didChangeDependencies() {
    final taskId = (ModalRoute.of(context)?.settings.arguments as String);
    final taskState = context.watch<TaskBloc>().state;
    if (taskState is TaskLoadedState) {
      _task = taskState.getTaskById(taskId);
      if (_task == null) {
        final taskArchiveState = context.watch<TaskArchiveBloc>().state;
        if (taskArchiveState is TaskArchiveLoadedState) {
          _task = taskArchiveState.getTaskById(taskId);
        }
      }
      if (_task != null) {
        // precache images
        for (var imageUrl in _task!.images) {
          precacheImage(CachedNetworkImageProvider(imageUrl), context);
        }
        // precache video
        if (_task!.video.isNotEmpty) {
          getCachedFirebaseStorageFile(_task!.video);
        }

        // number of tabs
        _tabsCount = 2;
        _tabsCount += _task!.images.isNotEmpty ? 1 : 0;
        _tabsCount += _task!.video.isNotEmpty ? 1 : 0;
        _tabsCount += _task!.instructions.isNotEmpty ? 1 : 0;
        _tabsCount += (_task!.sparePartsAssets.isNotEmpty ||
                _task!.sparePartsItems.isNotEmpty)
            ? 1
            : 0;
        // popup menu items
        _choices = [
          // edit work order
          if (getUserPermission(
            context: context,
            featureType: FeatureType.tasks,
            permissionType: PermissionType.edit,
          ))
            Choice(
              title: AppLocalizations.of(context)!.edit,
              icon: Icons.edit,
              onTap: () => Navigator.pushNamed(
                context,
                AddTaskPage.routeName,
                arguments: _task,
              ),
            ),
          // cancel work order
          if (getUserPermission(
            context: context,
            featureType: FeatureType.tasks,
            permissionType: PermissionType.delete,
          ))
            Choice(
              title: AppLocalizations.of(context)!.task_cancel,
              icon: Icons.clear,
              onTap: () async => showTaskCancelDialog(
                context: context,
                task: _task!,
              ).then((value) {
                if (value is bool && value) {
                  Navigator.pop(context);
                }
              }),
            ),
        ];
      }
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    String appBarTitle = '';
    final Color? tabBarIconColor = Theme.of(context).textTheme.bodyLarge!.color;
    const double tabBarIconSize = 32;
    appBarTitle = AppLocalizations.of(context)!.task_details;

    return DefaultTabController(
      length: _tabsCount,
      child: Scaffold(
        appBar: AppBar(
          title: Text(appBarTitle),
          centerTitle: true,
          leading: Builder(
            builder: (context) {
              return GestureDetector(
                onTap: () => Navigator.pop(context),
                child: const AppBarAnimatedIcon(isBackIcon: true),
              );
            },
          ),
          actions: [
            // popup menu
            if (_task != null &&
                !_task!.isCancelled &&
                getUserPermission(
                  context: context,
                  featureType: FeatureType.tasks,
                  permissionType: PermissionType.edit,
                ))
              PopupMenuButton<Choice>(
                onSelected: (Choice choice) {
                  choice.onTap();
                },
                itemBuilder: (BuildContext context) {
                  return _choices.map((Choice choice) {
                    return PopupMenuItem<Choice>(
                      value: choice,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(choice.icon),
                          const SizedBox(
                            width: 4,
                          ),
                          Text(
                            choice.title,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    );
                  }).toList();
                },
              ),
          ],
          bottom: TabBar(
            tabs: [
              Tab(
                icon: Icon(
                  Icons.info,
                  color: tabBarIconColor,
                  size: tabBarIconSize,
                ),
              ),
              Tab(
                icon: Icon(
                  Icons.work_history,
                  color: tabBarIconColor,
                  size: tabBarIconSize,
                ),
              ),
              if (_task!.images.isNotEmpty)
                Tab(
                  icon: Icon(
                    Icons.image,
                    color: tabBarIconColor,
                    size: tabBarIconSize,
                  ),
                ),
              if (_task!.video.isNotEmpty)
                Tab(
                  icon: Icon(
                    FontAwesomeIcons.play,
                    color: tabBarIconColor,
                    size: tabBarIconSize,
                  ),
                ),
              if (_task!.instructions.isNotEmpty)
                Tab(
                  icon: Icon(
                    Icons.menu_book,
                    color: tabBarIconColor,
                    size: tabBarIconSize,
                  ),
                ),
              if (_task!.sparePartsAssets.isNotEmpty ||
                  _task!.sparePartsItems.isNotEmpty)
                Tab(
                  icon: Icon(
                    Icons.settings_applications,
                    color: tabBarIconColor,
                    size: tabBarIconSize,
                  ),
                ),
            ],
            indicatorColor: tabBarIconColor,
          ),
        ),
        body: _task == null
            ? const LoadingWidget()
            : MultiBlocListener(
                listeners: [
                  BlocListener<WorkRequestManagementBloc,
                      WorkRequestManagementState>(
                    listener: (context, state) =>
                        workRequestManagementBlocListener(context, state),
                  ),
                ],
                child: TabBarView(
                  children: [
                    TaskInfoTab(task: _task!),
                    TaskActionsTab(task: _task!),
                    if (_task!.images.isNotEmpty)
                      ImagesTab(images: _task!.images),
                    if (_task!.video.isNotEmpty)
                      VideoTab(videoUrl: _task!.video),
                    if (_task!.instructions.isNotEmpty)
                      TaskInstructionsTab(task: _task!),
                    if (_task!.sparePartsAssets.isNotEmpty ||
                        _task!.sparePartsItems.isNotEmpty)
                      TaskSparePartTab(
                        sparePartsAssets: _task!.sparePartsAssets,
                        sparePartsItems: _task!.sparePartsItems,
                      ),
                  ],
                ),
              ),
      ),
    );
  }
}
