import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../core/utils/show_snack_bar.dart';
import '../blocs/instruction_category_management/instruction_category_management_bloc.dart';

class InstructionCategoryManagementBlocListener extends StatelessWidget {
  const InstructionCategoryManagementBlocListener({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocListener<InstructionCategoryManagementBloc,
        InstructionCategoryManagementState>(
      listener: (context, state) {
        if (state is InstructionCategoryManagementSuccessState ||
            state is InstructionCategoryManagementErrorState) {
          String message = '';
          bool error = false;
          switch (state.message) {
            case InstructionCategoryMessage.itemCategoryAdded:
              message = AppLocalizations.of(context)!.item_category_msg_added;
              break;
            case InstructionCategoryMessage.itemCategoryNotAdded:
              message =
                  AppLocalizations.of(context)!.item_category_msg_not_added;
              error = true;
              break;
            case InstructionCategoryMessage.itemCategoryDeleted:
              message = AppLocalizations.of(context)!.item_category_msg_deleted;
              break;
            case InstructionCategoryMessage.itemCategoryNotDeleted:
              message =
                  AppLocalizations.of(context)!.item_category_msg_not_deleted;
              error = true;
              break;
            case InstructionCategoryMessage.itemCategoryUpdated:
              message = AppLocalizations.of(context)!.item_category_msg_updated;
              break;
            case InstructionCategoryMessage.itemCategoryNotUpdated:
              message =
                  AppLocalizations.of(context)!.item_category_msg_not_updated;
              error = true;
              break;
            case InstructionCategoryMessage.itemCategoryNotEmpty:
              message =
                  AppLocalizations.of(context)!.item_category_msg_not_empty;
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
