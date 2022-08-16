import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:under_control_v2/features/checklists/data/models/checkpoint_model.dart';

import 'package:under_control_v2/features/checklists/domain/entities/checkpoint.dart';
import 'package:under_control_v2/features/checklists/presentation/widgets/add_checkpoint_bottom_modal_sheet.dart';

class AddCheckpointTile extends StatelessWidget {
  final Color color;
  final Function(CheckpointModel? oldCheckpoint, CheckpointModel newCheckpoint)
      addCheckpoint;

  const AddCheckpointTile({
    Key? key,
    this.color = const Color.fromRGBO(0, 240, 130, 100),
    required this.addCheckpoint,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
      child: InkWell(
        onTap: () {
          showAddCheckpointModalBottomSheet(
            context: context,
            onSave: addCheckpoint,
          );
        },
        customBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Theme.of(context).inputDecorationTheme.fillColor,
          ),
          child: Row(
            children: [
              Container(
                width: 42,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                  ),
                  color: color,
                ),
                child: const Icon(
                  Icons.add,
                  size: 30,
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    const SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: Text(
                        AppLocalizations.of(context)!.checklist_add_checkpoint,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: TextStyle(color: Colors.grey.shade100),
                      ),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
