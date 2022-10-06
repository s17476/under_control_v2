import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../blocs/instruction/instruction_bloc.dart';

class KnowledgeBasePage extends StatelessWidget {
  const KnowledgeBasePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: BlocBuilder<InstructionBloc, InstructionState>(
          builder: (context, state) {
            if (state is InstructionLoadedState) {
              return SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    Text(
                      AppLocalizations.of(context)!.bottom_bar_title_knowledge,
                    ),
                  ],
                ),
              );
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}
