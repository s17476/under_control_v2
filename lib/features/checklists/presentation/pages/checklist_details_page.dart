import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../core/presentation/widgets/icon_title_row.dart';
import '../../../core/utils/choice.dart';
import '../../../core/utils/show_snack_bar.dart';
import '../../domain/entities/checklist.dart';
import '../blocs/checklist/checklist_bloc.dart';
import '../blocs/checklist_management/checklist_management_bloc.dart';
import '../../utils/show_checklist_delete_dialog.dart';
import 'add_checklist_page.dart';

class ChecklistDetailsPage extends StatefulWidget {
  const ChecklistDetailsPage({Key? key}) : super(key: key);

  static const routeName = '/checklists/checklist-details';

  @override
  State<ChecklistDetailsPage> createState() => _ChecklistDetailsPageState();
}

class _ChecklistDetailsPageState extends State<ChecklistDetailsPage> {
  // current checklist
  late Checklist _checklist;
  // popup menu items
  List<Choice> _choices = [];

  @override
  void didChangeDependencies() {
    // gets checklist data
    final checklistId =
        (ModalRoute.of(context)!.settings.arguments as Checklist).id;
    final checklistState = context.watch<ChecklistBloc>().state;
    if (checklistState is ChecklistLoadedState) {
      final index = checklistState.allChecklists.allChecklists
          .indexWhere((element) => element.id == checklistId);
      if (index >= 0) {
        setState(() {
          _checklist = checklistState.allChecklists.allChecklists[index];
        });
      }
    }

    // popup menu items list
    setState(() {
      _choices = [
        // edit checklist
        Choice(
          title: AppLocalizations.of(context)!.edit,
          icon: Icons.edit,
          onTap: () => Navigator.pushNamed(
            context,
            AddChecklistPage.routeName,
            arguments: _checklist,
          ),
        ),
        // delete checklist
        Choice(
          title: AppLocalizations.of(context)!.delete,
          icon: Icons.delete,
          onTap: () async {
            final result = await showChecklistDeleteDialog(
              context: context,
              checklist: _checklist,
            );
            if (result != null && result && mounted) {
              Navigator.pop(context);
            }
          },
        ),
      ];
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ChecklistManagementBloc, ChecklistManagementState>(
      listener: (context, state) {
        if (state is ChecklistManagementSuccessState) {
          String message = '';
          bool error = false;
          switch (state.message) {
            case ChecklistMessage.checklistUpdated:
              message = AppLocalizations.of(context)!.checklist_msg_updated;
              break;
            case ChecklistMessage.checklistNotUpdated:
              message = AppLocalizations.of(context)!.checklist_msg_not_updated;
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
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.checklist_details_title),
          centerTitle: true,
          actions: [
            // popup menu
            if (_choices.isNotEmpty)
              PopupMenuButton<Choice>(
                onSelected: (Choice choice) {
                  choice.onTap();
                },
                itemBuilder: (BuildContext context) {
                  return _choices.map((Choice choice) {
                    return PopupMenuItem<Choice>(
                      value: choice,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(choice.icon),
                          const SizedBox(
                            width: 4,
                          ),
                          Text(
                            choice.title,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    );
                  }).toList();
                },
              ),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // name
                Padding(
                  padding: const EdgeInsets.only(left: 4, top: 8),
                  child: IconTitleRow(
                    icon: Icons.checklist,
                    iconColor: Colors.white,
                    iconBackground: Colors.black,
                    title: AppLocalizations.of(context)!.checklist_details_data,
                    iconSize: 16,
                  ),
                ),
                // name
                Padding(
                  padding: const EdgeInsets.only(
                    top: 8,
                    left: 8,
                    right: 8,
                  ),
                  child: Text(
                    _checklist.title,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade300,
                    ),
                  ),
                ),
                // description
                if (_checklist.description.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 8,
                      left: 8,
                      right: 8,
                    ),
                    child: Text(
                      _checklist.description,
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Divider(
                    thickness: 1.5,
                  ),
                ),
                // checkpoints
                Padding(
                  padding: const EdgeInsets.only(left: 4),
                  child: IconTitleRow(
                    icon: Icons.check,
                    iconColor: Colors.white,
                    iconBackground: Colors.black,
                    title: AppLocalizations.of(context)!
                        .checklist_add_checkpoints_title,
                    iconSize: 16,
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: _checklist.allCheckpoints.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(
                        left: 4,
                        right: 4,
                        bottom: 8.0,
                      ),
                      child: IconTitleRow(
                        icon: Icons.check_circle_outline_outlined,
                        iconColor: Colors.grey.shade200,
                        iconBackground: Theme.of(context).primaryColor,
                        title: _checklist.allCheckpoints[index].title,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
