import 'package:cached_video_player/cached_video_player.dart';
import 'package:flutter/material.dart';

class VideoPlayerItem extends StatefulWidget {
  final String videoUrl;
  const VideoPlayerItem({Key? key, required this.videoUrl}) : super(key: key);

  @override
  State<VideoPlayerItem> createState() => _VideoPlayerItemState();
}

class _VideoPlayerItemState extends State<VideoPlayerItem> {
  late CachedVideoPlayerController cachedVideoPlayerController;
  bool isPlay = false;

  @override
  void initState() {
    super.initState();
    cachedVideoPlayerController =
        CachedVideoPlayerController.network(widget.videoUrl)
          ..initialize().then((value) {
            cachedVideoPlayerController.setVolume(1);
          });
  }

  @override
  void dispose() {
    super.dispose();
    cachedVideoPlayerController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Stack(children: [
        CachedVideoPlayer(cachedVideoPlayerController),
        Align(
            alignment: Alignment.center,
            child: IconButton(
                onPressed: () {
                  if (isPlay) {
                    cachedVideoPlayerController.pause();
                  } else {
                    cachedVideoPlayerController.play();
                  }

                  setState(() {
                    isPlay = !isPlay;
                  });
                },
                icon: !isPlay
                    ? const Icon(Icons.play_circle)
                    : const Icon(Icons.pause_circle)))
      ]),
    );
  }
}
