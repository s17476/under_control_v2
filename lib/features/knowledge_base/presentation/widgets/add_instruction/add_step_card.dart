import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:under_control_v2/features/knowledge_base/domain/entities/instruction.dart';

import '../../../../core/utils/choice.dart';
import '../../../data/models/instruction_step_model.dart';
import '../../../domain/entities/content_type.dart';
import '../../../domain/entities/instruction_step.dart';
import '../steps/image_step.dart';
import '../steps/pdf_step.dart';
import '../steps/text_step.dart';
import '../steps/url_step.dart';
import '../steps/video_step.dart';
import '../steps/youtube_step.dart';
import 'add_step_menu_grid.dart';

class AddStepCard extends StatelessWidget {
  const AddStepCard({
    Key? key,
    required this.isLastStep,
    required this.step,
    required this.setContentType,
    required this.updateStep,
    required this.removeStep,
    required this.insertStepBefore,
    required this.insertStepAfter,
    required this.moveBack,
    required this.moveForward,
    required this.instruction,
  }) : super(key: key);

  final bool isLastStep;

  final InstructionStepModel step;
  final Instruction? instruction;

  final Function(InstructionStep, ContentType) setContentType;

  final Function(InstructionStepModel) updateStep;
  final Function(InstructionStepModel) removeStep;
  final Function(InstructionStepModel) insertStepBefore;
  final Function(InstructionStepModel) insertStepAfter;
  final Function(InstructionStepModel) moveBack;
  final Function(InstructionStepModel) moveForward;

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
                        VideoStep(
                          step: step,
                          updateStep: updateStep,
                          instruction: instruction,
                        ),
                      if (step.contentType == ContentType.youtube)
                        YoutubeStep(step: step, updateStep: updateStep),
                      if (step.contentType == ContentType.pdf)
                        PdfStep(step: step, updateStep: updateStep),
                      if (step.contentType == ContentType.url)
                        UrlStep(step: step, updateStep: updateStep),
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
    );
  }
}
