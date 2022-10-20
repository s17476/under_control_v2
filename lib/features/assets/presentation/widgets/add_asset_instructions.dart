import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../core/utils/responsive_size.dart';
import '../../../inventory/presentation/blocs/items/items_bloc.dart';
import '../../../inventory/presentation/widgets/inventory_selection/overlay_inventory_selection.dart';
import '../../../inventory/presentation/widgets/item_tile.dart';
import '../../../inventory/presentation/widgets/shimmer_item_tile.dart';
import '../../../knowledge_base/presentation/blocs/instruction/instruction_bloc.dart';
import '../../../knowledge_base/presentation/widgets/instruction_selection/overlay_instruction_selection.dart';
import '../../../knowledge_base/presentation/widgets/instruction_tile.dart';
import '../../../knowledge_base/presentation/widgets/shimmer_instruction_tile.dart';
import 'asset_selection/overlay_asset_selection.dart';

class AddAssetInstructionsCard extends StatefulWidget {
  const AddAssetInstructionsCard({
    Key? key,
    required this.toggleSelection,
    required this.toggleAddInstructionsVisibility,
    required this.instructions,
    required this.isAddInstructionsVisible,
  }) : super(key: key);

  final Function(String) toggleSelection;
  final Function() toggleAddInstructionsVisibility;
  final List<String> instructions;
  final bool isAddInstructionsVisible;

  @override
  State<AddAssetInstructionsCard> createState() =>
      _AddAssetInstructionsCardState();
}

class _AddAssetInstructionsCardState extends State<AddAssetInstructionsCard>
    with ResponsiveSize {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SafeArea(
          child: Column(
            children: [
              Expanded(
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
                        AppLocalizations.of(context)!.asset_add_instructions,
                        style: TextStyle(
                          fontSize:
                              Theme.of(context).textTheme.headline5!.fontSize,
                        ),
                      ),
                    ),
                    const Divider(
                      thickness: 1.5,
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: BlocBuilder<InstructionBloc, InstructionState>(
                          builder: (context, state) {
                            if (state is InstructionLoadedState) {
                              if (state
                                  .allInstructions.allInstructions.isEmpty) {
                                return Column(
                                  children: [
                                    SizedBox(
                                      height:
                                          responsiveSizeVerticalPct(small: 40),
                                    ),
                                    Text(
                                      AppLocalizations.of(context)!
                                          .item_no_items,
                                    ),
                                  ],
                                );
                              }
                              final filteredItems = state
                                  .allInstructions.allInstructions
                                  .where(
                                    (inst) =>
                                        widget.instructions.contains(inst.id),
                                  )
                                  .toList();

                              return ListView.builder(
                                padding: const EdgeInsets.only(top: 2),
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: filteredItems.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 4,
                                    ),
                                    child: InstructionTile(
                                      instruction: filteredItems[index],
                                      searchQuery: '',
                                      onSelection: (_) {},
                                    ),
                                  );
                                },
                              );
                            } else {
                              // loading shimmer animation
                              return ListView.builder(
                                padding: const EdgeInsets.only(top: 2),
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: 6,
                                itemBuilder: (context, index) {
                                  return const ShimmerInstructionTile();
                                },
                              );
                            }
                          },
                        ),
                      ),
                    ),

                    // add spareparts from inventory button
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 4,
                      ),
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurple.shade700,
                        ),
                        onPressed: widget.toggleAddInstructionsVisibility,
                        icon: SizedBox(
                          height: 30,
                          width: 30,
                          child: Stack(
                            children: const [
                              Positioned(
                                top: 0,
                                right: 0,
                                child: Icon(
                                  Icons.add,
                                  size: 15,
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                left: 0,
                                child: Icon(
                                  Icons.menu_book,
                                  size: 22,
                                ),
                              ),
                            ],
                          ),
                        ),
                        label: Text(
                          AppLocalizations.of(context)!.asset_add_instructions,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        if (widget.isAddInstructionsVisible)
          OverlayInstructionSelection(
            onDismiss: widget.toggleAddInstructionsVisibility,
            instructions: widget.instructions,
            toggleSelection: widget.toggleSelection,
          ),
      ],
    );
  }
}
