import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:under_control_v2/features/tasks/presentation/widgets/show_all_archive_work_requests_button.dart';

import '../../../assets/presentation/widgets/asset_details/shimmer_asset_action_list_tile.dart';
import '../blocs/work_request_archive/work_request_archive_bloc.dart';
import '../widgets/work_request_tile.dart';

class WorkRequestArchivePage extends StatelessWidget {
  const WorkRequestArchivePage({Key? key}) : super(key: key);

  static const routeName = '/tasks/work-order-archive';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.work_request_archive),
        centerTitle: true,
      ),
      body: BlocBuilder<WorkRequestArchiveBloc, WorkRequestArchiveState>(
        builder: (context, state) {
          if (state is WorkRequestArchiveLoadedState) {
            if (state.allWorkRequests.allWorkRequests.isEmpty) {
              return Center(
                child: Text(
                  AppLocalizations.of(context)!.item_no_items,
                ),
              );
            }
            final workRequests = state.allWorkRequests.allWorkRequests
              ..sort((a, b) => b.date.compareTo(a.date));
            return Scrollbar(
              child: ListView(
                shrinkWrap: true,
                children: [
                  ...workRequests.map(
                    (workRequest) => Padding(
                      padding: const EdgeInsets.only(
                        top: 4,
                        bottom: 4,
                        right: 8,
                        left: 2,
                      ),
                      child: WorkRequestTile(
                        workRequest: workRequest,
                      ),
                    ),
                  ),
                  const ShowAllArchiveWorkRequestsButton(),
                ],
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
    );
  }
}
