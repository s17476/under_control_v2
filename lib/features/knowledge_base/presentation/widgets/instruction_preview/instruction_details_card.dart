import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/presentation/widgets/icon_title_row.dart';
import '../../../../user_profile/domain/entities/user_profile.dart';
import '../../../domain/entities/instruction.dart';
import '../../blocs/instruction_category/instruction_category_bloc.dart';
import 'instruction_history.dart';
import 'instruction_locations.dart';

class InstructionDetailsCard extends StatelessWidget {
  const InstructionDetailsCard({
    Key? key,
    required this.instruction,
    required this.showUserInfoCard,
  }) : super(key: key);

  final Instruction instruction;

  final Function(UserProfile) showUserInfoCard;

  @override
  Widget build(BuildContext context) {
    final iconBoxWidth = MediaQuery.of(context).size.width * 0.15;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(children: [
            // icon box
            Positioned.fill(
              child: Container(
                alignment: Alignment.centerLeft,
                child: Container(
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black,
                        blurRadius: 4,
                        spreadRadius: 2,
                      ),
                    ],
                    color: Colors.deepPurple,
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(10),
                    ),
                  ),
                  width: iconBoxWidth,
                  child: const Icon(
                    Icons.menu_book,
                    size: 30,
                  ),
                ),
              ),
            ),
            // title
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(width: iconBoxWidth),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 16,
                    ),
                    child: Text(
                      instruction.name,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                ),
              ],
            )
          ]),
          // description
          if (instruction.description.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              child: Text(
                instruction.description,
                maxLines: 15,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              children: [
                const Divider(
                  thickness: 1.5,
                ),
                // group data
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 4,
                    vertical: 8,
                  ),
                  child: Column(
                    children: [
                      IconTitleRow(
                        icon: Icons.menu_book,
                        iconColor: Colors.white,
                        iconBackground: Colors.black,
                        title:
                            AppLocalizations.of(context)!.instruction_details,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      // category
                      Row(
                        children: [
                          Expanded(
                            child: IconTitleRow(
                              icon: Icons.category,
                              iconColor: Colors.white,
                              iconBackground: Theme.of(context).primaryColor,
                              title: AppLocalizations.of(context)!.category,
                            ),
                          ),
                          BlocBuilder<InstructionCategoryBloc,
                              InstructionCategoryState>(
                            builder: (context, state) {
                              if (state is InstructionCategoryLoadedState) {
                                final categoryName = state
                                    .getInstructionCategoryById(
                                      instruction.category,
                                    )
                                    ?.name;
                                return Text(
                                  categoryName ??
                                      AppLocalizations.of(context)!
                                          .item_details_category_not_found,
                                );
                              }
                              // category loading
                              return Shimmer.fromColors(
                                baseColor: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .color!,
                                highlightColor: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .color!
                                    .withOpacity(0.2),
                                child: Text(
                                  AppLocalizations.of(context)!.category,
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      // steps
                      Row(
                        children: [
                          Expanded(
                            child: IconTitleRow(
                              icon: Icons.checklist_rtl_outlined,
                              iconColor: Colors.white,
                              iconBackground: Theme.of(context).primaryColor,
                              title: AppLocalizations.of(context)!
                                  .instruction_steps,
                            ),
                          ),
                          Text(instruction.steps.length.toString()),
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      // steps
                      Row(
                        children: [
                          Expanded(
                            child: IconTitleRow(
                              icon: instruction.isPublished
                                  ? Icons.done
                                  : Icons.clear,
                              iconColor: Colors.white,
                              iconBackground: instruction.isPublished
                                  ? Theme.of(context).primaryColor
                                  : Colors.amber,
                              title: AppLocalizations.of(context)!.published,
                            ),
                          ),
                          Text(
                            instruction.isPublished
                                ? AppLocalizations.of(context)!.yes
                                : AppLocalizations.of(context)!.no,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // locations
                const Divider(
                  thickness: 1.5,
                ),
                InstructionLocations(instruction: instruction),
                const Divider(
                  thickness: 1.5,
                ),
                InstructionHistory(
                  instruction: instruction,
                  showUserInfoCard: showUserInfoCard,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 50,
          ),
        ],
      ),
    );
  }
}
