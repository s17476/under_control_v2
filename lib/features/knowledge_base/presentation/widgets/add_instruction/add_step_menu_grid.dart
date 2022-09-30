import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/presentation/widgets/rounded_button.dart';
import '../../../domain/entities/content_type.dart';
import '../../../domain/entities/instruction_step.dart';

class AddStepMenuGrid extends StatelessWidget {
  const AddStepMenuGrid({
    Key? key,
    required this.step,
    required this.setContentType,
  }) : super(key: key);

  final InstructionStep step;

  final Function(InstructionStep, ContentType) setContentType;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: GridView.count(
        primary: false,
        crossAxisCount: 2,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        padding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 24,
        ),
        children: [
          // image
          RoundedButton(
            padding: const EdgeInsets.all(9),
            onPressed: () => setContentType(step, ContentType.image),
            icon: FontAwesomeIcons.image,
            iconSize: 80,
            title: AppLocalizations.of(context)!.content_image,
            titleSize: 20,
            gradient: LinearGradient(
              colors: [
                Colors.deepPurple,
                Colors.deepPurple.withAlpha(80),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          // video
          RoundedButton(
            padding: const EdgeInsets.all(9),
            onPressed: () => setContentType(step, ContentType.video),
            icon: FontAwesomeIcons.play,
            iconSize: 80,
            title: AppLocalizations.of(context)!.content_video,
            titleSize: 20,
            gradient: LinearGradient(
              colors: [
                Colors.blue,
                Colors.blue.withAlpha(60),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          // youtybe
          RoundedButton(
            padding: const EdgeInsets.all(9),
            onPressed: () => setContentType(step, ContentType.youtube),
            icon: FontAwesomeIcons.youtube,
            iconSize: 80,
            title: AppLocalizations.of(context)!.content_youtube,
            titleSize: 20,
            gradient: LinearGradient(
              colors: [
                Colors.red,
                Colors.red.withAlpha(70),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          // pdf file
          RoundedButton(
            padding: const EdgeInsets.all(9),
            onPressed: () => setContentType(step, ContentType.pdf),
            icon: FontAwesomeIcons.filePdf,
            iconSize: 80,
            title: AppLocalizations.of(context)!.content_pdf,
            titleSize: 20,
            gradient: LinearGradient(
              colors: [
                Colors.deepOrange,
                Colors.deepOrange.withAlpha(60),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          // url
          RoundedButton(
            padding: const EdgeInsets.all(9),
            onPressed: () => setContentType(step, ContentType.url),
            icon: Icons.web,
            iconSize: 80,
            title: AppLocalizations.of(context)!.content_url,
            titleSize: 20,
            gradient: LinearGradient(
              colors: [
                Colors.orange,
                Colors.orange.withAlpha(60),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          // text
          RoundedButton(
            padding: const EdgeInsets.all(9),
            onPressed: () => setContentType(step, ContentType.text),
            icon: Icons.text_snippet_outlined,
            iconSize: 80,
            title: AppLocalizations.of(context)!.content_text,
            titleSize: 20,
            gradient: LinearGradient(
              colors: [
                Theme.of(context).primaryColor,
                Theme.of(context).primaryColor.withAlpha(60),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ],
      ),
    );
  }
}
