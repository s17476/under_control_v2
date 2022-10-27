import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../knowledge_base/presentation/blocs/instruction/instruction_bloc.dart';
import '../../../../knowledge_base/presentation/widgets/instruction_tile.dart';
import '../../../../knowledge_base/presentation/widgets/shimmer_instruction_tile.dart';
import '../../../domain/entities/asset.dart';

class AssetsInstructionsTab extends StatelessWidget {
  const AssetsInstructionsTab({
    Key? key,
    required this.asset,
  }) : super(key: key);

  final Asset asset;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InstructionBloc, InstructionState>(
      builder: (context, state) {
        if (state is InstructionLoadedState) {
          final filteredInstructions = state.allInstructions.allInstructions
              .where(
                (inst) => asset.instructions.contains(inst.id),
              )
              .toList();
          if (filteredInstructions.isNotEmpty) {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: filteredInstructions.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2.0),
                  child: InstructionTile(
                    instruction: filteredInstructions[index],
                    searchQuery: '',
                  ),
                );
              },
            );
          }
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.menu_book,
                  size: 70,
                  color: Theme.of(context).textTheme.caption!.color!,
                ),
                Text(
                  AppLocalizations.of(context)!.details_no_instructions,
                  style: Theme.of(context).textTheme.caption,
                ),
              ],
            ),
          );
        } else {
          // loading shimmer animation
          return ListView.builder(
            padding: const EdgeInsets.only(top: 2),
            shrinkWrap: true,
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
