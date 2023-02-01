import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:under_control_v2/features/core/utils/url_launcher_helpers.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class CustomYoutubePlayer extends StatefulWidget {
  const CustomYoutubePlayer({
    Key? key,
    required this.contentUrl,
  }) : super(key: key);

  final String contentUrl;

  @override
  State<CustomYoutubePlayer> createState() => _CustomYoutubePlayerState();
}

class _CustomYoutubePlayerState extends State<CustomYoutubePlayer> {
  late YoutubePlayerController _controller;

  void _initVideo() {
    _controller.cueVideoById(videoId: widget.contentUrl);
  }

  @override
  void initState() {
    _controller = YoutubePlayerController(
      params: const YoutubePlayerParams(
        showControls: true,
        mute: false,
        showFullscreenButton: false,
        loop: false,
      ),
    )..onInit = _initVideo;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_controller.metadata.videoId != widget.contentUrl) {
      _initVideo();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        YoutubePlayerControllerProvider(
          controller: _controller,
          child: YoutubePlayer(
            aspectRatio: 16 / 9,
            controller: _controller,
          ),
        ),
        TextButton.icon(
          onPressed: () async {
            final videoUrl = await _controller.videoUrl;
            launchYoutubeVideo(videoUrl);
          },
          icon: const FaIcon(FontAwesomeIcons.youtube),
          label: Text(AppLocalizations.of(context)!.youtube_play),
          style: TextButton.styleFrom(
            foregroundColor: Theme.of(context).textTheme.titleLarge!.color,
          ),
        ),
      ],
    );
  }
}
