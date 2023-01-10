import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../data/models/checkpoint_model.dart';
import '../../utils/show_add_checkpoint_bottom_modal_sheet.dart';

class AddCheckpointButton extends StatelessWidget {
  final Color color;
  final Function(CheckpointModel? oldCheckpoint, CheckpointModel newCheckpoint)
      addCheckpoint;
  final bool showTitle;

  const AddCheckpointButton({
    Key? key,
    this.color = const Color.fromRGBO(0, 240, 130, 100),
    required this.addCheckpoint,
    this.showTitle = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (showTitle) {
      return FloatingActionButton.extended(
        onPressed: () {
          showAddCheckpointModalBottomSheet(
            context: context,
            onSave: addCheckpoint,
          );
        },
        icon: Icon(
          Icons.add,
          color: Colors.grey.shade200,
        ),
        label: Text(
          AppLocalizations.of(context)!.checklist_add_checkpoint,
          style: TextStyle(
            color: Colors.grey.shade200,
          ),
        ),
      );
    }
    return FloatingActionButton(
      onPressed: () {
        showAddCheckpointModalBottomSheet(
          context: context,
          onSave: addCheckpoint,
        );
      },
      child: Icon(
        Icons.add,
        color: Colors.grey.shade200,
      ),
    );
  }
}
