import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../core/utils/show_snack_bar.dart';
import '../../data/models/checkpoint_model.dart';
import '../../utils/show_add_checkpoint_bottom_modal_sheet.dart';
import 'add_checkpoint_button.dart';
import 'checkpoint_tile.dart';

class AddCheckpointsCard extends StatefulWidget {
  const AddCheckpointsCard({
    Key? key,
    required this.checkpoints,
  }) : super(key: key);

  final List<CheckpointModel> checkpoints;

  @override
  State<AddCheckpointsCard> createState() => _AddCheckpointsCardState();
}

class _AddCheckpointsCardState extends State<AddCheckpointsCard> {
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

  @override
  void initState() {
    _checkpoints = widget.checkpoints;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          Column(
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
          Positioned(
            bottom: 60,
            right: 10,
            child: AddCheckpointButton(
              addCheckpoint: _saveCheckpoint,
            ),
          ),
        ],
      ),
    );
  }
}
