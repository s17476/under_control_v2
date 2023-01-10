import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../checklists/data/models/checkpoint_model.dart';
import '../../../../checklists/domain/entities/checklist.dart';
import '../../../../checklists/presentation/widgets/add_checkpoint_button.dart';
import '../../../../checklists/presentation/widgets/checkpoint_tile.dart';
import '../../../../checklists/utils/show_add_checkpoint_bottom_modal_sheet.dart';
import '../../../../core/utils/show_snack_bar.dart';
import 'overlay_checklist_selection.dart';

class AddTaskCheckpointsCard extends StatefulWidget {
  const AddTaskCheckpointsCard({
    Key? key,
    required this.checklist,
    required this.toggleAddChecklistVisibility,
    required this.isAddChecklistVisible,
  }) : super(key: key);

  final List<CheckpointModel> checklist;

  final Function() toggleAddChecklistVisibility;
  final bool isAddChecklistVisible;

  @override
  State<AddTaskCheckpointsCard> createState() => _AddTaskCheckpointsCardState();
}

class _AddTaskCheckpointsCardState extends State<AddTaskCheckpointsCard> {
  List<CheckpointModel> _checkpoints = [];

  void _saveCheckpoint(
      CheckpointModel? oldCheckpoint, CheckpointModel newCheckpoint) {
    if (_checkpoints
        .map((e) => e.title.toLowerCase())
        .contains(newCheckpoint.title.trim().toLowerCase())) {
      showSnackBar(
        context: context,
        message: AppLocalizations.of(context)!.checklist_add_checkpoints_exists,
        isErrorMessage: true,
      );
    } else {
      // edit checkpoint
      if (oldCheckpoint != null) {
        setState(() {
          _checkpoints.remove(oldCheckpoint);
          _checkpoints.add(newCheckpoint);
        });
        // add checkpoint
      } else {
        setState(() {
          _checkpoints.add(newCheckpoint);
        });
      }
    }
  }

  void _editCheckpoint(CheckpointModel checkpoint) {
    showAddCheckpointModalBottomSheet(
      context: context,
      onSave: _saveCheckpoint,
      currentCheckpoint: checkpoint,
    );
  }

  void _deleteCheckpoint(CheckpointModel checkpoint) {
    setState(() {
      _checkpoints.remove(checkpoint);
    });
  }

  void _addEntireChecklist(Checklist checklist) {
    final List<CheckpointModel> tmpChecklist = [];
    for (var check in checklist.allCheckpoints) {
      if (!widget.checklist.contains(check)) {
        tmpChecklist.add(check);
      }
    }
    if (tmpChecklist.isNotEmpty) {
      setState(() {
        widget.checklist.addAll(tmpChecklist);
      });
    }
  }

  void _toggleCheckpoint(CheckpointModel checkpoint) {
    if (widget.checklist.contains(checkpoint)) {
      setState(() {
        widget.checklist.remove(checkpoint);
      });
    } else {
      setState(() {
        widget.checklist.add(checkpoint);
      });
    }
  }

  @override
  void initState() {
    _checkpoints = widget.checklist;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SafeArea(
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
                            fontSize:
                                Theme.of(context).textTheme.headline5!.fontSize,
                          ),
                        ),
                      ),
                      const Divider(
                        thickness: 1.5,
                      ),
                      ReorderableListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return CheckpointTile(
                            key: ValueKey('$index'),
                            checkpoint: _checkpoints[index],
                            editCheckpoint: _editCheckpoint,
                            deleteCheckpoint: _deleteCheckpoint,
                            trailing: ReorderableDragStartListener(
                              index: index,
                              child: const Icon(
                                Icons.drag_handle,
                                size: 30,
                              ),
                            ),
                            index: index,
                          );
                        },
                        itemCount: _checkpoints.length,
                        onReorder: (int oldIndex, int newIndex) {
                          setState(() {
                            if (oldIndex < newIndex) {
                              newIndex -= 1;
                            }
                            final CheckpointModel item =
                                _checkpoints.removeAt(oldIndex);
                            _checkpoints.insert(newIndex, item);
                          });
                        },
                      ),
                      const SizedBox(
                        height: 130,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 58,
          right: 16,
          child: AddCheckpointButton(
            addCheckpoint: _saveCheckpoint,
            showTitle: false,
          ),
        ),
        Positioned(
          bottom: 58,
          left: 16,
          child: FloatingActionButton.extended(
            backgroundColor: Colors.blue.shade700,
            // TODO - add checkpoints and checklist
            onPressed: widget.toggleAddChecklistVisibility,
            label: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.checklist,
                ),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  AppLocalizations.of(context)!.checklist_drawer_title,
                ),
              ],
            ),
          ),
        ),
        if (widget.isAddChecklistVisible)
          OverlayChecklistSelection(
            checklist: widget.checklist,
            onDismiss: widget.toggleAddChecklistVisibility,
            addEntireChecklist: _addEntireChecklist,
            toggleCheckpoint: _toggleCheckpoint,
          ),
      ],
    );
  }
}
