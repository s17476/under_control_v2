import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../core/presentation/widgets/custom_video_player.dart';

class VideoTab extends StatelessWidget {
  const VideoTab({
    Key? key,
    required this.videoUrl,
  }) : super(key: key);

  final String videoUrl;

  @override
  Widget build(BuildContext context) {
    if (videoUrl.isNotEmpty) {
      return CustomVideoPlayer(
        videoUrl: videoUrl,
      );
    }
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.play_arrow,
            size: 70,
            color: Theme.of(context).textTheme.bodySmall!.color!,
          ),
          Text(
            AppLocalizations.of(context)!.details_no_images,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}
