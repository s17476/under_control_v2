import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../core/presentation/pages/loading_page.dart';
import '../../../notifications/domain/entities/notification_type.dart';
import '../blocs/notification_settings/notification_settings_cubit.dart';
import '../widgets/settings_switch.dart';

class NotificationSettingsPage extends StatelessWidget {
  const NotificationSettingsPage({super.key});

  static const routeName = '/settings/notification';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.notifications,
        ),
      ),
      body: BlocBuilder<NotificationSettingsCubit, NotificationSettingsState>(
        builder: (context, state) {
          if (state is NotificationSettingsLoaded) {
            return ListView(
              children: [
                const SizedBox(
                  height: 8,
                ),
                // work requests
                SettingsSwitch(
                  icon: const Icon(Icons.warning),
                  title: AppLocalizations.of(context)!.work_requests,
                  description:
                      AppLocalizations.of(context)!.notifications_work_requests,
                  value: state.settings.workRequests,
                  onChanged: (value) =>
                      context.read<NotificationSettingsCubit>().updateSettings(
                            type: NotificationType.workRequests,
                            value: value,
                          ),
                ),

                // tasks
                SettingsSwitch(
                  icon: const Icon(Icons.task_alt),
                  title: AppLocalizations.of(context)!.bottom_bar_title_tasks,
                  description:
                      AppLocalizations.of(context)!.notifications_tasks,
                  value: state.settings.tasks,
                  onChanged: (value) =>
                      context.read<NotificationSettingsCubit>().updateSettings(
                            type: NotificationType.tasks,
                            value: value,
                          ),
                ),

                // inventory
                SettingsSwitch(
                  icon: const Icon(Icons.apps),
                  title:
                      AppLocalizations.of(context)!.bottom_bar_title_inventory,
                  description:
                      AppLocalizations.of(context)!.notifications_inventory,
                  value: state.settings.items,
                  onChanged: (value) =>
                      context.read<NotificationSettingsCubit>().updateSettings(
                            type: NotificationType.items,
                            value: value,
                          ),
                ),

                // assets
                SettingsSwitch(
                  icon: const Icon(Icons.precision_manufacturing),
                  title: AppLocalizations.of(context)!.bottom_bar_title_assets,
                  description:
                      AppLocalizations.of(context)!.notifications_assets,
                  value: state.settings.assets,
                  onChanged: (value) =>
                      context.read<NotificationSettingsCubit>().updateSettings(
                            type: NotificationType.assets,
                            value: value,
                          ),
                ),
              ],
            );
          }
          if (state is NotificationSettingsError) {
            return const Center(child: Text('Error occured'));
          }
          return const LoadingPage();
        },
      ),
    );
  }
}
