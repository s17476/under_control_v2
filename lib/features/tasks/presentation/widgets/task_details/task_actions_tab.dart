import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:under_control_v2/features/tasks/presentation/pages/register_task_action_page.dart';

import '../../../../core/presentation/widgets/rounded_button.dart';
import '../../../../core/utils/get_user_premission.dart';
import '../../../../core/utils/premission.dart';
import '../../../../core/utils/show_snack_bar.dart';
import '../../../../groups/domain/entities/feature.dart';
import '../../../domain/entities/task/task.dart';

class TaskActionsTab extends StatelessWidget {
  const TaskActionsTab({
    Key? key,
    required this.task,
  }) : super(key: key);

  final Task task;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // start button
              Expanded(
                child: RoundedButton(
                  onPressed: !getUserPremission(
                    context: context,
                    featureType: FeatureType.tasks,
                    premissionType: PremissionType.create,
                  )
                      ? () {
                          showSnackBar(
                            context: context,
                            message: AppLocalizations.of(context)!
                                .premission_no_action,
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
                  onPressed: !getUserPremission(
                    context: context,
                    featureType: FeatureType.tasks,
                    premissionType: PremissionType.create,
                  )
                      ? () {
                          showSnackBar(
                            context: context,
                            message: AppLocalizations.of(context)!
                                .premission_no_action,
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
          ),
        ),
      ],
    );
  }
}
