import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../core/utils/bloc_message.dart';
import '../../core/utils/show_snack_bar.dart';
import '../presentation/blocs/work_order_management/work_order_management_bloc.dart';

void workOrderManagementBlocListener(
    BuildContext context, WorkOrderManagementState state) {
  if (state is WorkOrderManagementSuccessState ||
      state is WorkOrderManagementErrorState) {
    String message = '';
    switch (state.message) {
      case BlocMessage.updated:
        message = AppLocalizations.of(context)!.work_order_msg_updated;
        break;

      case BlocMessage.notUpdated:
        message = AppLocalizations.of(context)!.work_order_msg_not_updated;
        break;
      case BlocMessage.added:
        message = AppLocalizations.of(context)!.work_order_msg_added;
        break;
      case BlocMessage.notAdded:
        message = AppLocalizations.of(context)!.work_order_msg_not_added;
        break;
      case BlocMessage.deleted:
        message = AppLocalizations.of(context)!.work_order_msg_deleted;
        break;
      case BlocMessage.notDeleted:
        message = AppLocalizations.of(context)!.work_order_msg_not_deleted;
        break;
      default:
        message = '';
        break;
    }
    if (message.isNotEmpty) {
      showSnackBar(
        context: context,
        message: message,
        isErrorMessage: state.error,
      );
    }
  }
}
