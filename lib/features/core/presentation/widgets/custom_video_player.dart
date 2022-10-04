import 'dart:io';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class CustomVideoPlayer extends StatefulWidget {
  const CustomVideoPlayer({
    Key? key,
    this.videoFile,
    this.videoUrl,
  }) : super(key: key);

  final File? videoFile;
  final String? videoUrl;

  @override
  State<CustomVideoPlayer> createState() => _CustomVideoPlayerState();
}

class _CustomVideoPlayerState extends State<CustomVideoPlayer> {
  VideoPlayerController? _videoPlayerController;
  bool _isInitialized = false;
  bool _finishedPlaying = false;

  Future<void> _initVideo() async {
    if (widget.videoUrl != null && widget.videoUrl!.isNotEmpty) {
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

  @override
  void initState() {
    _initVideo();
    super.initState();
  }

  @override
  void dispose() {
    _videoPlayerController?.dispose();
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
          AspectRatio(
            aspectRatio: _videoPlayerController!.value.aspectRatio,
            child: VideoPlayer(_videoPlayerController!),
          ),

          // button
          FloatingActionButton(
            onPressed: () {
              // Wrap the play or pause in a call to `setState`. This ensures the
              // correct icon is shown.
              setState(() {
                // If the video is playing, pause it.
                if (_videoPlayerController!.value.isPlaying) {
                  _videoPlayerController!.pause();
                } else {
                  // If the video is paused, play it.
                  _videoPlayerController!.play();
                }
              });
            },
            // Display the correct icon depending on the state of the player.
            child: Icon(
              _videoPlayerController!.value.isPlaying
                  ? Icons.pause
                  : Icons.play_arrow,
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
                  onPressed: () {
                    // Wrap the play or pause in a call to `setState`. This ensures the
                    // correct icon is shown.
                    setState(() {
                      // If the video is playing, pause it.
                      if (_videoPlayerController!.value.isPlaying) {
                        _videoPlayerController!.pause();
                      } else {
                        // If the video is paused, play it.
                        _videoPlayerController!.play();
                      }
                    });
                  },
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
                  child: Container(
                    padding: const EdgeInsets.only(right: 40),
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
              ],
            ),
          ),
        ],
      );
    } else {
      return const CircularProgressIndicator();
    }
  }
}
