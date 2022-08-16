import 'package:flutter/material.dart';

import 'package:under_control_v2/features/checklists/data/models/checkpoint_model.dart';

class CheckpointTile extends StatelessWidget {
  const CheckpointTile({
    Key? key,
    required this.checkpoint,
    required this.editCheckpoint,
    required this.deleteCheckpoint,
    required this.trailing,
    required this.index,
  }) : super(key: key);

  final CheckpointModel checkpoint;
  final Function(CheckpointModel checkpoint) editCheckpoint;
  final Function(CheckpointModel checkpoint) deleteCheckpoint;
  final Widget trailing;
  final int index;

  @override
  Widget build(BuildContext context) {
    final Color oddItemColor = Theme.of(context).focusColor;
    final Color evenItemColor = Theme.of(context).focusColor.withOpacity(0.05);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      width: double.infinity,
      color: index.isOdd ? oddItemColor : evenItemColor,
      child: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // title row
                InkWell(
                  onTap: () => editCheckpoint(checkpoint),
                  child: Row(
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
                          style:
                              Theme.of(context).textTheme.headline6!.copyWith(
                                    color: Colors.grey.shade200,
                                    fontSize: 18,
                                  ),
                          maxLines: 4,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(
              Icons.delete,
              size: 30,
            ),
            onPressed: () => deleteCheckpoint(checkpoint),
          ),
          trailing,
        ],
      ),
    );
  }
}
