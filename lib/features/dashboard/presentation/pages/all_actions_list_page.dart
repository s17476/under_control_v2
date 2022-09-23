import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../filter/presentation/widgets/home_page_filter.dart';
import '../../../inventory/domain/entities/item_action/item_action.dart';
import '../../../inventory/presentation/blocs/dashboard_item_action/dashboard_item_action_bloc.dart';
import '../../../inventory/presentation/widgets/actions/item_action_list_tile.dart';

class AllActionsListPage extends StatefulWidget {
  const AllActionsListPage({Key? key}) : super(key: key);

  static const routeName = '/item-details/all-actions-list';

  @override
  State<AllActionsListPage> createState() => _AllActionsListPageState();
}

class _AllActionsListPageState extends State<AllActionsListPage> {
  List<ItemAction>? actions;
  bool isFilterExpanded = false;

  @override
  void initState() {
    // gets item actions
    context.read<DashboardItemActionBloc>().add(
          GetDashboardItemActionsEvent(),
        );
    super.initState();
  }

  @override
  void didChangeDependencies() {
    final actionsState = context.watch<DashboardItemActionBloc>().state;
    if (actionsState is DashboardItemActionLoadedState) {
      actions = actionsState.allActions.allItemActions.toList();
    }

    super.didChangeDependencies();
  }

  // TODO
  // add date sliders ti limit actions
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.item_actions_history,
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          AnimatedSize(
            duration: const Duration(milliseconds: 600),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  if (actions != null && actions!.isNotEmpty)
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      itemCount: actions!.length,
                      itemBuilder: (context, index) => ItemActionListTile(
                        action: actions![index],
                        isDashboardTile: true,
                      ),
                    ),
                  if (actions != null && actions!.isEmpty)
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
          ),
        ],
      ),
    );
  }
}
