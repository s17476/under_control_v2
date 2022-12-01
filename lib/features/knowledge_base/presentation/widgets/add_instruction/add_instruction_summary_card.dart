import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../core/presentation/widgets/summary_card.dart';
import '../../../../core/utils/get_file_size.dart';
import '../../../../core/utils/responsive_size.dart';
import '../../../domain/entities/content_type.dart';
import '../../../domain/entities/instruction_step.dart';
import '../../../utils/get_step_content_localized_name.dart';
import '../../../utils/steps_validation.dart';
import '../../blocs/instruction_category/instruction_category_bloc.dart';

class AddInstructionSummaryCard extends StatelessWidget with ResponsiveSize {
  const AddInstructionSummaryCard({
    Key? key,
    required this.pageController,
    required this.titleTexEditingController,
    required this.descriptionTextEditingController,
    required this.steps,
    required this.totalSelectedLocations,
    required this.category,
    required this.isPublished,
    required this.addNewInstruction,
  }) : super(key: key);

  final PageController pageController;

  final TextEditingController titleTexEditingController;
  final TextEditingController descriptionTextEditingController;

  final List<InstructionStep> steps;
  final List<String> totalSelectedLocations;

  final String category;

  final bool isPublished;

  final Function(BuildContext context) addNewInstruction;

  @override
  Widget build(BuildContext context) {
    // category name
    String categoryName = '';
    final instructionCategoryState =
        context.read<InstructionCategoryBloc>().state;
    if (category.isNotEmpty &&
        instructionCategoryState is InstructionCategoryLoadedState) {
      categoryName = instructionCategoryState
          .allInstructionsCategories.allInstructionsCategories
          .firstWhere((cat) => cat.id == category)
          .name;
    }
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 8,
          // vertical: 4,
        ),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // title
                    Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.only(
                        top: 12,
                        left: 8,
                        right: 8,
                      ),
                      child: Text(
                        AppLocalizations.of(context)!.summary,
                        style: TextStyle(
                          fontSize:
                              Theme.of(context).textTheme.headline5!.fontSize,
                        ),
                      ),
                    ),
                    const Divider(
                      thickness: 1.5,
                    ),
                    // save mode
                    SummaryCard(
                      title: AppLocalizations.of(context)!.save_mode,
                      validator: () => isPublished ? null : '',
                      pageController: pageController,
                      onTapAnimateToPage: steps.length + 3,
                      errorColor: Colors.orange.withAlpha(210),
                      child: Text(
                        isPublished
                            ? AppLocalizations.of(context)!.publish
                            : AppLocalizations.of(context)!.draft,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    // item name
                    SummaryCard(
                      title: AppLocalizations.of(context)!.title,
                      validator: () =>
                          titleTexEditingController.text.trim().length < 2
                              ? AppLocalizations.of(context)!
                                  .validation_min_two_characters
                              : null,
                      pageController: pageController,
                      onTapAnimateToPage: 0,
                      child: Text(titleTexEditingController.text.trim()),
                    ),

                    const SizedBox(
                      height: 8,
                    ),

                    // description
                    if (descriptionTextEditingController.text.isNotEmpty)
                      SummaryCard(
                        title:
                            AppLocalizations.of(context)!.description_optional,
                        validator: () => null,
                        pageController: pageController,
                        onTapAnimateToPage: 0,
                        child:
                            Text(descriptionTextEditingController.text.trim()),
                      ),
                    if (descriptionTextEditingController.text.isNotEmpty)
                      const SizedBox(
                        height: 8,
                      ),

                    // category
                    SummaryCard(
                      title: AppLocalizations.of(context)!.category,
                      validator: () => category.isEmpty
                          ? AppLocalizations.of(context)!.category_no_select
                          : null,
                      pageController: pageController,
                      onTapAnimateToPage: 0,
                      child: Text(categoryName),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    // locations
                    SummaryCard(
                      title: AppLocalizations.of(context)!
                          .group_management_add_card_selected_locations,
                      validator: () => totalSelectedLocations.isEmpty
                          ? AppLocalizations.of(context)!
                              .group_management_add_error_no_location_selected
                          : null,
                      pageController: pageController,
                      onTapAnimateToPage: 1,
                      child: Text(
                        totalSelectedLocations.length.toString(),
                        style: const TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),

                    const SizedBox(
                      height: 8,
                    ),

                    // no steps added
                    SummaryCard(
                      title: AppLocalizations.of(context)!.instruction_steps,
                      validator: () => steps.isEmpty
                          ? AppLocalizations.of(context)!.instruction_no_steps
                          : null,
                      pageController: pageController,
                      onTapAnimateToPage: 2,
                      child: Text(
                        '${AppLocalizations.of(context)!.instruction_step_total}: ${steps.length}',
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),

                    // steps
                    for (var step in steps)
                      Column(
                        children: [
                          SummaryCard(
                            title:
                                '${AppLocalizations.of(context)!.instruction_step} ${step.id + 1}',
                            validator: () => validateStep(context, step),
                            pageController: pageController,
                            onTapAnimateToPage: step.id + 2,
                            child: step.contentType == ContentType.unknown
                                ? const SizedBox()
                                : Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${AppLocalizations.of(context)!.content_type}: ${getStepContentLocalizedName(context, step.contentType)}',
                                      ),
                                      Text(
                                        '${AppLocalizations.of(context)!.header}: ${step.title ?? ''}',
                                      ),
                                      if (step.contentType ==
                                              ContentType.text ||
                                          (step.description != null &&
                                              step.description!
                                                  .trim()
                                                  .isNotEmpty))
                                        Text(
                                          '${AppLocalizations.of(context)!.description}: ${step.description ?? ''}',
                                        ),
                                      if (step.contentType ==
                                          ContentType.youtube)
                                        Text(
                                          '${AppLocalizations.of(context)!.content_youtube_id}: ${step.contentUrl ?? ''}',
                                        ),
                                      if (step.contentType == ContentType.url)
                                        Text(
                                          '${AppLocalizations.of(context)!.content_url_link}: ${step.contentUrl ?? ''}',
                                        ),
                                      if ((step.contentType ==
                                                  ContentType.image ||
                                              step.contentType ==
                                                  ContentType.video ||
                                              step.contentType ==
                                                  ContentType.pdf) &&
                                          step.file != null)
                                        Text(
                                          '${AppLocalizations.of(context)!.size}: ${getFileSize(step.file!.path, 2)}',
                                        ),
                                    ],
                                  ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                        ],
                      ),
                    const SizedBox(
                      height: 50,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
