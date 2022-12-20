import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../assets/presentation/widgets/asset_details/shimmer_asset_action_list_tile.dart';
import '../../../core/presentation/widgets/icon_title_row.dart';
import '../../../core/utils/get_user_permission.dart';
import '../../../core/utils/permission.dart';
import '../../../groups/domain/entities/feature.dart';
import '../../../tasks/domain/entities/work_request/work_request.dart';
import '../../../tasks/presentation/blocs/work_request/work_request_bloc.dart';
import '../../../tasks/presentation/widgets/work_request_tile.dart';

class WorkRequestsLatest extends StatefulWidget {
  const WorkRequestsLatest({
    Key? key,
  }) : super(key: key);

  @override
  State<WorkRequestsLatest> createState() => _WorkRequestsLatestState();
}

class _WorkRequestsLatestState extends State<WorkRequestsLatest> {
  List<WorkRequest>? _workRequests;

  @override
  void didChangeDependencies() {
    final workRequestsState = context.watch<WorkRequestBloc>().state;
    if (workRequestsState is WorkRequestLoadedState) {
      _workRequests =
          workRequestsState.allWorkRequests.allWorkRequests.reversed.toList();
      if (_workRequests != null && _workRequests!.length > 5) {
        _workRequests = _workRequests!.sublist(0, 5);
      }
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
                  // gradient: LinearGradient(
                  //   colors: [
                  //     Colors.red.shade900.withAlpha(150),
                  //     Colors.red.withAlpha(50),
                  //   ],
                  //   begin: Alignment.topLeft,
                  //   end: Alignment.bottomRight,
                  // ),
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
                        icon: Icons.add_task,
                        iconColor: Colors.white,
                        iconBackground: Colors.red,
                        title:
                            '${AppLocalizations.of(context)!.work_requests} - ${AppLocalizations.of(context)!.item_details_latest_actions}',
                      ),
                    ),
                    if (_workRequests == null)
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
                      Colors.red.shade800.withAlpha(150),
                      Theme.of(context).scaffoldBackgroundColor
                    ],
                    stops: const [0, 0.005],
                  ),
                ),
                child: Column(
                  children: [
                    if (_workRequests == null)
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
                    if (_workRequests != null && _workRequests!.isNotEmpty)
                      ListView.builder(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: _workRequests!.length,
                        itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: WorkRequestTile(
                            workRequest: _workRequests![index],
                          ),
                        ),
                      ),
                    if (_workRequests != null && _workRequests!.isEmpty)
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
              ),
            ],
          );
  }
}
