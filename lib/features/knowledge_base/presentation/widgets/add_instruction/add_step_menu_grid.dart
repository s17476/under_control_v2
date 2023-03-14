import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../../core/presentation/widgets/rounded_button.dart';
import '../../../domain/entities/content_type.dart';
import '../../../domain/entities/instruction_step.dart';
import '../../../utils/get_step_content_icon.dart';

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
    return GridView.count(
      primary: false,
      crossAxisCount: 2,
      shrinkWrap: true,
      childAspectRatio: ResponsiveValue(
            context,
            defaultValue: 1,
            valueWhen: [const Condition.largerThan(name: MOBILE, value: 1.5)],
          ).value?.toDouble() ??
          1,
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
          icon: getStepContentIcon(ContentType.image),
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
          icon: getStepContentIcon(ContentType.video),
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
          icon: getStepContentIcon(ContentType.youtube),
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
          icon: getStepContentIcon(ContentType.pdf),
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
          icon: getStepContentIcon(ContentType.url),
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
          icon: getStepContentIcon(ContentType.text),
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
    );
  }
}
