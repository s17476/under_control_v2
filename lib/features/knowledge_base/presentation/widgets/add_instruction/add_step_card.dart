import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:image_picker/image_picker.dart';

import 'package:under_control_v2/features/knowledge_base/data/models/instruction_step_model.dart';
import 'package:under_control_v2/features/knowledge_base/domain/entities/content_type.dart';
import 'package:under_control_v2/features/knowledge_base/domain/entities/instruction_step.dart';
import 'package:under_control_v2/features/knowledge_base/presentation/widgets/add_instruction/add_step_menu_grid.dart';

import '../../../../core/presentation/widgets/backward_text_button.dart';
import '../../../../core/presentation/widgets/forward_text_button.dart';
import '../../../../core/utils/responsive_size.dart';

class AddStepCard extends StatefulWidget {
  const AddStepCard({
    Key? key,
    required this.pageController,
    required this.step,
    required this.setContentType,
  }) : super(key: key);

  final PageController pageController;

  final InstructionStep step;

  final Function(InstructionStep, ContentType) setContentType;

  @override
  State<AddStepCard> createState() => _AddStepCardState();
}

class _AddStepCardState extends State<AddStepCard> with ResponsiveSize {
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
                    '${AppLocalizations.of(context)!.instruction_step} ${widget.step.id + 1}',
                    style: TextStyle(
                      fontSize: Theme.of(context).textTheme.headline5!.fontSize,
                    ),
                  ),
                ),
                const Divider(
                  thickness: 1.5,
                ),
                Expanded(
                  child: Center(
                    child: AddStepMenuGrid(
                      step: widget.step,
                      setContentType: widget.setContentType,
                    ),
                  ),
                ),
                if (widget.step.contentType == ContentType.image)
                  Text(widget.step.contentType.name),
                if (widget.step.contentType == ContentType.video)
                  Text(widget.step.contentType.name),
                if (widget.step.contentType == ContentType.youtube)
                  Text(widget.step.contentType.name),
                if (widget.step.contentType == ContentType.pdf)
                  Text(widget.step.contentType.name),
                if (widget.step.contentType == ContentType.url)
                  Text(widget.step.contentType.name),
                if (widget.step.contentType == ContentType.text)
                  Text(widget.step.contentType.name),
                // Stack(
                //   children: [
                //     Padding(
                //       padding: const EdgeInsets.all(8.0),
                //       child: Image.asset(
                //         'assets/photo.png',
                //         fit: BoxFit.fill,
                //       ),
                //     ),
                //     if (imageUrl != null)
                //       SizedBox(
                //         width: responsiveSizePct(small: 100),
                //         height: responsiveSizePct(small: 100),
                //         child: CachedNetworkImage(
                //           imageUrl: imageUrl!,
                //           placeholder: (context, url) => const Padding(
                //             padding: EdgeInsets.all(8.0),
                //             child: CircularProgressIndicator(),
                //           ),
                //           errorWidget: (context, url, error) =>
                //               const SizedBox(),
                //           fit: BoxFit.cover,
                //         ),
                //       ),
                //     if (image != null)
                //       SizedBox(
                //         width: responsiveSizePct(small: 100),
                //         height: responsiveSizePct(small: 100),
                //         child: Image.file(
                //           image!,
                //           fit: BoxFit.fitWidth,
                //         ),
                //       ),
                //   ],
                // ),
                const SizedBox(
                  height: 16,
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //   children: [
                //     // camera button
                //     OverlayIconButton(
                //       onPressed: () => setImage(ImageSource.camera),
                //       icon: Icons.camera,
                //       title: AppLocalizations.of(context)!
                //           .user_profile_add_user_personal_data_take_photo_btn,
                //     ),
                //     // reset image button
                //     if (image != null)
                //       OverlayIconButton(
                //         onPressed: () => deleteImage(),
                //         icon: Icons.cancel,
                //         title: AppLocalizations.of(context)!.reset_image,
                //       ),
                //     // gallery button
                //     OverlayIconButton(
                //       onPressed: () => setImage(ImageSource.gallery),
                //       icon: Icons.photo_size_select_actual_rounded,
                //       title: AppLocalizations.of(context)!
                //           .user_profile_add_user_personal_data_gallery,
                //     ),
                //   ],
                // ),
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
                  function: () => widget.pageController.previousPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  ),
                ),
                ForwardTextButton(
                  color: Theme.of(context).textTheme.headline5!.color!,
                  label: widget.step.contentType == ContentType.unknown
                      ? AppLocalizations.of(context)!.skip
                      : AppLocalizations.of(context)!
                          .user_profile_add_user_next,
                  function: () => widget.pageController.nextPage(
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
