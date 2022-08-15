import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:under_control_v2/features/checklists/data/models/checkpoint_model.dart';
import 'package:under_control_v2/features/checklists/domain/entities/checkpoint.dart';
import 'package:under_control_v2/features/checklists/presentation/widgets/add_checkpoint_bottom_modal_sheet.dart';
import 'package:under_control_v2/features/checklists/presentation/widgets/add_checkpoint_tile.dart';
import 'package:under_control_v2/features/checklists/presentation/widgets/checkpoint_tile.dart';
import 'package:under_control_v2/features/core/utils/show_snack_bar.dart';

import '../../../core/presentation/widgets/backward_text_button.dart';
import '../../../core/presentation/widgets/forward_text_button.dart';

class AddCheckpointsCard extends StatefulWidget {
  const AddCheckpointsCard({
    Key? key,
    required this.pageController,
    required this.checkpoints,
  }) : super(key: key);

  final PageController pageController;

  final List<CheckpointModel> checkpoints;

  @override
  State<AddCheckpointsCard> createState() => _AddCheckpointsCardState();
}

class _AddCheckpointsCardState extends State<AddCheckpointsCard> {
  List<Checkpoint> checkpoints = [];

  @override
  void initState() {
    checkpoints = widget.checkpoints;
    super.initState();
  }

  void saveCheckpoint(Checkpoint? oldCheckpoint, Checkpoint newCheckpoint) {
    if (checkpoints
        .map((e) => e.title.toLowerCase())
        .contains(newCheckpoint.title.trim().toLowerCase())) {
      showSnackBar(
        context: context,
        message: AppLocalizations.of(context)!.checklist_add_checkpoints_exists,
        isErrorMessage: true,
      );
    } else {
      if (oldCheckpoint != null) {
        setState(() {
          checkpoints.remove(oldCheckpoint);
          checkpoints.add(newCheckpoint);
        });
      } else {
        setState(() {
          checkpoints.add(newCheckpoint);
        });
      }
    }
  }

  void editCheckpoint(CheckpointModel checkpoint) {
    showAddCheckpointModalBottomSheet(
      context: context,
      onSave: saveCheckpoint,
      currentCheckpoint: checkpoint,
    );
  }

  void deleteCheckpoint(Checkpoint checkpoint) {
    setState(() {
      checkpoints.remove(checkpoint);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: ClipRRect(
          clipBehavior: Clip.antiAlias,
          borderRadius: BorderRadius.circular(20),
          child: Container(
            color: Theme.of(context).cardColor,
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
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
                                .checklist_add_checkpoints,
                            style: TextStyle(
                              fontSize: Theme.of(context)
                                  .textTheme
                                  .headline5!
                                  .fontSize,
                            ),
                          ),
                        ),
                        const Divider(
                          thickness: 1.5,
                          indent: 8,
                          endIndent: 8,
                        ),
                        ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: widget.checkpoints.length + 1,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            if (index >= widget.checkpoints.length) {
                              return AddCheckpointTile(
                                addCheckpoint: saveCheckpoint,
                              );
                            } else {
                              return CheckpointTile(
                                checkpoint: widget.checkpoints[index],
                                editCheckpoint: editCheckpoint,
                                deleteCheckpoint: deleteCheckpoint,
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                // bottom navigation
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      BackwardTextButton(
                        icon: Icons.arrow_back_ios_new,
                        color: Theme.of(context).textTheme.headline5!.color!,
                        label: AppLocalizations.of(context)!
                            .user_profile_add_user_personal_data_back,
                        function: () => widget.pageController.previousPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        ),
                      ),
                      ForwardTextButton(
                        color: Theme.of(context).textTheme.headline5!.color!,
                        label: AppLocalizations.of(context)!
                            .user_profile_add_user_next,
                        function: () => widget.pageController.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        ),
                        icon: Icons.arrow_forward_ios_outlined,
                      ),
                    ],
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
