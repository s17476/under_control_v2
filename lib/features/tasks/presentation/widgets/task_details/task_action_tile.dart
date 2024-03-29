import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:under_control_v2/features/tasks/presentation/pages/task_action_details_page.dart';

import '../../../../company_profile/presentation/blocs/company_profile/company_profile_bloc.dart';
import '../../../../core/presentation/widgets/cached_user_avatar.dart';
import '../../../data/models/task_action/task_action_model.dart';
import '../../../domain/entities/task_action/task_action.dart';
import '../../../domain/entities/task_action/user_action.dart';

class TaskActionTile extends StatelessWidget {
  const TaskActionTile({
    Key? key,
    required this.taskAction,
  }) : super(key: key);

  final TaskAction taskAction;

  @override
  Widget build(BuildContext context) {
    final dateTimeFormat = DateFormat('dd-MM-yyyy HH:mm');
    final dateFormat = DateFormat('dd-MM-yyyy');
    final timeFormat = DateFormat('HH:mm');
    final isSameDate = dateFormat.format(taskAction.startTime) ==
        dateFormat.format(taskAction.stopTime);
    final captionStyle = Theme.of(context).textTheme.bodySmall;
    return Container(
      color: Theme.of(context).cardColor,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => Navigator.pushNamed(
            context,
            TaskActionDetailsPage.routeName,
            arguments: taskAction.id,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (isSameDate)
                  SameDateRow(
                    dateFormat: dateFormat,
                    taskAction: taskAction,
                    captionStyle: captionStyle!,
                    timeFormat: timeFormat,
                  ),
                if (!isSameDate)
                  DifferentDateRow(
                    dateTimeFormat: dateTimeFormat,
                    taskAction: taskAction,
                    captionStyle: captionStyle!,
                  ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 4.0,
                    vertical: 4,
                  ),
                  child: Text(
                    taskAction.comment,
                    style: const TextStyle(fontSize: 16),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 4.0,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          '${AppLocalizations.of(context)!.total_time}: ${TaskActionModel.fromTaskAction(taskAction).getTotalDuration}',
                          style: captionStyle!.copyWith(fontSize: 14),
                        ),
                      ),
                      if (taskAction.sparePartsItems.isNotEmpty) ...[
                        Icon(
                          Icons.api,
                          size: 22,
                          color: captionStyle.color,
                        ),
                        const SizedBox(
                          width: 2,
                        ),
                      ],
                      if (taskAction.addedPartsAssets.isNotEmpty) ...[
                        Icon(
                          Icons.precision_manufacturing,
                          size: 22,
                          color: captionStyle.color,
                        ),
                        const SizedBox(
                          width: 2,
                        ),
                      ],
                      if (taskAction.images.isNotEmpty) ...[
                        Icon(
                          Icons.image,
                          size: 22,
                          color: captionStyle.color,
                        ),
                        const SizedBox(
                          width: 2,
                        ),
                      ],
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 4,
                    vertical: 4,
                  ),
                  child: Row(
                    children: [
                      Text(
                        AppLocalizations.of(context)!.task_action_participants,
                        style: captionStyle,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      const Expanded(
                        child: Divider(
                          thickness: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 2,
                    left: 6,
                    right: 6,
                  ),
                  child: ParticipantsAvatars(
                    participants: taskAction.usersActions,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ParticipantsAvatars extends StatelessWidget {
  const ParticipantsAvatars({
    Key? key,
    required this.participants,
  }) : super(key: key);

  final List<UserAction> participants;

  final avatarSize = 30.0;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CompanyProfileBloc, CompanyProfileState>(
      builder: (context, state) {
        if (state is CompanyProfileLoaded) {
          List<Widget> avatars = [];
          for (var participant in participants) {
            final user = state.getUserById(participant.userId);
            if (user != null) {
              final avatar = Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CachedUserAvatar(
                    size: avatarSize,
                    imageUrl: user.avatarUrl,
                  ),
                ],
              );
              avatars.add(avatar);
            }
          }
          return Wrap(
            spacing: 8,
            runSpacing: 4,
            children: avatars,
          );
        }
        return const CircularProgressIndicator();
      },
    );
  }
}

class SameDateRow extends StatelessWidget {
  const SameDateRow({
    Key? key,
    required this.dateFormat,
    required this.taskAction,
    required this.captionStyle,
    required this.timeFormat,
  }) : super(key: key);

  final DateFormat dateFormat;
  final TaskAction taskAction;
  final TextStyle captionStyle;
  final DateFormat timeFormat;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(
          width: 4,
        ),
        Text(
          dateFormat.format(taskAction.startTime),
          style: captionStyle,
        ),
        const SizedBox(width: 4),
        Icon(
          Icons.play_arrow,
          size: 16,
          color: captionStyle.color,
        ),
        Text(
          timeFormat.format(taskAction.startTime),
          style: captionStyle,
        ),
        const SizedBox(width: 4),
        Icon(
          Icons.stop,
          size: 16,
          color: captionStyle.color,
        ),
        Text(
          timeFormat.format(taskAction.stopTime),
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }
}

class DifferentDateRow extends StatelessWidget {
  const DifferentDateRow({
    Key? key,
    required this.dateTimeFormat,
    required this.taskAction,
    required this.captionStyle,
  }) : super(key: key);

  final DateFormat dateTimeFormat;
  final TaskAction taskAction;
  final TextStyle captionStyle;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.play_arrow,
          size: 16,
          color: captionStyle.color,
        ),
        Text(
          dateTimeFormat.format(taskAction.startTime),
          style: captionStyle,
        ),
        const SizedBox(width: 4),
        Icon(
          Icons.stop,
          size: 16,
          color: captionStyle.color,
        ),
        Text(
          dateTimeFormat.format(taskAction.stopTime),
          style: captionStyle,
        ),
      ],
    );
  }
}
