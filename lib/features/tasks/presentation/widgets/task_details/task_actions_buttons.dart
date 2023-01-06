import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:under_control_v2/features/tasks/utils/show_task_complete_dialog.dart';

import '../../../../core/presentation/widgets/icon_title_row.dart';
import '../../../../core/presentation/widgets/rounded_button.dart';
import '../../../../core/utils/get_user_permission.dart';
import '../../../../core/utils/permission.dart';
import '../../../../core/utils/show_snack_bar.dart';
import '../../../../groups/domain/entities/feature.dart';
import '../../../domain/entities/task/task.dart';
import '../../blocs/task_action/task_action_bloc.dart';
import '../../pages/register_task_action_page.dart';

class TaskActionsButtons extends StatefulWidget {
  const TaskActionsButtons({
    Key? key,
    required this.task,
  }) : super(key: key);

  final Task task;

  @override
  State<TaskActionsButtons> createState() => _TaskActionsButtonsState();
}

class _TaskActionsButtonsState extends State<TaskActionsButtons> {
  bool _canContinues = false;
  bool _canFinishes = false;
  bool _isLoading = true;
  bool _hasActions = false;

  void _showContinueInfo() {
    showSnackBar(
      context: context,
      message: AppLocalizations.of(context)!.asset_replaced_info,
      isErrorMessage: true,
    );
  }

  @override
  void didChangeDependencies() {
    final actionsState = context.watch<TaskActionBloc>().state;
    if (actionsState is TaskActionLoadedState) {
      if (actionsState.allActions.allTaskActions.isEmpty) {
        _isLoading = false;
        _hasActions = false;
      } else {
        _isLoading = !actionsState.allActions.allTaskActions
            .any((action) => action.taskId == widget.task.id);
        _canFinishes = !_isLoading;
        _hasActions = !_isLoading;
      }
      _canContinues = !actionsState.allActions.allTaskActions
          .any((action) => action.replacementAssetId.isNotEmpty);
    } else {
      _canContinues = false;
      _hasActions = false;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            // start button
            Expanded(
              child: RoundedButton(
                isLoading: _isLoading,
                onPressed: !_canContinues
                    ? _showContinueInfo
                    : !getUserPermission(
                        context: context,
                        featureType: FeatureType.tasks,
                        permissionType: PermissionType.create,
                      )
                        ? () {
                            showSnackBar(
                              context: context,
                              message: AppLocalizations.of(context)!
                                  .permission_no_action,
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
                  colors: _canContinues
                      ? [
                          Colors.amber.shade800,
                          Colors.amber.shade700.withAlpha(60),
                        ]
                      : [
                          Colors.grey.shade700,
                          Colors.grey.shade700.withAlpha(60),
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
                isLoading: _isLoading,
                onPressed: !_canContinues
                    ? _showContinueInfo
                    : !getUserPermission(
                        context: context,
                        featureType: FeatureType.tasks,
                        permissionType: PermissionType.create,
                      )
                        ? () {
                            showSnackBar(
                              context: context,
                              message: AppLocalizations.of(context)!
                                  .permission_no_action,
                              isErrorMessage: true,
                            );
                          }
                        : () {
                            Navigator.pushNamed(
                              context,
                              RegisterTaskActionPage.routeName,
                              arguments: widget.task,
                            );
                          },
                icon: Icons.edit_note,
                iconSize: 40,
                title: AppLocalizations.of(context)!.task_action_register,
                titleSize: 16,
                foregroundColor: Colors.grey.shade200,
                padding: const EdgeInsets.all(16),
                gradient: LinearGradient(
                  colors: _canContinues
                      ? [
                          Colors.blue.shade700,
                          Colors.blue.shade700.withAlpha(60),
                        ]
                      : [
                          Colors.grey.shade700,
                          Colors.grey.shade700.withAlpha(60),
                        ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 16,
        ),
        RoundedButton(
          axis: Axis.horizontal,
          isLoading: _isLoading,
          onPressed: !_hasActions
              ? () {}
              : !_canFinishes
                  ? _showContinueInfo
                  : !getUserPermission(
                      context: context,
                      featureType: FeatureType.tasks,
                      permissionType: PermissionType.create,
                    )
                      ? () {
                          showSnackBar(
                            context: context,
                            message: AppLocalizations.of(context)!
                                .permission_no_action,
                            isErrorMessage: true,
                          );
                        }
                      : () {
                          showTaskCompleteDialog(
                            context: context,
                            task: widget.task,
                          ).then((value) {
                            if (value is bool && value) {
                              Navigator.pop(context);
                            }
                          });
                        },
          icon: Icons.done_rounded,
          iconSize: 40,
          title: AppLocalizations.of(context)!.task_complete,
          titleSize: 20,
          foregroundColor: Colors.grey.shade200,
          padding: const EdgeInsets.all(16),
          gradient: LinearGradient(
            colors: _canFinishes
                ? [
                    Theme.of(context).primaryColor,
                    Theme.of(context).primaryColor.withAlpha(60),
                  ]
                : [
                    Colors.grey.shade700,
                    Colors.grey.shade700.withAlpha(60),
                  ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        if (!_canContinues) ...[
          const SizedBox(
            height: 16,
          ),
          IconTitleRow(
            icon: Icons.info_outline,
            iconColor: Colors.white,
            iconBackground: Theme.of(context).primaryColor,
            title: AppLocalizations.of(context)!.important,
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            AppLocalizations.of(context)!.asset_replaced_info,
            textAlign: TextAlign.justify,
          ),
        ],
      ],
    );
  }
}
