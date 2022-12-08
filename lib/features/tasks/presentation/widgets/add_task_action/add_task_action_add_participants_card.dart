import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

import 'package:under_control_v2/features/company_profile/presentation/blocs/company_profile/company_profile_bloc.dart';
import 'package:under_control_v2/features/core/presentation/widgets/cached_user_avatar.dart';
import 'package:under_control_v2/features/core/presentation/widgets/loading_widget.dart';
import 'package:under_control_v2/features/core/presentation/widgets/user_list_tile.dart';
import 'package:under_control_v2/features/tasks/data/models/task_action/user_action_model.dart';
import 'package:under_control_v2/features/user_profile/domain/entities/user_profile.dart';

import '../../../../core/presentation/widgets/overlay_groups_selection.dart';
import '../../../../core/presentation/widgets/overlay_users_selection.dart';
import '../../../../core/presentation/widgets/rounded_button.dart';
import '../../../../core/utils/responsive_size.dart';

class AddTaskActionAddParticipantsCard extends StatefulWidget
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
  State<AddTaskActionAddParticipantsCard> createState() =>
      _AddTaskActionAddParticipantsCardState();
}

class _AddTaskActionAddParticipantsCardState
    extends State<AddTaskActionAddParticipantsCard> {
  UserProfile? _selectedUser;

  void _selectUser(UserProfile user) {
    setState(() {
      _selectedUser = user;
    });
  }

  @override
  void didChangeDependencies() {
    if (_selectedUser != null) {
      final index = widget.participants
          .indexWhere((element) => element.userId == _selectedUser!.id);
      if (index < 0) {
        _selectedUser = null;
      }
    }
    super.didChangeDependencies();
  }

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
                      child:
                          BlocBuilder<CompanyProfileBloc, CompanyProfileState>(
                        builder: (context, state) {
                          if (state is CompanyProfileLoaded) {
                            return Column(
                              children: [
                                if (_selectedUser != null)
                                  SelectedUserBox(
                                    selectedUser: _selectedUser,
                                    participants: widget.participants,
                                    toggleParticipantSelection:
                                        widget.toggleParticipantSelection,
                                    updateParticipant: widget.updateParticipant,
                                  ),
                                ListView.builder(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  shrinkWrap: true,
                                  itemCount: widget.participants.length,
                                  itemBuilder: (context, index) {
                                    final user = state.getUserById(
                                        widget.participants[index].userId);
                                    if (user != null) {
                                      return UserListTile(
                                        user: user,
                                        onTap: _selectUser,
                                      );
                                    } else {
                                      return const SizedBox();
                                    }
                                  },
                                ),
                              ],
                            );
                          }
                          return const LoadingWidget();
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 4,
                      ),
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).primaryColor,
                        ),
                        onPressed: widget.toggleIsAddUserVisible,
                        icon: const Icon(Icons.person_add),
                        label: Text(
                          AppLocalizations.of(context)!.task_assign_users,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        if (widget.isAddUsersVisible)
          OverlayUsersSelection(
            assignedUsers: widget.participants.map((p) => p.userId).toList(),
            toggleUserSelection: widget.toggleParticipantSelection,
            onDismiss: widget.toggleIsAddUserVisible,
          ),
      ],
    );
  }
}

class SelectedUserBox extends StatelessWidget {
  const SelectedUserBox({
    Key? key,
    required this.selectedUser,
    required this.toggleParticipantSelection,
    required this.updateParticipant,
    required this.participants,
  }) : super(key: key);

  final UserProfile? selectedUser;
  final Function(String) toggleParticipantSelection;
  final Function(UserActionModel) updateParticipant;
  final List<UserActionModel> participants;

  @override
  Widget build(BuildContext context) {
    final timeFormat = DateFormat('HH:mm');
    final dateFormat = DateFormat('dd-MM-yyyy');
    final selectedParticipant = participants.firstWhere(
      (element) => element.userId == selectedUser!.id,
    );
    return AnimatedSize(
      duration: const Duration(milliseconds: 300),
      child: SizedBox(
        height: selectedUser != null ? null : 0,
        child: selectedUser != null
            ? Column(
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            CachedUserAvatar(
                              size: 90,
                              imageUrl: selectedUser!.avatarUrl,
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Text(
                              selectedUser!.firstName,
                              style: const TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Icon(
                                  Icons.play_arrow,
                                  size: 36,
                                ),
                                Column(
                                  children: [
                                    Text(
                                      timeFormat.format(
                                          selectedParticipant.startTime),
                                      style: const TextStyle(fontSize: 24),
                                    ),
                                    Text(
                                      dateFormat.format(
                                          selectedParticipant.startTime),
                                      style:
                                          Theme.of(context).textTheme.caption,
                                    ),
                                  ],
                                ),
                                RoundedButton(
                                  iconSize: 30,
                                  padding: const EdgeInsets.all(9),
                                  onPressed: () {},
                                  icon: Icons.timer_sharp,
                                  gradient: LinearGradient(colors: [
                                    Theme.of(context).primaryColor,
                                    Theme.of(context)
                                        .primaryColor
                                        .withAlpha(60),
                                  ]),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Icon(
                                  Icons.stop,
                                  size: 36,
                                ),
                                Column(
                                  children: [
                                    Text(
                                      timeFormat
                                          .format(selectedParticipant.stopTime),
                                      style: const TextStyle(fontSize: 24),
                                    ),
                                    Text(
                                      dateFormat
                                          .format(selectedParticipant.stopTime),
                                      style:
                                          Theme.of(context).textTheme.caption,
                                    ),
                                  ],
                                ),
                                RoundedButton(
                                  iconSize: 30,
                                  padding: const EdgeInsets.all(9),
                                  onPressed: () {},
                                  icon: Icons.timer_sharp,
                                  gradient: LinearGradient(colors: [
                                    Theme.of(context).primaryColor,
                                    Theme.of(context)
                                        .primaryColor
                                        .withAlpha(60),
                                  ]),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                    ],
                  ),
                  const Divider(
                    thickness: 1.5,
                    indent: 8,
                    endIndent: 8,
                  ),
                ],
              )
            : null,
      ),
    );
  }
}
