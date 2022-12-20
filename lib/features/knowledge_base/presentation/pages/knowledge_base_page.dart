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
    return CustomScrollView(
      slivers: [
        SliverOverlapInjector(
          handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
        ),
        SliverToBoxAdapter(
          child: !permission
              ? Column(
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
                )
              : BlocBuilder<FilterBloc, FilterState>(
                  builder: (context, state) {
                    if (state is FilterLoadedState &&
                        state.locations.isNotEmpty) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            height:
                                isSearchBoxExpanded ? searchBoxHeight + 4 : 0,
                          ),
                          // instructions list
                          BlocBuilder<InstructionBloc, InstructionState>(
                            builder: (context, state) {
                              if (state is InstructionLoadedState) {
                                if (state
                                    .allInstructions.allInstructions.isEmpty) {
                                  return Column(
                                    children: [
                                      SizedBox(
                                        height: responsiveSizeVerticalPct(
                                            small: 40),
                                      ),
                                      Text(
                                        AppLocalizations.of(context)!
                                            .item_no_items,
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
                                      userState.userProfile.id ==
                                          instruction.userId &&
                                      !instruction.isPublished) {
                                    drafts.add(instruction);
                                  }
                                }
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // drafts
                                    if (drafts.isNotEmpty)
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 16,
                                              vertical: 4,
                                            ),
                                            child: Text(
                                              AppLocalizations.of(context)!
                                                  .drafts,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline4!
                                                  .copyWith(fontSize: 20),
                                            ),
                                          ),
                                          ListView.separated(
                                            separatorBuilder:
                                                (context, index) =>
                                                    const SizedBox(
                                              height: 4,
                                            ),
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            itemCount: drafts.length,
                                            itemBuilder: (context, index) =>
                                                InstructionTile(
                                              instruction: drafts[index],
                                              searchQuery: searchQuery,
                                            ),
                                          ),
                                        ],
                                      ),
                                    // published instructions
                                    if (published.isNotEmpty)
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          if (published.isNotEmpty)
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 16,
                                                vertical: 4,
                                              ),
                                              child: Text(
                                                AppLocalizations.of(context)!
                                                    .published,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline4!
                                                    .copyWith(fontSize: 20),
                                              ),
                                            ),
                                          ListView.separated(
                                            separatorBuilder:
                                                (context, index) =>
                                                    const SizedBox(
                                              height: 4,
                                            ),
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            itemCount: published.length,
                                            itemBuilder: (context, index) =>
                                                InstructionTile(
                                              instruction: published[index],
                                              searchQuery: searchQuery,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 50,
                                          ),
                                        ],
                                      ),
                                  ],
                                );
                              } else {
                                // shows shimmer when loading
                                return ListView.separated(
                                  padding: const EdgeInsets.only(top: 4),
                                  separatorBuilder: (context, index) =>
                                      const SizedBox(
                                    height: 4,
                                  ),
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: 8,
                                  itemBuilder: (context, index) =>
                                      const ShimmerInstructionTile(),
                                );
                              }
                            },
                          ),
                        ],
                      );
                    }
                    return const SizedBox();
                  },
                ),
        ),
      ],
    );
  }
}
