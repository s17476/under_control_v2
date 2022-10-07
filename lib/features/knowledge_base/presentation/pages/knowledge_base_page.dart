import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:under_control_v2/features/knowledge_base/presentation/widgets/instruction_tile.dart';

import '../blocs/instruction/instruction_bloc.dart';

class KnowledgeBasePage extends StatelessWidget {
  const KnowledgeBasePage({
    Key? key,
    required this.searchQuery,
    required this.searchBoxHeight,
    required this.isSearchBoxExpanded,
  }) : super(key: key);

  final String searchQuery;
  final double searchBoxHeight;
  final bool isSearchBoxExpanded;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: BlocBuilder<InstructionBloc, InstructionState>(
        builder: (context, state) {
          if (state is InstructionLoadedState) {
            return ListView.separated(
              padding: const EdgeInsets.only(top: 8),
              separatorBuilder: (context, index) =>
                  const Divider(thickness: 1.5),
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: state.allInstructions.allInstructions.length,
              itemBuilder: (context, index) => InstructionTile(
                instruction: state.allInstructions.allInstructions[index],
                searchQuery: searchQuery,
              ),
            );
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
