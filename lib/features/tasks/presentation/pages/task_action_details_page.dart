import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

import '../../../company_profile/presentation/blocs/company_profile/company_profile_bloc.dart';
import '../../../core/presentation/widgets/icon_title_row.dart';
import '../../../core/presentation/widgets/user_info_card.dart';
import '../../../user_profile/domain/entities/user_profile.dart';
import '../../data/models/task_action/task_action_model.dart';
import '../../data/models/task_action/user_action_model.dart';
import '../blocs/task_action/task_action_bloc.dart';
import '../widgets/participants_list.dart';
import '../widgets/work_request_details/images_tab.dart';

class TaskActionDetailsPage extends StatefulWidget {
  const TaskActionDetailsPage({super.key});

  static const routeName = '/task-action/details';

  @override
  State<TaskActionDetailsPage> createState() => _TaskActionDetailsPageState();
}

class _TaskActionDetailsPageState extends State<TaskActionDetailsPage> {
  TaskActionModel? _taskAction;

  UserProfile? _selectedUser;
  bool _isUserInfoCardVisible = false;

  void _showUserInfoCard(UserProfile selectedUser) {
    _selectedUser = selectedUser;
    setState(() {
      _isUserInfoCardVisible = true;
    });
  }

  void _hideUserInfoCard() {
    _selectedUser = null;
    setState(() {
      _isUserInfoCardVisible = false;
    });
  }

  @override
  void didChangeDependencies() {
    final taskActionId = (ModalRoute.of(context)?.settings.arguments as String);
    final actionsState = context.watch<TaskActionBloc>().state;
    if (actionsState is TaskActionLoadedState) {
      final taskAction = actionsState.getTaskActionById(taskActionId);
      if (taskAction != null) {
        _taskAction = TaskActionModel.fromTaskAction(taskAction);
      }
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final dateTimeFormat = DateFormat('dd-MM-yyyy HH:mm');
    final dateFormat = DateFormat('dd-MM-yyyy');
    final timeFormat = DateFormat('HH:mm');
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.task_action_details),
      ),
      body: _taskAction == null
          ? Center(
              child: Text(AppLocalizations.of(context)!.server_error),
            )
          : Stack(
              children: [
                SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // description
                        ActionDescription(description: _taskAction!.comment),
                        const Divider(
                          thickness: 1.5,
                        ),
                        ActionDuration(
                          dateTimeFormat: dateTimeFormat,
                          taskAction: _taskAction,
                        ),
                        const Divider(
                          thickness: 1.5,
                        ),
                        Participants(
                          dateTimeFormat: dateTimeFormat,
                          dateFormat: dateFormat,
                          timeFormat: timeFormat,
                          participants: _taskAction!.usersActions,
                          hideUserInfoCard: _hideUserInfoCard,
                          showUserInfoCard: _showUserInfoCard,
                          isUserInfoCardVisible: _isUserInfoCardVisible,
                        ),
                        // images
                        if (_taskAction!.images.isNotEmpty) ...[
                          const Divider(
                            thickness: 1.5,
                          ),
                          ActionImages(taskAction: _taskAction!),
                        ],
                        // materials
                        if (_taskAction!.sparePartsItems.isNotEmpty) ...[
                          const Divider(
                            thickness: 1.5,
                          ),
                          // ActionImages(taskAction: _taskAction!),
                        ],
                      ],
                    ),
                  ),
                ),
                // user info card
                if (_isUserInfoCardVisible)
                  UserInfoCard(
                    onDismiss: _hideUserInfoCard,
                    user: _selectedUser!,
                  ),
              ],
            ),
    );
  }
}

class ActionImages extends StatelessWidget {
  const ActionImages({
    Key? key,
    required this.taskAction,
  }) : super(key: key);

  final TaskActionModel taskAction;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(
            top: 8,
            left: 8,
            right: 8,
          ),
          child: IconTitleRow(
            icon: Icons.image,
            iconColor: Colors.white,
            iconBackground: Colors.black,
            title: AppLocalizations.of(context)!.asset_add_images_added,
          ),
        ),
        ImagesTab(
          images: taskAction.images,
          isScrollable: false,
        ),
      ],
    );
  }
}

class Participants extends StatelessWidget {
  const Participants({
    Key? key,
    required this.dateTimeFormat,
    required this.dateFormat,
    required this.timeFormat,
    required this.participants,
    required this.isUserInfoCardVisible,
    required this.showUserInfoCard,
    required this.hideUserInfoCard,
  }) : super(key: key);

  final DateFormat dateTimeFormat;
  final DateFormat dateFormat;
  final DateFormat timeFormat;
  final List<UserActionModel> participants;
  final bool isUserInfoCardVisible;
  final Function(UserProfile) showUserInfoCard;
  final Function() hideUserInfoCard;

  void _toggleUserInfoCardVisibility(BuildContext context, String userId) {
    if (isUserInfoCardVisible) {
      hideUserInfoCard();
    } else {
      final companyState = context.read<CompanyProfileBloc>().state;
      if (companyState is CompanyProfileLoaded) {
        final user = companyState.getUserById(userId);
        if (user != null) {
          showUserInfoCard(user);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          IconTitleRow(
            icon: Icons.group,
            iconColor: Colors.white,
            iconBackground: Colors.black,
            title: AppLocalizations.of(context)!.task_action_participants,
          ),
          const SizedBox(
            height: 16,
          ),
          ParticipantsList(
            participants: participants,
            toggleParticipantSelection: (userId) =>
                _toggleUserInfoCardVisibility(context, userId),
            updateParticipant: (_) {},
            isEnabled: false,
            isExtendedTimeInfo: true,
            showTotalTime: false,
          ),
        ],
      ),
    );
  }
}

class ActionDuration extends StatelessWidget {
  const ActionDuration({
    Key? key,
    required this.dateTimeFormat,
    required this.taskAction,
  }) : super(key: key);

  final DateFormat dateTimeFormat;
  final TaskActionModel? taskAction;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          IconTitleRow(
            icon: Icons.timer_outlined,
            iconColor: Colors.white,
            iconBackground: Colors.black,
            title: AppLocalizations.of(context)!.task_action_duration,
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            children: [
              Expanded(
                child: IconTitleRow(
                  icon: Icons.play_arrow,
                  iconColor: Colors.white,
                  iconBackground: Theme.of(context).primaryColor,
                  title: AppLocalizations.of(context)!.from,
                ),
              ),
              Text(dateTimeFormat.format(taskAction!.startTime)),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            children: [
              Expanded(
                child: IconTitleRow(
                  icon: Icons.stop,
                  iconColor: Colors.white,
                  iconBackground: Theme.of(context).primaryColor,
                  title: AppLocalizations.of(context)!.to,
                ),
              ),
              Text(dateTimeFormat.format(taskAction!.stopTime)),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            children: [
              Expanded(
                child: IconTitleRow(
                  icon: Icons.timer_outlined,
                  iconColor: Colors.white,
                  iconBackground: Theme.of(context).primaryColor,
                  title: AppLocalizations.of(context)!.total_time,
                ),
              ),
              Text(taskAction!.getTotalDuration),
            ],
          ),
        ],
      ),
    );
  }
}

class ActionDescription extends StatelessWidget {
  const ActionDescription({
    Key? key,
    required this.description,
  }) : super(key: key);

  final String description;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconTitleRow(
            icon: Icons.info_outline,
            iconColor: Colors.white,
            iconBackground: Colors.black,
            title: AppLocalizations.of(context)!.description,
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 8,
              left: 8,
              right: 8,
            ),
            child: Text(
              description,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
