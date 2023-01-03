import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../core/presentation/widgets/overlay_users_selection.dart';
import '../../../../core/utils/responsive_size.dart';
import '../../../data/models/task_action/user_action_model.dart';
import '../participants_list.dart';

class AddTaskActionAddParticipantsCard extends StatelessWidget
    with ResponsiveSize {
  const AddTaskActionAddParticipantsCard({
    Key? key,
    required this.toggleParticipantSelection,
    required this.updateParticipant,
    required this.toggleIsAddUserVisible,
    required this.participants,
    required this.isAddUsersVisible,
  }) : super(key: key);

  final Function(String) toggleParticipantSelection;
  final Function(UserActionModel) updateParticipant;
  final Function() toggleIsAddUserVisible;
  final List<UserActionModel> participants;
  final bool isAddUsersVisible;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SafeArea(
          child: Column(
            children: [
              Expanded(
                child: Column(
                  children: [
                    // title
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 12,
                        left: 8,
                        right: 8,
                      ),
                      child: Text(
                        AppLocalizations.of(context)!
                            .task_action_add_participants,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize:
                              Theme.of(context).textTheme.headline5!.fontSize,
                        ),
                      ),
                    ),
                    const Divider(
                      thickness: 1.5,
                    ),
                    Expanded(
                      child: ParticipantsList(
                        participants: participants,
                        toggleParticipantSelection: toggleParticipantSelection,
                        updateParticipant: updateParticipant,
                        isEnabled: true,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 58,
          right: 16,
          child: FloatingActionButton.extended(
            onPressed: () {
              // _resetSelectedUser();
              toggleIsAddUserVisible();
            },
            label: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.person_add),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  AppLocalizations.of(context)!.task_assign_users,
                ),
              ],
            ),
          ),
        ),
        if (isAddUsersVisible)
          OverlayUsersSelection(
            assignedUsers: participants.map((p) => p.userId).toList(),
            toggleUserSelection: toggleParticipantSelection,
            onDismiss: toggleIsAddUserVisible,
          ),
      ],
    );
  }
}
