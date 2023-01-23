import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:under_control_v2/features/tasks/domain/usecases/task_template/delete_task_template.dart';
import 'package:under_control_v2/features/tasks/presentation/blocs/task_templates_management/task_templates_management_bloc.dart';

import '../../assets/presentation/widgets/asset_status_dropdown_button.dart';
import '../../assets/utils/asset_status.dart';
import '../../core/presentation/widgets/glass_layer.dart';
import '../data/models/task/task_model.dart';
import '../domain/entities/task/task.dart';
import '../presentation/blocs/task_management/task_management_bloc.dart';
import '../presentation/blocs/task_templates/task_templates_bloc.dart';

Future<dynamic> showTaskTemplateDeleteDialog({
  required BuildContext context,
  required Task task,
}) {
  final formKey = GlobalKey<FormState>();
  String comment = '';
  String assetStatus = '';
  return showDialog(
    context: context,
    barrierColor: Colors.transparent,
    builder: (context) => StatefulBuilder(builder: (context, setInnerState) {
      return Material(
        color: Colors.transparent,
        child: GlassLayer(
          onDismiss: () => Navigator.pop(context),
          child: AlertDialog(
            actionsAlignment: MainAxisAlignment.spaceEvenly,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            title: Text(
              AppLocalizations.of(context)!.task_templates_delete_title,
            ),
            content: Text(
              AppLocalizations.of(context)!.task_templates_delete_question,
            ),
            actions: [
              TextButton(
                child: Text(
                  AppLocalizations.of(context)!.cancel,
                  style: TextStyle(
                    color: Theme.of(context).textTheme.headline1!.color,
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              TextButton(
                child: Text(
                  AppLocalizations.of(context)!.confirm,
                  style: const TextStyle(
                    color: Colors.amber,
                  ),
                ),
                onPressed: () {
                  context
                      .read<TaskTemplatesManagementBloc>()
                      .add(DeleteTaskTemplateEvent(task: task));
                  Navigator.pop(context, true);
                },
              ),
            ],
          ),
        ),
      );
    }),
  );
}
