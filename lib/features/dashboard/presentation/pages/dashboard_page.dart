import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:under_control_v2/features/inventory/presentation/blocs/dashboard_item_action/dashboard_item_action_bloc.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          child: BlocBuilder<DashboardItemActionBloc, DashboardItemActionState>(
            builder: (context, state) {
              if (state is DashboardItemActionLoadedState) {
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: state.allActions.allItemActions.length,
                  itemBuilder: (context, index) => Card(
                    child: Column(
                      children: [
                        Text(
                          state.allActions.allItemActions[index].locationId,
                        ),
                        Text(
                          state.allActions.allItemActions[index].date
                              .toIso8601String(),
                        ),
                      ],
                    ),
                  ),
                );
              } else {
                return const CircularProgressIndicator();
              }
            },
          ),
        ),
      ),
    );
  }
}
