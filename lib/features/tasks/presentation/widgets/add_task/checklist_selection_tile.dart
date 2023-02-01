import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../checklists/data/models/checkpoint_model.dart';
import '../../../../checklists/domain/entities/checklist.dart';
import '../../../../core/presentation/widgets/highlighted_text.dart';
import '../../../../core/presentation/widgets/rounded_button.dart';
import 'checkpoint_selection_tile.dart';

class ChecklistSelectionTile extends StatefulWidget {
  const ChecklistSelectionTile({
    Key? key,
    required this.checklist,
    this.searchQuery = '',
    required this.checkpoints,
    required this.addEntireChecklist,
    required this.toggleCheckpoint,
  }) : super(key: key);

  final Checklist checklist;
  final String searchQuery;
  final List<CheckpointModel> checkpoints;
  final Function(Checklist checklist) addEntireChecklist;
  final Function(CheckpointModel checkpoint) toggleCheckpoint;

  @override
  State<ChecklistSelectionTile> createState() => _ChecklistSelectionTileState();
}

class _ChecklistSelectionTileState extends State<ChecklistSelectionTile> {
  bool _isExpanded = false;

  void _toggleIsExpanded() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(
            vertical: 4,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Theme.of(context).cardColor,
          ),
          child: Material(
            borderRadius: BorderRadius.circular(10),
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(10),
              onTap: _toggleIsExpanded,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  // color: Theme.of(context).cardColor,
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
                                Icons.checklist,
                                color: Theme.of(context).primaryColor,
                                size: 24,
                              ),
                              const SizedBox(
                                width: 12,
                              ),
                              Expanded(
                                child: HighlightedText(
                                  text: widget.checklist.title,
                                  query: widget.searchQuery,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge!
                                      .copyWith(
                                        color: Colors.grey.shade200,
                                        fontSize: 18,
                                      ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),

                          // description
                          if (widget.checklist.description.isNotEmpty)
                            Text(
                              widget.checklist.description,
                              style: Theme.of(context).textTheme.labelMedium,
                            ),
                        ],
                      ),
                    ),
                    Icon(
                      _isExpanded
                          ? Icons.keyboard_arrow_up_rounded
                          : Icons.keyboard_arrow_down_rounded,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        AnimatedSize(
          duration: const Duration(milliseconds: 300),
          child: Container(
            margin: _isExpanded
                ? const EdgeInsets.only(
                    top: 8,
                    bottom: 16,
                    left: 8,
                    right: 8,
                  )
                : null,
            height: _isExpanded ? null : 0,
            child: Column(
              children: [
                RoundedButton(
                  onPressed: () => widget.addEntireChecklist(widget.checklist),
                  axis: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 8,
                  ),
                  icon: Icons.list,
                  iconSize: 30,
                  title: AppLocalizations.of(context)!.task_add_checklist,
                  titleSize: 16,
                  gradient: LinearGradient(
                    colors: [
                      Theme.of(context).primaryColor,
                      Theme.of(context).primaryColor.withAlpha(60),
                    ],
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: widget.checklist.allCheckpoints.length,
                  itemBuilder: (context, index) => CheckpointSelectionTile(
                    checkpoint: widget.checklist.allCheckpoints[index],
                    toggleCheckpoint: widget.toggleCheckpoint,
                    index: index,
                    isAdded: widget.checkpoints
                        .contains(widget.checklist.allCheckpoints[index]),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
