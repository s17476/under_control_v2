import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:under_control_v2/features/core/utils/responsive_size.dart';
import 'package:under_control_v2/features/knowledge_base/domain/entities/content_type.dart';

import 'package:under_control_v2/features/knowledge_base/domain/entities/instruction_step.dart';

import '../../../../core/presentation/widgets/custom_video_player.dart';
import '../../../../core/presentation/widgets/image_viewer.dart';

class StepDetailsCard extends StatelessWidget with ResponsiveSize {
  const StepDetailsCard({
    Key? key,
    required this.step,
  }) : super(key: key);

  final InstructionStep step;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          children: [
            // image step
            if (step.contentType == ContentType.image)
              SizedBox(
                width: responsiveSizePct(small: 100),
                height: responsiveSizePct(small: 100),
                child: InkWell(
                  onTap: step.contentUrl != null && step.contentUrl!.isNotEmpty
                      // shows image full screen
                      ? () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ImageViewer(
                                imageProvider: CachedNetworkImageProvider(
                                  step.contentUrl!,
                                ),
                                heroTag: step.contentUrl!,
                                title:
                                    '${AppLocalizations.of(context)!.instruction_step} ${step.id + 1}',
                              ),
                            ),
                          );
                        }
                      : () {},
                  child: CachedNetworkImage(
                    imageUrl: step.contentUrl!,
                    placeholder: (context, url) => const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Center(child: CircularProgressIndicator()),
                    ),
                    errorWidget: (context, url, error) =>
                        SizedBox(child: Text(error.toString())),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            // video step
            if (step.contentType == ContentType.video)
              Container(
                constraints: BoxConstraints(
                  maxHeight: responsiveSizePct(small: 100),
                ),
                child: CustomVideoPlayer(
                  videoFile: step.file,
                  videoUrl: step.contentUrl,
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                    step.title!,
                    style: Theme.of(context).textTheme.headline6,
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  if (step.description != null && step.description!.isNotEmpty)
                    Text(
                      step.description!,
                      // style: Theme.of(context).textTheme.headline6,
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.justify,
                    ),
                ],
              ),
            ),
            const SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}
