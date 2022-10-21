import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../knowledge_base/presentation/blocs/instruction/instruction_bloc.dart';
import '../../../knowledge_base/presentation/widgets/instruction_selection/overlay_instruction_selection.dart';
import '../../../knowledge_base/presentation/widgets/instruction_tile.dart';
import '../../../knowledge_base/presentation/widgets/shimmer_instruction_tile.dart';

class AddAssetInstructionsCard extends StatelessWidget {
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
                    const Title(),
                    const Divider(
                      thickness: 1.5,
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: InstructionsList(instructions: instructions),
                      ),
                    ),

                    // add spareparts from inventory button
                    AddInstructionsButton(
                      toggleAddInstructionsVisibility:
                          toggleAddInstructionsVisibility,
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
        if (isAddInstructionsVisible)
          OverlayInstructionSelection(
            onDismiss: toggleAddInstructionsVisibility,
            instructions: instructions,
            toggleSelection: toggleSelection,
          ),
      ],
    );
  }
}

class Title extends StatelessWidget {
  const Title({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 12,
        left: 8,
        right: 8,
      ),
      child: Text(
        AppLocalizations.of(context)!.asset_add_instructions,
        style: TextStyle(
          fontSize: Theme.of(context).textTheme.headline5!.fontSize,
        ),
      ),
    );
  }
}

class InstructionsList extends StatelessWidget {
  const InstructionsList({
    Key? key,
    required this.instructions,
  }) : super(key: key);

  final List<String> instructions;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InstructionBloc, InstructionState>(
      builder: (context, state) {
        if (state is InstructionLoadedState) {
          if (state.allInstructions.allInstructions.isEmpty) {
            return Column(
              children: [
                const Expanded(child: SizedBox()),
                Text(
                  AppLocalizations.of(context)!.item_no_items,
                ),
                const Expanded(child: SizedBox()),
              ],
            );
          }
          final filteredItems = state.allInstructions.allInstructions
              .where(
                (inst) => instructions.contains(inst.id),
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
    );
  }
}

class AddInstructionsButton extends StatelessWidget {
  const AddInstructionsButton({
    Key? key,
    required this.toggleAddInstructionsVisibility,
  }) : super(key: key);

  final Function() toggleAddInstructionsVisibility;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 4,
      ),
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.deepPurple.shade700,
        ),
        onPressed: toggleAddInstructionsVisibility,
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
    );
  }
}
