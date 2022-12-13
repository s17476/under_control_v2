import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

import '../../../../company_profile/presentation/blocs/company_profile/company_profile_bloc.dart';
import '../../../../core/presentation/widgets/cached_user_avatar.dart';
import '../../../../core/presentation/widgets/loading_widget.dart';
import '../../../../core/presentation/widgets/overlay_users_selection.dart';
import '../../../../core/presentation/widgets/rounded_button.dart';
import '../../../../core/presentation/widgets/user_list_tile.dart';
import '../../../../core/utils/duration_apis.dart';
import '../../../../core/utils/get_locale_type.dart';
import '../../../../core/utils/responsive_size.dart';
import '../../../../user_profile/domain/entities/user_profile.dart';
import '../../../data/models/task_action/user_action_model.dart';

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

  void _resetSelectedUser() {
    setState(() {
      _selectedUser = null;
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
                              mainAxisAlignment: widget.participants.isEmpty
                                  ? MainAxisAlignment.center
                                  : MainAxisAlignment.start,
                              children: [
                                // if (_selectedUser != null)
                                SelectedUserBox(
                                  selectedUser: _selectedUser,
                                  participants: widget.participants,
                                  toggleParticipantSelection:
                                      widget.toggleParticipantSelection,
                                  updateParticipant: widget.updateParticipant,
                                ),
                                if (widget.participants.isEmpty) ...[
                                  const Icon(
                                    Icons.person_add,
                                    size: 50,
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    AppLocalizations.of(context)!
                                        .task_action_add_participants_no_selected,
                                  ),
                                ],
                                if (widget.participants.isNotEmpty)
                                  ListView.builder(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    shrinkWrap: true,
                                    itemCount: widget.participants.length,
                                    itemBuilder: (context, index) {
                                      final user = state.getUserById(
                                        widget.participants[index].userId,
                                      );
                                      if (user != null) {
                                        return Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 4.0),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: UserListTile(
                                                  user: user,
                                                  onTap: _selectUser,
                                                ),
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  IconButton(
                                                    onPressed: widget
                                                                .participants
                                                                .length >
                                                            1
                                                        ? () {
                                                            if (_selectedUser !=
                                                                    null &&
                                                                _selectedUser!
                                                                        .id ==
                                                                    user.id) {
                                                              _resetSelectedUser();
                                                            }
                                                            widget
                                                                .toggleParticipantSelection(
                                                                    user.id);
                                                          }
                                                        : null,
                                                    icon: const Icon(
                                                        Icons.delete),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                      right: 8.0,
                                                      bottom: 4,
                                                    ),
                                                    child: Text(
                                                      widget.participants[index]
                                                          .totalTime
                                                          .toFormatedString(),
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .caption,
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
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
                        onPressed: () {
                          _resetSelectedUser();
                          widget.toggleIsAddUserVisible();
                        },
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

  void _pickStartDate(BuildContext context, UserActionModel participant) async {
    FocusScope.of(context).unfocus();
    DatePicker.showDateTimePicker(
      context,
      showTitleActions: true,
      // minTime: DateTime(2021, 1, 1),
      maxTime: participant.stopTime.subtract(const Duration(minutes: 5)),
      onConfirm: (date) {
        updateParticipant(
          participant.copyWith(
            startTime: date.subtract(
              Duration(seconds: date.second),
            ),
          ),
        );
      },
      currentTime: participant.startTime.isBefore(
              participant.stopTime.subtract(const Duration(minutes: 5)))
          ? participant.startTime
          : participant.stopTime.subtract(const Duration(minutes: 5)),
      locale: getLocaleType(context),
      theme: DatePickerTheme(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        // headerColor: Theme.of,
        itemStyle: Theme.of(context).textTheme.headline6!,
        cancelStyle: Theme.of(context).textTheme.headline6!,
        doneStyle: Theme.of(context).textTheme.headline6!.copyWith(
              color: Colors.amber,
            ),
        itemHeight: 40,
      ),
    );
  }

  void _pickStopDate(BuildContext context, UserActionModel participant) async {
    FocusScope.of(context).unfocus();
    DatePicker.showDateTimePicker(
      context,
      showTitleActions: true,
      // minTime: participant.startTime,
      maxTime: DateTime.now(),
      onConfirm: (date) {
        if (date.isBefore(participant.startTime)) {
          updateParticipant(
            participant.copyWith(
              stopTime: date.subtract(Duration(seconds: date.second)),
              startTime: date.subtract(
                Duration(minutes: 5, seconds: date.second),
              ),
            ),
          );
        } else {
          updateParticipant(participant.copyWith(
            stopTime: date.subtract(
              Duration(seconds: date.second),
            ),
          ));
        }
      },
      currentTime: participant.stopTime,
      locale: getLocaleType(context),
      theme: DatePickerTheme(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        // headerColor: Theme.of,
        itemStyle: Theme.of(context).textTheme.headline6!,
        cancelStyle: Theme.of(context).textTheme.headline6!,
        doneStyle: Theme.of(context).textTheme.headline6!.copyWith(
              color: Colors.amber,
            ),
        itemHeight: 40,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final timeFormat = DateFormat('HH:mm');
    final dateFormat = DateFormat('dd-MM-yyyy');
    UserActionModel? selectedParticipant;
    String totalTime = '';
    if (selectedUser != null) {
      selectedParticipant = participants.firstWhere(
        (element) => element.userId == selectedUser!.id,
      );
      totalTime = selectedParticipant.stopTime
          .difference(selectedParticipant.startTime)
          .toFormatedString();
    } else {
      selectedParticipant = null;
    }
    return AnimatedSize(
      duration: const Duration(milliseconds: 300),
      child: SizedBox(
        width: double.infinity,
        height: selectedParticipant != null ? null : 0,
        child: selectedParticipant != null
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
                        child: Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: 40,
                                    height: 30,
                                    child: FittedBox(
                                      child: Text(
                                        AppLocalizations.of(context)!.from,
                                      ),
                                    ),
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
                                    onPressed: () => _pickStartDate(
                                      context,
                                      selectedParticipant!,
                                    ),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: 40,
                                    height: 30,
                                    child: FittedBox(
                                      child: Text(
                                        AppLocalizations.of(context)!.to,
                                      ),
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        timeFormat.format(
                                            selectedParticipant.stopTime),
                                        style: const TextStyle(fontSize: 24),
                                      ),
                                      Text(
                                        dateFormat.format(
                                            selectedParticipant.stopTime),
                                        style:
                                            Theme.of(context).textTheme.caption,
                                      ),
                                    ],
                                  ),
                                  RoundedButton(
                                    iconSize: 30,
                                    padding: const EdgeInsets.all(9),
                                    onPressed: () => _pickStopDate(
                                      context,
                                      selectedParticipant!,
                                    ),
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
                      ),
                      // const SizedBox(
                      //   width: 8,
                      // ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      bottom: 8.0,
                      right: 8.0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        if (totalTime.isNotEmpty)
                          Text(
                            '${AppLocalizations.of(context)!.total_time}: $totalTime',
                          ),
                        if (totalTime.isEmpty)
                          Text(
                            AppLocalizations.of(context)!.total_time_negative,
                            style: TextStyle(
                              color: Theme.of(context).highlightColor,
                            ),
                          ),
                      ],
                    ),
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
