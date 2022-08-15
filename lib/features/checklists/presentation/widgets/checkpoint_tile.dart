import 'package:flutter/material.dart';
import 'package:under_control_v2/features/checklists/data/models/checkpoint_model.dart';

import '../../domain/entities/checkpoint.dart';

class CheckpointTile extends StatelessWidget {
  const CheckpointTile({
    Key? key,
    required this.checkpoint,
    required this.editCheckpoint,
    required this.deleteCheckpoint,
  }) : super(key: key);

  final CheckpointModel checkpoint;
  final Function(CheckpointModel checkpoint) editCheckpoint;
  final Function(Checkpoint checkpoint) deleteCheckpoint;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 4,
        horizontal: 8,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Theme.of(context).focusColor,
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // title row
                Row(
                  children: [
                    Icon(
                      Icons.check_circle_outline_outlined,
                      color: Theme.of(context).primaryColor,
                      size: 30,
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    Expanded(
                      child: Text(
                        checkpoint.title,
                        style: Theme.of(context).textTheme.headline6!.copyWith(
                              color: Colors.grey.shade200,
                              fontSize: 18,
                            ),
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(
              Icons.edit,
              size: 30,
            ),
            onPressed: () => editCheckpoint(checkpoint),
          ),
          IconButton(
            icon: const Icon(
              Icons.delete,
              size: 30,
            ),
            onPressed: () => deleteCheckpoint(checkpoint),
          ),
        ],
      ),
    );
  }
}
