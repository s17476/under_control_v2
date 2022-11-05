import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../assets/presentation/widgets/asset_details/shimmer_asset_action_list_tile.dart';
import '../blocs/work_order_archive/work_order_archive_bloc.dart';
import '../widgets/work_order_tile.dart';

class WorkOrderArchivePage extends StatelessWidget {
  const WorkOrderArchivePage({Key? key}) : super(key: key);

  static const routeName = '/tasks/work-order-archive';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.work_order_archive),
        centerTitle: true,
      ),
      body: BlocBuilder<WorkOrderArchiveBloc, WorkOrderArchiveState>(
        builder: (context, state) {
          if (state is WorkOrderArchiveEmptyState) {
            context.read<WorkOrderArchiveBloc>().add(
                  GetWorkOrdersArchiveStreamEvent(),
                );
          }
          if (state is WorkOrderArchiveLoadedState) {
            if (state.allWorkOrders.allWorkOrders.isEmpty) {
              return Center(
                child: Text(
                  AppLocalizations.of(context)!.item_no_items,
                ),
              );
            }
            return ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: state.allWorkOrders.allWorkOrders.length,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.only(
                  top: 4,
                  bottom: 4,
                  right: 8,
                  left: 2,
                ),
                child: WorkOrderTile(
                  workOrder: state.allWorkOrders.allWorkOrders[index],
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
    );
  }
}
