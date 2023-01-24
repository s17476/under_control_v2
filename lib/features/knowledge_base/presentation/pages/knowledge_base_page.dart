import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../core/utils/get_user_permission.dart';
import '../../../core/utils/permission.dart';
import '../../../core/utils/responsive_size.dart';
import '../../../filter/presentation/blocs/filter/filter_bloc.dart';
import '../../../groups/domain/entities/feature.dart';
import '../../../user_profile/presentation/blocs/user_profile/user_profile_bloc.dart';
import '../../domain/entities/instruction.dart';
import '../blocs/instruction/instruction_bloc.dart';
import '../blocs/instruction_category/instruction_category_bloc.dart';
import '../widgets/instruction_tile.dart';
import '../widgets/shimmer_instruction_tile.dart';

class KnowledgeBasePage extends StatelessWidget with ResponsiveSize {
  const KnowledgeBasePage({
    Key? key,
    required this.searchQuery,
    required this.searchBoxHeight,
    required this.isSearchBoxExpanded,
  }) : super(key: key);

  final String searchQuery;
  final double searchBoxHeight;
  final bool isSearchBoxExpanded;

  List<Instruction> _search(
    BuildContext context,
    List<Instruction> allInstructions,
    String searchQuery,
  ) {
    if (searchQuery.trim().isNotEmpty) {
      final categoryState = context.read<InstructionCategoryBloc>().state;
      if (categoryState is InstructionCategoryLoadedState) {
        return allInstructions
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
    return allInstructions;
  }

  @override
  Widget build(BuildContext context) {
    final permission = getUserPermission(
      context: context,
      featureType: FeatureType.knowledgeBase,
      permissionType: PermissionType.read,
    );
    final userState = context.read<UserProfileBloc>().state;
    if (!permission) {
      return Column(
        children: [
          SizedBox(
            height: responsiveSizeVerticalPct(small: 40),
          ),
          SizedBox(
            child: Text(
              AppLocalizations.of(context)!.permission_no_permission,
            ),
          ),
        ],
      );
    }
    return BlocBuilder<FilterBloc, FilterState>(
      builder: (context, state) {
        if (state is FilterLoadedState && state.locations.isNotEmpty) {
          return BlocBuilder<InstructionBloc, InstructionState>(
              builder: (context, state) {
            if (state is InstructionLoadedState) {
              // Instructions loaded but the list is empty
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
              final filteredInstructions = _search(
                context,
                state.allInstructions.allInstructions,
                searchQuery,
              );
              final List<Instruction> published = [];
              final List<Instruction> drafts = [];
              for (var instruction in filteredInstructions) {
                if (instruction.isPublished) {
                  published.add(instruction);
                } else if (userState is Approved &&
                    userState.userProfile.id == instruction.userId &&
                    !instruction.isPublished) {
                  drafts.add(instruction);
                }
              }
              return ListView(
                children: [
                  // Empty space under search bar
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    height: isSearchBoxExpanded ? searchBoxHeight : 0,
                  ),
                  // drafts
                  if (drafts.isNotEmpty) ...[
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 8,
                        right: 8,
                        top: 8,
                        bottom: 4,
                      ),
                      child: Text(
                        AppLocalizations.of(context)!.drafts,
                        style: Theme.of(context)
                            .textTheme
                            .headline4!
                            .copyWith(fontSize: 20),
                      ),
                    ),
                    ...drafts.map(
                      (draft) => Padding(
                        key: ValueKey(draft.id),
                        padding: const EdgeInsets.only(bottom: 4),
                        child: InstructionTile(
                          instruction: draft,
                          searchQuery: searchQuery,
                        ),
                      ),
                    ),
                  ],
                  // published instructions
                  if (published.isNotEmpty) ...[
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 8,
                        right: 8,
                        top: 8,
                        bottom: 4,
                      ),
                      child: Text(
                        AppLocalizations.of(context)!.published,
                        style: Theme.of(context)
                            .textTheme
                            .headline4!
                            .copyWith(fontSize: 20),
                      ),
                    ),
                    ...published.map(
                      (instruction) => Padding(
                        key: ValueKey(instruction.id),
                        padding: const EdgeInsets.only(bottom: 4),
                        child: InstructionTile(
                          instruction: instruction,
                          searchQuery: searchQuery,
                        ),
                      ),
                    ),
                  ],
                  const SizedBox(
                    height: 50,
                  ),
                ],
              );
            }
            // shows shimmer while loading
            return ListView.separated(
              padding: const EdgeInsets.only(top: 4),
              separatorBuilder: (context, index) => const SizedBox(
                height: 4,
              ),
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: 8,
              itemBuilder: (context, index) => const ShimmerInstructionTile(),
            );
          });
        }
        return const SizedBox();
      },
    );
  }
}
