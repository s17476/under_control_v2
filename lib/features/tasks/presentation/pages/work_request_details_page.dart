import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../core/presentation/widgets/home_page/app_bar_animated_icon.dart';
import '../../../core/presentation/widgets/loading_widget.dart';
import '../../../core/utils/choice.dart';
import '../../../core/utils/get_cached_firebase_storage_file.dart';
import '../../../core/utils/get_user_premission.dart';
import '../../../core/utils/premission.dart';
import '../../../core/utils/responsive_size.dart';
import '../../../groups/domain/entities/feature.dart';
import '../../domain/entities/work_request/work_request.dart';
import '../../utils/show_work_request_cancel_dialog.dart';
import '../../utils/work_request_management_bloc_listener.dart';
import '../blocs/work_request/work_request_bloc.dart';
import '../blocs/work_request_archive/work_request_archive_bloc.dart';
import '../blocs/work_request_management/work_request_management_bloc.dart';
import '../widgets/work_request_details/images_tab.dart';
import '../widgets/work_request_details/video_tab.dart';
import '../widgets/work_request_details/work_request_info_tab.dart';
import 'add_task_page.dart';
import 'add_work_request_page.dart';

class WorkRequestDetailsPage extends StatefulWidget {
  const WorkRequestDetailsPage({Key? key}) : super(key: key);

  static const routeName = '/work-order-details';

  @override
  State<WorkRequestDetailsPage> createState() => _WorkRequestDetailsPageState();
}

class _WorkRequestDetailsPageState extends State<WorkRequestDetailsPage>
    with ResponsiveSize {
  WorkRequest? _workRequest;
  // late UserProfile _currentUser;

  List<Choice> _choices = [];

  int _tabsCount = 1;

  @override
  void didChangeDependencies() {
    // gets selected asset
    final workRequestId =
        (ModalRoute.of(context)?.settings.arguments as String);
    final workRequestState = context.watch<WorkRequestBloc>().state;
    if (workRequestState is WorkRequestLoadedState) {
      _workRequest = workRequestState.getWorkRequestById(workRequestId);
      if (_workRequest == null) {
        final workRequestArchiveState =
            context.watch<WorkRequestArchiveBloc>().state;
        if (workRequestArchiveState is WorkRequestArchiveLoadedState) {
          _workRequest =
              workRequestArchiveState.getWorkRequestById(workRequestId);
        }
      }
      if (_workRequest != null) {
        // precache images
        for (var imageUrl in _workRequest!.images) {
          precacheImage(CachedNetworkImageProvider(imageUrl), context);
        }
        // precache video
        if (_workRequest!.video.isNotEmpty) {
          getCachedFirebaseStorageFile(_workRequest!.video);
        }

        // number of tabs
        _tabsCount = 1;
        _tabsCount += _workRequest!.images.isNotEmpty ? 1 : 0;
        _tabsCount += _workRequest!.video.isNotEmpty ? 1 : 0;
        // popup menu items
        _choices = [
          // convert work order
          if (getUserPremission(
            context: context,
            featureType: FeatureType.tasks,
            premissionType: PremissionType.create,
          ))
            Choice(
              title: AppLocalizations.of(context)!.work_request_convert,
              icon: Icons.add_task,
              onTap: () => Navigator.pushReplacementNamed(
                context,
                AddTaskPage.routeName,
                arguments: _workRequest,
              ),
            ),
          // edit work order
          if (getUserPremission(
            context: context,
            featureType: FeatureType.tasks,
            premissionType: PremissionType.edit,
          ))
            Choice(
              title: AppLocalizations.of(context)!.edit,
              icon: Icons.edit,
              onTap: () => Navigator.pushNamed(
                context,
                AddWorkRequestPage.routeName,
                arguments: _workRequest,
              ),
            ),
          // cancel work order
          if (getUserPremission(
            context: context,
            featureType: FeatureType.tasks,
            premissionType: PremissionType.delete,
          ))
            Choice(
              title: AppLocalizations.of(context)!.work_request_cancel,
              icon: Icons.clear,
              onTap: () async => showWorkRequestCancelDialog(
                context: context,
                workRequest: _workRequest!,
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

    appBarTitle = AppLocalizations.of(context)!.work_request_details;

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
            if (_workRequest != null &&
                !_workRequest!.cancelled &&
                getUserPremission(
                  context: context,
                  featureType: FeatureType.tasks,
                  premissionType: PremissionType.create,
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
              if (_workRequest!.images.isNotEmpty)
                Tab(
                  icon: Icon(
                    Icons.image,
                    color: tabBarIconColor,
                    size: tabBarIconSize,
                  ),
                ),
              if (_workRequest!.video.isNotEmpty)
                Tab(
                  icon: Icon(
                    FontAwesomeIcons.play,
                    color: tabBarIconColor,
                    size: tabBarIconSize,
                  ),
                ),
            ],
            indicatorColor: tabBarIconColor,
          ),
        ),
        body: _workRequest == null
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
                    WorkRequestInfoTab(workRequest: _workRequest!),
                    if (_workRequest!.images.isNotEmpty)
                      ImagesTab(images: _workRequest!.images),
                    if (_workRequest!.video.isNotEmpty)
                      VideoTab(videoUrl: _workRequest!.video),
                  ],
                ),
              ),
      ),
    );
  }
}
