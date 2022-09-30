import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:image_picker/image_picker.dart';

import 'package:under_control_v2/features/knowledge_base/data/models/instruction_step_model.dart';
import 'package:under_control_v2/features/knowledge_base/domain/entities/content_type.dart';
import 'package:under_control_v2/features/knowledge_base/domain/entities/instruction_step.dart';
import 'package:under_control_v2/features/knowledge_base/presentation/widgets/add_instruction/add_step_menu_grid.dart';
import 'package:under_control_v2/features/knowledge_base/presentation/widgets/steps/text_step.dart';

import '../../../../core/presentation/widgets/backward_text_button.dart';
import '../../../../core/presentation/widgets/forward_text_button.dart';
import '../../../../core/utils/responsive_size.dart';

class AddStepCard extends StatelessWidget {
  const AddStepCard({
    Key? key,
    required this.pageController,
    required this.step,
    required this.setContentType,
    required this.updateStep,
  }) : super(key: key);

  final PageController pageController;

  final InstructionStep step;

  final Function(InstructionStep, ContentType) setContentType;

  final Function(InstructionStep) updateStep;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: Column(
              children: [
                // title
                Padding(
                  padding: const EdgeInsets.only(
                    top: 12,
                    left: 8,
                    right: 8,
                  ),
                  child: Text(
                    step.contentType == ContentType.unknown
                        ? AppLocalizations.of(context)!.instruction_step_add
                        : '${AppLocalizations.of(context)!.instruction_step} ${step.id + 1}',
                    style: TextStyle(
                      fontSize: Theme.of(context).textTheme.headline5!.fontSize,
                    ),
                  ),
                ),
                const Divider(
                  thickness: 1.5,
                ),
                Expanded(
                  child: Column(
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
                        TextStep(
                          step: step,
                          updateStep: updateStep,
                        ),
                    ],
                  ),
                ),
                if (step.contentType == ContentType.image)
                  Text(step.contentType.name),
                if (step.contentType == ContentType.video)
                  Text(step.contentType.name),
                if (step.contentType == ContentType.youtube)
                  Text(step.contentType.name),
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
