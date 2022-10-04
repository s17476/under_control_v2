import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

class CustomVideoPlayer extends StatefulWidget {
  const CustomVideoPlayer({
    Key? key,
    this.videoFile,
    this.videoUrl,
    this.videoPlayerController,
  }) : super(key: key);

  final File? videoFile;
  final String? videoUrl;
  final VideoPlayerController? videoPlayerController;

  @override
  State<CustomVideoPlayer> createState() => _CustomVideoPlayerState();
}

class _CustomVideoPlayerState extends State<CustomVideoPlayer> {
  VideoPlayerController? _videoPlayerController;
  bool _isInitialized = false;
  bool _finishedPlaying = false;

  Future<void> _initVideo() async {
    if (widget.videoPlayerController != null) {
      _videoPlayerController = widget.videoPlayerController;
      setState(() {
        _isInitialized = true;
      });
    } else if (widget.videoUrl != null && widget.videoUrl!.isNotEmpty) {
      _videoPlayerController = VideoPlayerController.network(widget.videoUrl!);
      await _videoPlayerController!.initialize();
      setState(() {
        _isInitialized = true;
      });
    } else if (widget.videoFile != null) {
      _videoPlayerController = VideoPlayerController.file(widget.videoFile!);
      await _videoPlayerController!.initialize();
      setState(() {
        _isInitialized = true;
      });
    }
    if (_videoPlayerController != null) {
      _videoPlayerController!.addListener(() {
        if (_videoPlayerController!.value.duration ==
            _videoPlayerController!.value.position) {
          setState(() {
            _finishedPlaying = true;
          });
        } else {
          setState(() {
            _finishedPlaying = false;
          });
        }
      });
    }
  }

  void _togglePlay() {
    setState(() {
      // If the video is playing, pause it.
      if (_videoPlayerController!.value.isPlaying) {
        _videoPlayerController!.pause();
      } else {
        // If the video is paused, play it.
        _videoPlayerController!.play();
      }
    });
  }

  void _toggleFullScreen() {
    if (widget.videoPlayerController != null) {
      Navigator.pop(context);
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CustomVideoPlayer(
            videoFile: widget.videoFile,
            videoUrl: widget.videoUrl,
            videoPlayerController: _videoPlayerController,
          ),
        ),
      );
    }
  }

  @override
  void initState() {
    _initVideo();
    if (widget.videoPlayerController != null) {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
        DeviceOrientation.landscapeRight,
        DeviceOrientation.landscapeLeft,
      ]);
    }
    super.initState();
  }

  @override
  void dispose() {
    if (widget.videoPlayerController == null) {
      _videoPlayerController?.dispose();
    }
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // update controller
    if (_isInitialized) {
      final filePath = widget.videoFile!.path;
      final controllerPath = _videoPlayerController!.dataSource
          .replaceFirst(RegExp('file://'), '');
      if (filePath != controllerPath) {
        _initVideo();
      }

      return Stack(
        children: [
          // player
          Center(
            child: GestureDetector(
              onTap: _togglePlay,
              onDoubleTap: _toggleFullScreen,
              child: AspectRatio(
                aspectRatio: _videoPlayerController!.value.aspectRatio,
                child: VideoPlayer(_videoPlayerController!),
              ),
            ),
          ),
          // progress bar
          Positioned(
            bottom: 0,
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: _togglePlay,
                  icon: Icon(
                    _finishedPlaying
                        ? Icons.replay
                        : _videoPlayerController!.value.isPlaying
                            ? Icons.pause
                            : Icons.play_arrow,
                    size: 40,
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    height: 15,
                    child: VideoProgressIndicator(
                      _videoPlayerController!,
                      allowScrubbing: true,
                      colors: const VideoProgressColors(
                        backgroundColor: Colors.blueGrey,
                        bufferedColor: Colors.blueGrey,
                        playedColor: Colors.blueAccent,
                      ),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: _toggleFullScreen,
                  icon: Icon(
                    widget.videoPlayerController == null
                        ? Icons.fullscreen
                        : Icons.fullscreen_exit,
                    size: 40,
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    } else {
      return Container(
        alignment: Alignment.center,
        height: 200,
        width: double.infinity,
        child: const CircularProgressIndicator(),
      );
    }
  }
}
