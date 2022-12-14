import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../core/presentation/widgets/custom_text_form_field.dart';
import '../../../../core/presentation/widgets/glass_layer.dart';
import '../../../../core/utils/responsive_size.dart';
import '../../../domain/entities/instruction.dart';
import '../../blocs/instruction/instruction_bloc.dart';
import '../../blocs/instruction_category/instruction_category_bloc.dart';
import '../instruction_tile.dart';
import '../shimmer_instruction_tile.dart';

class OverlayInstructionSelection extends StatefulWidget {
  const OverlayInstructionSelection({
    Key? key,
    required this.instructions,
    required this.toggleSelection,
    required this.onDismiss,
  }) : super(key: key);

  final List<String> instructions;
  final Function(String) toggleSelection;
  final Function() onDismiss;

  @override
  State<OverlayInstructionSelection> createState() =>
      _OverlayInstructionSelectionState();
}

class _OverlayInstructionSelectionState
    extends State<OverlayInstructionSelection> with ResponsiveSize {
  String _searchQuery = '';

  final _searchTextEditingController = TextEditingController();

  void _clearSearchQuery() {
    _searchTextEditingController.text = '';
    setState(() {
      _searchQuery = '';
    });
  }

  // search instructions according to given query string
  List<Instruction> _searchInstructions(BuildContext context,
      List<Instruction> instructions, String searchQuery) {
    if (searchQuery.trim().isNotEmpty) {
      final categoryState = context.read<InstructionCategoryBloc>().state;
      if (categoryState is InstructionCategoryLoadedState) {
        return instructions
            .where(
              (instruction) =>
                  instruction.name
                      .toLowerCase()
                      .contains(searchQuery.trim().toLowerCase()) ||
                  categoryState
                      .getInstructionCategoryById(instruction.category)!
                      .name
                      .toLowerCase()
                      .contains(searchQuery.trim().toLowerCase()),
            )
            .toList();
      }
    }
    return instructions;
  }

  @override
  void dispose() {
    _searchTextEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GlassLayer(
        onDismiss: widget.onDismiss,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // search field
              Row(
                children: [
                  Expanded(
                    child: CustomTextFormField(
                      fieldKey: 'search',
                      controller: _searchTextEditingController,
                      keyboardType: TextInputType.name,
                      labelText: AppLocalizations.of(context)!.search,
                      onChanged: (value) => setState(() {
                        _searchQuery = value!;
                      }),
                      suffixIcon: InkWell(
                        onTap: () => _clearSearchQuery(),
                        child: const Icon(
                          Icons.cancel,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  IconButton(
                    onPressed: widget.onDismiss,
                    icon: const Icon(Icons.done),
                  )
                ],
              ),
              const Divider(),

              // instructions list
              Expanded(
                child: SingleChildScrollView(
                  child: BlocBuilder<InstructionBloc, InstructionState>(
                    builder: (context, state) {
                      if (state is InstructionLoadedState) {
                        if (state.allInstructions.allInstructions.isEmpty) {
                          return Column(
                            children: [
                              SizedBox(
                                height: responsiveSizeVerticalPct(small: 40),
                              ),
                              Text(
                                AppLocalizations.of(context)!.item_no_items,
                              ),
                            ],
                          );
                        }
                        final filteredItems = _searchInstructions(
                          context,
                          state.allInstructions.allInstructions,
                          _searchQuery,
                        );
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
                                searchQuery: _searchQuery,
                                isSelected: widget.instructions
                                    .contains(filteredItems[index].id),
                                onSelection: widget.toggleSelection,
                              ),
                            );
                          },
                        );
                      } else {
                        // shimmer loading animation
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
            ],
          ),
        ),
      ),
    );
  }
}
