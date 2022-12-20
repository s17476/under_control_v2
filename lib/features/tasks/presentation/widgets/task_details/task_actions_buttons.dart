import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../core/presentation/widgets/rounded_button.dart';
import '../../../../core/utils/get_user_permission.dart';
import '../../../../core/utils/permission.dart';
import '../../../../core/utils/show_snack_bar.dart';
import '../../../../groups/domain/entities/feature.dart';
import '../../../domain/entities/task/task.dart';
import '../../pages/register_task_action_page.dart';

class TaskActionsButtons extends StatelessWidget {
  const TaskActionsButtons({
    Key? key,
    required this.task,
  }) : super(key: key);

  final Task task;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // start button
        Expanded(
          child: RoundedButton(
            onPressed: !getUserPermission(
              context: context,
              featureType: FeatureType.tasks,
              permissionType: PermissionType.create,
            )
                ? () {
                    showSnackBar(
                      context: context,
                      message:
                          AppLocalizations.of(context)!.permission_no_action,
                      isErrorMessage: true,
                    );
                  }
                : () {
                    // Navigator.pushNamed(
                    //   context,
                    //   AddToItemPage.routeName,
                    //   arguments: task,
                    // );
                  },
            icon: Icons.play_arrow,
            iconSize: 40,
            title: AppLocalizations.of(context)!.task_action_start,
            titleSize: 16,
            foregroundColor: Colors.grey.shade200,
            padding: const EdgeInsets.all(16),
            gradient: LinearGradient(
              colors: [
                Theme.of(context).primaryColor,
                Theme.of(context).primaryColor.withAlpha(60),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        const SizedBox(
          width: 16,
        ),
        // register button
        Expanded(
          child: RoundedButton(
            onPressed: !getUserPermission(
              context: context,
              featureType: FeatureType.tasks,
              permissionType: PermissionType.create,
            )
                ? () {
                    showSnackBar(
                      context: context,
                      message:
                          AppLocalizations.of(context)!.permission_no_action,
                      isErrorMessage: true,
                    );
                  }
                : () {
                    Navigator.pushNamed(
                      context,
                      RegisterTaskActionPage.routeName,
                      arguments: task,
                    );
                  },
            icon: Icons.check_circle_outline,
            iconSize: 40,
            title: AppLocalizations.of(context)!.task_action_register,
            titleSize: 16,
            foregroundColor: Colors.grey.shade200,
            padding: const EdgeInsets.all(16),
            gradient: LinearGradient(
              colors: [
                Colors.blue.shade700,
                Colors.blue.shade700.withAlpha(60),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ],
    );
  }
}
