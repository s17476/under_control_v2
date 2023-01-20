import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../core/utils/bloc_message.dart';
import '../../core/utils/show_snack_bar.dart';
import '../presentation/blocs/task_templates_management/task_templates_management_bloc.dart';

class TemplateListener extends StatelessWidget {
  const TemplateListener({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocListener<TaskTemplatesManagementBloc,
        TaskTemplatesManagementState>(
      listener: (context, state) {
        if (state is TaskTemplatesManagementSuccessState) {
          String message = '';
          bool error = false;
          switch (state.message) {
            case BlocMessage.added:
              message = AppLocalizations.of(context)!.task_templates_msg_added;
              break;
            case BlocMessage.notAdded:
              message =
                  AppLocalizations.of(context)!.task_templates_msg_not_added;
              error = true;
              break;
            case BlocMessage.deleted:
              message =
                  AppLocalizations.of(context)!.task_templates_msg_deleted;
              break;
            case BlocMessage.notDeleted:
              message =
                  AppLocalizations.of(context)!.task_templates_msg_not_deleted;
              error = true;
              break;
            case BlocMessage.updated:
              message =
                  AppLocalizations.of(context)!.task_templates_msg_updated;
              break;
            case BlocMessage.notUpdated:
              message =
                  AppLocalizations.of(context)!.task_templates_msg_not_updated;
              error = true;
              break;
            default:
              message = '';
          }
          if (message.isNotEmpty) {
            showSnackBar(
              context: context,
              message: message,
              isErrorMessage: error,
            );
          }
        }
      },
      child: child,
    );
  }
}
