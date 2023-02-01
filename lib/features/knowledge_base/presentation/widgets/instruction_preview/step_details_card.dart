import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../core/presentation/widgets/cached_pdf_viewer.dart';
import '../../../../core/presentation/widgets/custom_video_player.dart';
import '../../../../core/presentation/widgets/custom_youtube_player.dart';
import '../../../../core/presentation/widgets/image_viewer.dart';
import '../../../../core/presentation/widgets/url_preview_card.dart';
import '../../../../core/utils/responsive_size.dart';
import '../../../domain/entities/content_type.dart';
import '../../../domain/entities/instruction_step.dart';

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
            // youtue step
            if (step.contentType == ContentType.youtube)
              CustomYoutubePlayer(contentUrl: step.contentUrl!),
            // pdf step
            if (step.contentType == ContentType.pdf)
              SizedBox(
                width: responsiveSizePct(small: 75),
                height: responsiveSizePct(small: 100),
                child: CachedPdfViewer(
                  pdfUrl: step.contentUrl!,
                ),
              ),
            if (step.contentType == ContentType.url)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: UrlPreviewCard(url: step.contentUrl),
              ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  // title
                  Text(
                    step.title!,
                    style: Theme.of(context).textTheme.titleLarge,
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  // description
                  if (step.description != null && step.description!.isNotEmpty)
                    Text(
                      step.description!,
                      maxLines: 100,
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
