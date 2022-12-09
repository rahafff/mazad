import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import 'basic_overlay_widget.dart';

class FileVideoPlayer extends StatefulWidget {
  VideoPlayerController videoController;
   FileVideoPlayer({Key? key,required this.videoController}) : super(key: key);

  @override
  State<FileVideoPlayer> createState() => _FileVideoPlayerState();
}

class _FileVideoPlayerState extends State<FileVideoPlayer> {



  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: (){
        if (mounted) {
        setState (() => widget.videoController.value.isPlaying? widget.videoController.pause():widget.videoController.play());
        }
        },
      child: AspectRatio(aspectRatio: 1,
        child: Stack(
          alignment: Alignment.center,
          children: [
            AspectRatio(
              aspectRatio: widget.videoController.value.aspectRatio,
              child: VideoPlayer(widget.videoController),
            ),
            Positioned.fill(child: BasicOverlayWidget(videoController: widget.videoController,isVideoInAddProductScreen: false,)),
          ],
        ),
      ),
    );

  }
}
