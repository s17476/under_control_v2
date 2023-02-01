import 'package:flutter/material.dart';

import '../../../../checklists/data/models/checkpoint_model.dart';

class CheckpointSelectionTile extends StatelessWidget {
  const CheckpointSelectionTile({
    Key? key,
    required this.checkpoint,
    required this.toggleCheckpoint,
    required this.isAdded,
    required this.index,
  }) : super(key: key);

  final CheckpointModel checkpoint;
  final Function(CheckpointModel checkpoint) toggleCheckpoint;
  final bool isAdded;
  final int index;

  @override
  Widget build(BuildContext context) {
    final Color oddItemColor = Theme.of(context).focusColor;
    final Color evenItemColor = Theme.of(context).focusColor.withOpacity(0.05);
    return Container(
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
                  onTap: () => toggleCheckpoint(checkpoint),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
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
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(
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
                ),
              ],
            ),
          ),
          IconButton(
            icon: Icon(
              isAdded ? Icons.remove : Icons.add,
              size: 30,
            ),
            onPressed: () => toggleCheckpoint(checkpoint),
          ),
        ],
      ),
    );
  }
}
