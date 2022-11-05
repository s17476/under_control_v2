import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:under_control_v2/features/tasks/presentation/blocs/work_order_archive/work_order_archive_bloc.dart';
import 'package:under_control_v2/features/tasks/utils/show_work_order_cancel_dialog.dart';

import '../../../core/presentation/widgets/loading_widget.dart';
import '../../../core/utils/choice.dart';
import '../../../core/utils/get_user_premission.dart';
import '../../../core/utils/premission.dart';
import '../../../core/utils/responsive_size.dart';
import '../../../groups/domain/entities/feature.dart';
import '../../domain/entities/work_order/work_order.dart';
import '../../utils/work_order_management_bloc_listener.dart';
import '../blocs/work_order/work_order_bloc.dart';
import '../blocs/work_order_management/work_order_management_bloc.dart';
import '../widgets/images_tab.dart';
import '../widgets/video_tab.dart';
import '../widgets/work_order_details/work_order_info_tab.dart';
import 'add_work_order_page.dart';

class WorkOrderDetailsPage extends StatefulWidget {
  const WorkOrderDetailsPage({Key? key}) : super(key: key);

  static const routeName = '/work-order-details';

  @override
  State<WorkOrderDetailsPage> createState() => _WorkOrderDetailsPageState();
}

class _WorkOrderDetailsPageState extends State<WorkOrderDetailsPage>
    with ResponsiveSize {
  WorkOrder? _workOrder;
  // late UserProfile _currentUser;

  List<Choice> _choices = [];

  @override
  void didChangeDependencies() {
    // gets selected asset
    final workOrderId = (ModalRoute.of(context)?.settings.arguments as String);
    final workOrderState = context.watch<WorkOrderBloc>().state;
    if (workOrderState is WorkOrderLoadedState) {
      _workOrder = workOrderState.getWorkOrderById(workOrderId);
      if (_workOrder == null) {
        final workOrderArchiveState =
            context.watch<WorkOrderArchiveBloc>().state;
        if (workOrderArchiveState is WorkOrderArchiveLoadedState) {
          _workOrder = workOrderArchiveState.getWorkOrderById(workOrderId);
        }
      }
      if (_workOrder != null) {
        // popup menu items
        _choices = [
          // convert work order
          if (getUserPremission(
            context: context,
            featureType: FeatureType.tasks,
            premissionType: PremissionType.create,
          ))
            Choice(
              title: AppLocalizations.of(context)!.work_order_convert,
              icon: Icons.add_task,
              onTap: () {},
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
                AddWorkOrderPage.routeName,
                arguments: _workOrder,
              ),
            ),
          // cancel work order
          if (getUserPremission(
            context: context,
            featureType: FeatureType.tasks,
            premissionType: PremissionType.delete,
          ))
            Choice(
              title: AppLocalizations.of(context)!.work_order_cancel,
              icon: Icons.clear,
              onTap: () async => showWorkOrderCancelDialog(
                context: context,
                workOrder: _workOrder!,
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

    appBarTitle = AppLocalizations.of(context)!.work_order_details;

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(appBarTitle),
          centerTitle: true,
          actions: [
            // popup menu
            if (_workOrder != null &&
                !_workOrder!.cancelled &&
                getUserPremission(
                  context: context,
                  featureType: FeatureType.assets,
                  premissionType: PremissionType.edit,
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
                  Icons.image,
                  color: tabBarIconColor,
                  size: tabBarIconSize,
                ),
              ),
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
        body: _workOrder == null
            ? const LoadingWidget()
            : MultiBlocListener(
                listeners: [
                  BlocListener<WorkOrderManagementBloc,
                      WorkOrderManagementState>(
                    listener: (context, state) =>
                        workOrderManagementBlocListener(context, state),
                  ),
                ],
                child: TabBarView(
                  children: [
                    WorkOrderInfoTab(workOrder: _workOrder!),
                    ImagesTab(images: _workOrder!.images),
                    VideoTab(videoUrl: _workOrder!.video),
                  ],
                ),
              ),
      ),
    );
  }
}
