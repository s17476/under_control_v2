import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

import '../../../../company_profile/presentation/blocs/company_profile/company_profile_bloc.dart';
import '../../../../core/presentation/widgets/icon_title_row.dart';
import '../../../../core/presentation/widgets/user_list_tile.dart';
import '../../../../user_profile/domain/entities/user_profile.dart';
import '../../../domain/entities/instruction.dart';

class InstructionHistory extends StatefulWidget {
  const InstructionHistory({
    Key? key,
    required this.instruction,
    required this.showUserInfoCard,
  }) : super(key: key);

  final Instruction instruction;

  final Function(UserProfile) showUserInfoCard;

  @override
  State<InstructionHistory> createState() => _InstructionHistoryState();
}

class _InstructionHistoryState extends State<InstructionHistory> {
  bool _isExpanded = false;
  final _dateFormat = DateFormat('dd-MM-yyyy');
  final _timeFormat = DateFormat('HH:mm');

  void toggleExpanded() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // title
        InkWell(
          onTap: toggleExpanded,
          child: Padding(
            padding: const EdgeInsets.only(
              top: 8,
              bottom: 8,
              left: 4,
              right: 4,
            ),
            child: Row(
              children: [
                Expanded(
                  child: IconTitleRow(
                    icon: Icons.history,
                    iconColor: Colors.white,
                    iconBackground: Colors.black,
                    title: AppLocalizations.of(context)!.instruction_history,
                  ),
                ),
                Icon(
                  _isExpanded
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                ),
              ],
            ),
          ),
        ),
        // history actions list
        AnimatedSize(
          duration: const Duration(milliseconds: 300),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 8),
            height: _isExpanded ? null : 0,
            child: BlocBuilder<CompanyProfileBloc, CompanyProfileState>(
              builder: (context, state) {
                if (state is CompanyProfileLoaded) {
                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: widget.instruction.lastEdited.length,
                    itemBuilder: (context, index) {
                      final user = state.getUserById(
                          widget.instruction.lastEdited[index].userId);
                      if (user != null) {
                        return InkWell(
                          onTap: () => widget.showUserInfoCard(user),
                          child: Row(
                            children: [
                              Expanded(
                                child: AbsorbPointer(
                                  child: UserListTile(
                                    user: user,
                                    onTap: (_) {},
                                  ),
                                ),
                              ),
                              Column(
                                children: [
                                  Text(
                                    index == 0
                                        ? AppLocalizations.of(context)!.created
                                        : AppLocalizations.of(context)!.edited,
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
                                  ),
                                  Text(
                                    _timeFormat.format(
                                      widget.instruction.lastEdited[index]
                                          .dateTime,
                                    ),
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
                                  ),
                                  Text(
                                    _dateFormat.format(
                                      widget.instruction.lastEdited[index]
                                          .dateTime,
                                    ),
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      }
                      return const SizedBox();
                    },
                  );
                }
                return const CircularProgressIndicator();
              },
            ),
          ),
        ),
      ],
    );
  }
}
