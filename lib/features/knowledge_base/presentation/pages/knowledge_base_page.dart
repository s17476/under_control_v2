import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../blocs/instruction/instruction_bloc.dart';

class KnowledgeBasePage extends StatelessWidget {
  const KnowledgeBasePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: BlocBuilder<InstructionBloc, InstructionState>(
        builder: (context, state) {
          if (state is InstructionLoadedState) {
            print(state.allInstructions.allInstructions.length);
            return ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: state.allInstructions.allInstructions.length,
              itemBuilder: (context, index) => Card(
                child: Text(
                  state.allInstructions.allInstructions[index].name,
                ),
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
