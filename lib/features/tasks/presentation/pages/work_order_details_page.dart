import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:under_control_v2/features/tasks/presentation/widgets/work_order_details/work_order_info_tab.dart';

import '../../../core/presentation/widgets/loading_widget.dart';
import '../../../core/utils/choice.dart';
import '../../../core/utils/get_user_premission.dart';
import '../../../core/utils/premission.dart';
import '../../../core/utils/responsive_size.dart';
import '../../../groups/domain/entities/feature.dart';
import '../../../user_profile/domain/entities/user_profile.dart';
import '../../../user_profile/presentation/blocs/user_profile/user_profile_bloc.dart';
import '../../domain/entities/work_order/work_order.dart';
import '../../utils/work_order_management_bloc_listener.dart';
import '../blocs/work_order/work_order_bloc.dart';
import '../blocs/work_order_management/work_order_management_bloc.dart';
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
  late UserProfile _currentUser;

  List<Choice> _choices = [];

  @override
  void didChangeDependencies() {
    // gets current user
    final currentState = context.read<UserProfileBloc>().state;
    if (currentState is Approved) {
      _currentUser = currentState.userProfile;
    }
    // gets selected asset
    final workOrderId = (ModalRoute.of(context)?.settings.arguments as String);
    final workOrderState = context.watch<WorkOrderBloc>().state;
    if (workOrderState is WorkOrderLoadedState) {
      setState(() {
        _workOrder = workOrderState.getWorkOrderById(workOrderId);
      });
      if (_workOrder != null) {
        // popup menu items
        _choices = [
          // edit item
          if (getUserPremission(
            context: context,
            featureType: FeatureType.assets,
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
          // copy work order
          // if (getUserPremission(
          //   context: context,
          //   featureType: FeatureType.assets,
          //   premissionType: PremissionType.create,
          // ))
          //   Choice(
          //     title: AppLocalizations.of(context)!.copy,
          //     icon: Icons.copy,
          //     onTap: () => Navigator.pushNamed(
          //       context,
          //       AddAssetPage.routeName,
          //       arguments: AssetModel.fromAsset(_workOrder!).copyWith(id: ''),
          //     ),
          //   ),
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
      length: 1,
      child: Scaffold(
        appBar: AppBar(
          title: Text(appBarTitle),
          centerTitle: true,
          actions: [
            // popup menu
            if (getUserPremission(
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
              // Tab(
              //   icon: Icon(
              //     FontAwesomeIcons.images,
              //     color: tabBarIconColor,
              //     size: tabBarIconSize,
              //   ),
              // ),
              // Tab(
              //   icon: Icon(
              //     FontAwesomeIcons.play,
              //     color: tabBarIconColor,
              //     size: tabBarIconSize,
              //   ),
              // ),
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
                    // AssetInfoTab(asset: _workOrder!),
                    // AssetHistoryTab(asset: _workOrder!),
                    // AssetImagesTab(asset: _workOrder!),
                  ],
                ),
              ),
      ),
    );
  }
}
