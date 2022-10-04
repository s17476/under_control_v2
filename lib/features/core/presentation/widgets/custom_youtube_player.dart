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
  String youtubeId = '';

  String _extractYoutubeId() {
    try {
      if (widget.contentUrl.contains('youtu.be')) {
        final index = widget.contentUrl.lastIndexOf('/');
        return widget.contentUrl.substring(index + 1);
      } else if (widget.contentUrl.contains('youtube.com/watch')) {
        final beginIndex = widget.contentUrl.indexOf('=');
        final endIndex = widget.contentUrl.indexOf('&');
        if (endIndex >= 0) {
          return widget.contentUrl.substring(beginIndex + 1, endIndex);
        } else {
          return widget.contentUrl.substring(beginIndex + 1);
        }
      } else {
        return widget.contentUrl;
      }
    } catch (e) {
      return '';
    }
  }

  void _initVideo() {
    youtubeId = _extractYoutubeId();
    _controller.cueVideoById(videoId: youtubeId);
  }

  @override
  void initState() {
    _controller = YoutubePlayerController(
      params: const YoutubePlayerParams(
        showControls: true,
        mute: false,
        showFullscreenButton: true,
        loop: false,
      ),
    )..onInit = _initVideo;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    youtubeId = _extractYoutubeId();
    if (_controller.metadata.videoId != youtubeId) {
      _initVideo();
    }
    return YoutubePlayerScaffold(
      controller: _controller,
      aspectRatio: 16 / 9,
      builder: (context, player) {
        return Column(
          children: [
            player,
            Text('Youtube Player'),
          ],
        );
      },
    );
  }
}
