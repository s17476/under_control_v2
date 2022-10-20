import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../core/presentation/widgets/highlighted_text.dart';
import '../../domain/entities/instruction.dart';
import '../../utils/get_step_content_icon.dart';
import '../pages/instruction_preview_page.dart';
import 'instruction_category_mini_row.dart';

class InstructionTile extends StatelessWidget {
  const InstructionTile({
    Key? key,
    required this.instruction,
    required this.searchQuery,
    this.isSelected,
    this.onSelection,
  }) : super(key: key);

  final Instruction instruction;
  final String searchQuery;
  final bool? isSelected;
  final Function(String)? onSelection;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).cardColor,
      child: Material(
        child: InkWell(
          onTap: onSelection != null
              ? () => onSelection!(instruction.id)
              : () => Navigator.pushNamed(
                    context,
                    InstructionPreviewPage.routeName,
                    arguments: instruction,
                  ),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            width: MediaQuery.of(context).size.width,
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // title
                      HighlightedText(
                        text: instruction.name,
                        query: searchQuery,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      // description
                      if (instruction.description.isNotEmpty)
                        Text(
                          instruction.description,
                          style: Theme.of(context).textTheme.caption,
                          maxLines: 4,
                          overflow: TextOverflow.ellipsis,
                        ),
                      const SizedBox(
                        height: 4,
                      ),
                      // steps
                      Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Text(
                            '${AppLocalizations.of(context)!.instruction_steps}: ${instruction.steps.length} - ',
                            style: Theme.of(context).textTheme.caption,
                          ),
                          for (var step in instruction.steps)
                            Padding(
                              padding: const EdgeInsets.only(right: 4),
                              child: FaIcon(
                                getStepContentIcon(step.contentType),
                                size: 18,
                                color:
                                    Theme.of(context).textTheme.caption!.color,
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      InstructionCategoryMiniRow(
                        categoryId: instruction.category,
                        searchQuery: searchQuery,
                      ),
                    ],
                  ),
                ),
                if (onSelection != null && isSelected != null)
                  Checkbox(
                    activeColor: Theme.of(context).primaryColor,
                    value: isSelected,
                    onChanged: (_) => onSelection!(instruction.id),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
