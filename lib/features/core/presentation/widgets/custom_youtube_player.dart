import 'package:flutter/material.dart';
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
    return YoutubePlayerControllerProvider(
      controller: _controller,
      child: YoutubePlayer(
        aspectRatio: 16 / 9,
        controller: _controller,
      ),
    );
  }
}
