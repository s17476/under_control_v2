import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:under_control_v2/features/checklists/domain/entities/checklist.dart';
import 'package:under_control_v2/features/checklists/presentation/pages/add_checklist_page.dart';
import 'package:under_control_v2/features/checklists/presentation/widgets/checkpoint_tile.dart';
import 'package:under_control_v2/features/checklists/presentation/widgets/show_checklist_delete_dialog.dart';
import 'package:under_control_v2/features/core/utils/choice.dart';
import 'package:under_control_v2/features/user_profile/domain/entities/user_profile.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../core/utils/show_snack_bar.dart';
import '../../../user_profile/presentation/blocs/user_profile/user_profile_bloc.dart';
import '../blocs/checklist/checklist_bloc.dart';
import '../blocs/checklist_management/checklist_management_bloc.dart';

class ChecklistDetailsPage extends StatefulWidget {
  const ChecklistDetailsPage({Key? key}) : super(key: key);

  static const routeName = '/checklists/checklist-details';

  @override
  State<ChecklistDetailsPage> createState() => _ChecklistDetailsPageState();
}

class _ChecklistDetailsPageState extends State<ChecklistDetailsPage> {
  UserProfile? userProfile;

  bool isAdministrator = false;

  late Checklist checklist;

  List<Choice> choices = [];

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
          checklist = checklistState.allChecklists.allChecklists[index];
        });
      }
    }
    // gets current user
    final currentUserProfile =
        (context.read<UserProfileBloc>().state as Approved).userProfile;
    isAdministrator = currentUserProfile.administrator;

    // popup menu items list
    setState(() {
      choices = [
        // edit checklist
        Choice(
          title: AppLocalizations.of(context)!.edit,
          icon: Icons.edit,
          onTap: () => Navigator.pushNamed(
            context,
            AddChecklistPage.routeName,
            arguments: checklist,
          ),
        ),
        // delete checklist
        Choice(
          title: AppLocalizations.of(context)!.delete,
          icon: Icons.delete,
          onTap: () async {
            final result = await showChecklistDeleteDialog(
              context: context,
              checklist: checklist,
            );
            if (result != null && result) {
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
          switch (state.message) {
            case ChecklistMessage.checklistAdded:
              message = AppLocalizations.of(context)!.checklist_msg_added;
              break;
            case ChecklistMessage.checklistNotAdded:
              message = AppLocalizations.of(context)!.checklist_msg_not_added;
              break;
            case ChecklistMessage.checklistUpdated:
              message = AppLocalizations.of(context)!.checklist_msg_updated;
              break;
            case ChecklistMessage.checklistNotUpdated:
              message = AppLocalizations.of(context)!.checklist_msg_not_updated;
              break;
            case ChecklistMessage.checklistDeleted:
              message = AppLocalizations.of(context)!.checklist_msg_deleted;
              break;
            case ChecklistMessage.checklistNotDeleted:
              message = AppLocalizations.of(context)!.checklist_msg_not_deleted;
              break;
            default:
              message = '';
          }
          if (message.isNotEmpty) {
            showSnackBar(
              context: context,
              message: message,
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
            if (choices.isNotEmpty)
              PopupMenuButton<Choice>(
                onSelected: (Choice choice) {
                  choice.onTap();
                },
                itemBuilder: (BuildContext context) {
                  return choices.map((Choice choice) {
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
                // data
                Padding(
                  padding: const EdgeInsets.only(left: 4, top: 8),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.black,
                        ),
                        child: Icon(
                          Icons.group,
                          size: 20,
                          color: Colors.grey.shade300,
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        AppLocalizations.of(context)!.group_data,
                        maxLines: 2,
                        style: TextStyle(
                          color: Colors.grey.shade200,
                          fontSize: 16,
                        ),
                      ),
                    ],
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
                    checklist.title,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade300,
                    ),
                  ),
                ),
                // description
                if (checklist.description.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 8,
                      left: 8,
                      right: 8,
                    ),
                    child: Text(
                      checklist.description,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Divider(
                    thickness: 1.5,
                  ),
                ),
                // features
                Padding(
                  padding: const EdgeInsets.only(left: 4),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.black,
                        ),
                        child: Icon(
                          Icons.error,
                          size: 20,
                          color: Colors.grey.shade300,
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        AppLocalizations.of(context)!
                            .group_management_add_card_permissions,
                        style: TextStyle(
                          color: Colors.grey.shade200,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                for (var checkpoint in checklist.allCheckpoints)
                  CheckpointTile(checkpoint: checkpoint),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
