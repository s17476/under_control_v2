import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../core/utils/bloc_message.dart';
import '../../../core/utils/show_snack_bar.dart';
import '../blocs/asset_category_management/asset_category_management_bloc.dart';

class AssetCategoryManagementBlocListener extends StatelessWidget {
  const AssetCategoryManagementBlocListener({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocListener<AssetCategoryManagementBloc,
        AssetCategoryManagementState>(
      listener: (context, state) {
        if (state is AssetCategoryManagementSuccessState ||
            state is AssetCategoryManagementErrorState) {
          String message = '';
          bool error = false;
          switch (state.message) {
            case BlocMessage.added:
              message = AppLocalizations.of(context)!.item_category_msg_added;
              break;
            case BlocMessage.notAdded:
              message =
                  AppLocalizations.of(context)!.item_category_msg_not_added;
              error = true;
              break;
            case BlocMessage.deleted:
              message = AppLocalizations.of(context)!.item_category_msg_deleted;
              break;
            case BlocMessage.notDeleted:
              message =
                  AppLocalizations.of(context)!.item_category_msg_not_deleted;
              error = true;
              break;
            case BlocMessage.updated:
              message = AppLocalizations.of(context)!.item_category_msg_updated;
              break;
            case BlocMessage.notUpdated:
              message =
                  AppLocalizations.of(context)!.item_category_msg_not_updated;
              error = true;
              break;
            case BlocMessage.inUse:
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
