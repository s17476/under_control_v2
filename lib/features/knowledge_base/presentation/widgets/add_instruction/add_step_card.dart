import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:image_picker/image_picker.dart';

import 'package:under_control_v2/features/knowledge_base/data/models/instruction_step_model.dart';
import 'package:under_control_v2/features/knowledge_base/domain/entities/content_type.dart';
import 'package:under_control_v2/features/knowledge_base/domain/entities/instruction_step.dart';
import 'package:under_control_v2/features/knowledge_base/presentation/widgets/add_instruction/add_step_menu_grid.dart';
import 'package:under_control_v2/features/knowledge_base/presentation/widgets/steps/image_step.dart';
import 'package:under_control_v2/features/knowledge_base/presentation/widgets/steps/text_step.dart';

import '../../../../core/presentation/widgets/backward_text_button.dart';
import '../../../../core/presentation/widgets/forward_text_button.dart';
import '../../../../core/utils/choice.dart';
import '../../../../core/utils/responsive_size.dart';
import '../steps/video_step.dart';
import '../steps/youtube_step.dart';

class AddStepCard extends StatelessWidget {
  const AddStepCard({
    Key? key,
    required this.isLastStep,
    required this.pageController,
    required this.step,
    required this.setContentType,
    required this.updateStep,
    required this.removeStep,
    required this.insertStepBefore,
    required this.insertStepAfter,
    required this.moveBack,
    required this.moveForward,
  }) : super(key: key);

  final bool isLastStep;

  final PageController pageController;

  final InstructionStep step;

  final Function(InstructionStep, ContentType) setContentType;

  final Function(InstructionStep) updateStep;
  final Function(InstructionStep) removeStep;
  final Function(InstructionStep) insertStepBefore;
  final Function(InstructionStep) insertStepAfter;
  final Function(InstructionStep) moveBack;
  final Function(InstructionStep) moveForward;

  @override
  Widget build(BuildContext context) {
    // popup menu elements
    List<Choice> _choices = [
      // insert step before
      if (step.contentType != ContentType.unknown)
        Choice(
          title: AppLocalizations.of(context)!.instruction_step_add_before,
          icon: Icons.subdirectory_arrow_left,
          onTap: () => insertStepBefore(step),
        ),
      // insert step after
      if (step.contentType != ContentType.unknown)
        Choice(
          title: AppLocalizations.of(context)!.instruction_step_add_after,
          icon: Icons.subdirectory_arrow_right,
          onTap: () => insertStepAfter(step),
        ),
      // move back
      if (step.contentType != ContentType.unknown)
        Choice(
          title: AppLocalizations.of(context)!.instruction_step_move_back,
          icon: Icons.arrow_back,
          onTap: () => moveBack(step),
        ),
      // move forward
      if (step.contentType != ContentType.unknown)
        Choice(
          title: AppLocalizations.of(context)!.instruction_step_move_forward,
          icon: Icons.arrow_forward,
          onTap: () => moveForward(step),
        ),
      // reset content type
      if (step.contentType != ContentType.unknown)
        Choice(
          title: AppLocalizations.of(context)!.content_type_change,
          icon: Icons.edit,
          onTap: () => setContentType(
            step,
            ContentType.unknown,
          ),
        ),
      // remove step
      Choice(
        title: AppLocalizations.of(context)!.instruction_step_delete,
        icon: Icons.delete,
        onTap: () => removeStep(step),
      ),
    ];
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // title
                  SizedBox(
                    width: double.infinity,
                    child: Stack(
                      children: [
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.only(
                              top: 12,
                            ),
                            child: Text(
                              step.contentType == ContentType.unknown
                                  ? AppLocalizations.of(context)!
                                      .instruction_step_add
                                  : '${AppLocalizations.of(context)!.instruction_step} ${step.id + 1}',
                              style: TextStyle(
                                fontSize: Theme.of(context)
                                    .textTheme
                                    .headline5!
                                    .fontSize,
                              ),
                            ),
                          ),
                        ),
                        if (!isLastStep)
                          Positioned(
                            right: 0,
                            top: 4,
                            child: PopupMenuButton<Choice>(
                              onSelected: (Choice choice) {
                                FocusScope.of(context).unfocus();
                                choice.onTap();
                              },
                              itemBuilder: (BuildContext context) {
                                return _choices.map((Choice choice) {
                                  return PopupMenuItem<Choice>(
                                    value: choice,
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(choice.icon),
                                        const SizedBox(
                                          width: 4,
                                        ),
                                        Text(
                                          choice.title,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  );
                                }).toList();
                              },
                            ),
                          ),
                      ],
                    ),
                  ),
                  const Divider(
                    thickness: 1.5,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // content type not selected
                      if (step.contentType == ContentType.unknown)
                        AddStepMenuGrid(
                          step: step,
                          setContentType: setContentType,
                        ),
                      // content type - text
                      if (step.contentType == ContentType.text)
                        TextStep(step: step, updateStep: updateStep),
                      if (step.contentType == ContentType.image)
                        ImageStep(step: step, updateStep: updateStep),
                      if (step.contentType == ContentType.video)
                        VideoStep(step: step, updateStep: updateStep),
                      if (step.contentType == ContentType.youtube)
                        YoutubeStep(step: step, updateStep: updateStep),
                    ],
                  ),
                  if (step.contentType == ContentType.pdf)
                    Text(step.contentType.name),
                  if (step.contentType == ContentType.url)
                    Text(step.contentType.name),

                  const SizedBox(
                    height: 16,
                  ),
                ],
              ),
            ),
          ),

          // bottom navigation
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BackwardTextButton(
                  icon: Icons.arrow_back_ios_new,
                  color: Theme.of(context).textTheme.headline5!.color!,
                  label: AppLocalizations.of(context)!
                      .user_profile_add_user_personal_data_back,
                  function: () => pageController.previousPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  ),
                ),
                ForwardTextButton(
                  color: Theme.of(context).textTheme.headline5!.color!,
                  label: step.contentType == ContentType.unknown
                      ? AppLocalizations.of(context)!.skip
                      : AppLocalizations.of(context)!
                          .user_profile_add_user_next,
                  function: () => pageController.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  ),
                  icon: Icons.arrow_forward_ios_outlined,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
