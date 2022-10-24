import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:under_control_v2/features/knowledge_base/presentation/widgets/shimmer_instruction_tile.dart';

import '../../../../knowledge_base/presentation/blocs/instruction/instruction_bloc.dart';
import '../../../../knowledge_base/presentation/widgets/instruction_tile.dart';
import '../../../domain/entities/asset.dart';

class AssetsInstructionsTab extends StatelessWidget {
  const AssetsInstructionsTab({
    Key? key,
    required this.asset,
  }) : super(key: key);

  final Asset asset;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // assets
          BlocBuilder<InstructionBloc, InstructionState>(
            builder: (context, state) {
              if (state is InstructionLoadedState) {
                final filteredInstructions =
                    state.allInstructions.allInstructions
                        .where(
                          (inst) => asset.instructions.contains(inst.id),
                        )
                        .toList();
                return ListView.builder(
                  padding: const EdgeInsets.only(top: 2),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: filteredInstructions.length,
                  itemBuilder: (context, index) {
                    return InstructionTile(
                      instruction: filteredInstructions[index],
                      searchQuery: '',
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
        ],
      ),
    );
  }
}
