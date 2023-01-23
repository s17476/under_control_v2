import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:under_control_v2/features/tasks/utils/show_task_template_delete_dialog.dart';

import '../../../core/presentation/widgets/home_page/app_bar_animated_icon.dart';
import '../../../core/presentation/widgets/loading_widget.dart';
import '../../../core/utils/choice.dart';
import '../../../core/utils/get_cached_firebase_storage_file.dart';
import '../../../core/utils/get_user_permission.dart';
import '../../../core/utils/permission.dart';
import '../../../core/utils/responsive_size.dart';
import '../../../groups/domain/entities/feature.dart';
import '../../domain/entities/task/task.dart';
import '../../utils/task_action_management_bloc_listener.dart';
import '../../utils/work_request_management_bloc_listener.dart';
import '../blocs/task_action_management/task_action_management_bloc.dart';
import '../blocs/task_templates/task_templates_bloc.dart';
import '../blocs/work_request_management/work_request_management_bloc.dart';
import '../widgets/task_details/task_checklist_tab.dart';
import '../widgets/task_details/task_instructions_tab.dart';
import '../widgets/task_details/task_spare_part_tab.dart';
import '../widgets/task_details/task_template_info_tab.dart';
import '../widgets/work_request_details/images_tab.dart';
import '../widgets/work_request_details/video_tab.dart';
import 'add_task_template_page.dart';

class TaskTemplateDetailsPage extends StatefulWidget {
  const TaskTemplateDetailsPage({Key? key}) : super(key: key);

  static const routeName = '/task-template-details';

  @override
  State<TaskTemplateDetailsPage> createState() =>
      _TaskTemplateDetailsPageState();
}

class _TaskTemplateDetailsPageState extends State<TaskTemplateDetailsPage>
    with ResponsiveSize {
  Task? _task;
  // late TaskActionBloc _taskActionBloc;

  List<Choice> _choices = [];

  int _tabsCount = 2;

  @override
  void didChangeDependencies() {
    // _taskActionBloc = context.read<TaskActionBloc>();
    final taskId = (ModalRoute.of(context)?.settings.arguments as String);
    final taskState = context.watch<TaskTemplatesBloc>().state;
    if (taskState is TaskTemplatesLoadedState) {
      _task = taskState.getTaskById(taskId);
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
        _tabsCount = 1;
        _tabsCount += _task!.checklist.isNotEmpty ? 1 : 0;
        _tabsCount += _task!.images.isNotEmpty ? 1 : 0;
        _tabsCount += _task!.video.isNotEmpty ? 1 : 0;
        _tabsCount += _task!.instructions.isNotEmpty ? 1 : 0;
        _tabsCount += (_task!.sparePartsAssets.isNotEmpty ||
                _task!.sparePartsItems.isNotEmpty)
            ? 1
            : 0;
        // popup menu items
        _choices = [
          // edit task template
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
                AddTaskTemplatePage.routeName,
                arguments: _task,
              ),
            ),
          // delete task template
          if (getUserPermission(
            context: context,
            featureType: FeatureType.tasks,
            permissionType: PermissionType.delete,
          ))
            Choice(
              title: AppLocalizations.of(context)!.delete,
              icon: Icons.delete,
              onTap: () => showTaskTemplateDeleteDialog(
                context: context,
                task: _task!,
              ).then((value) {
                if (value != null && value == true) {
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

    return BlocListener<TaskActionManagementBloc, TaskActionManagementState>(
      listener: (context, state) {
        taskActionManagementBlocListener(context, state);
      },
      child: _task == null
          ? const SizedBox()
          : DefaultTabController(
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
                      if (_task!.checklist.isNotEmpty)
                        Tab(
                          icon: Icon(
                            Icons.checklist,
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
                                workRequestManagementBlocListener(
                                    context, state),
                          ),
                        ],
                        child: TabBarView(
                          children: [
                            TaskTemplateInfoTab(task: _task!),
                            if (_task!.checklist.isNotEmpty)
                              TaskChecklistTab(checklist: _task!.checklist),
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
            ),
    );
  }
}
