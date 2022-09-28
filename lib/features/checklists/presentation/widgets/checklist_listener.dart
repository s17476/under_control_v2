import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../core/utils/show_snack_bar.dart';
import '../blocs/checklist_management/checklist_management_bloc.dart';

class ChecklistListener extends StatelessWidget {
  const ChecklistListener({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocListener<ChecklistManagementBloc, ChecklistManagementState>(
      listener: (context, state) {
        if (state is ChecklistManagementSuccessState) {
          String message = '';
          bool error = false;
          switch (state.message) {
            case ChecklistMessage.checklistAdded:
              message = AppLocalizations.of(context)!.checklist_msg_added;
              break;
            case ChecklistMessage.checklistNotAdded:
              message = AppLocalizations.of(context)!.checklist_msg_not_added;
              error = true;
              break;
            case ChecklistMessage.checklistDeleted:
              message = AppLocalizations.of(context)!.checklist_msg_deleted;
              break;
            case ChecklistMessage.checklistNotDeleted:
              message = AppLocalizations.of(context)!.checklist_msg_not_deleted;
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
