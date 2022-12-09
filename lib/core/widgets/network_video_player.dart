import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import 'basic_overlay_widget.dart';

class NetworkVideoPlayer extends StatefulWidget {
  final String videoURL;
  const NetworkVideoPlayer({Key? key,required this.videoURL,}) : super(key: key);

  @override
  State<NetworkVideoPlayer> createState() => _NetworkVideoPlayerState();
}

class _NetworkVideoPlayerState extends State<NetworkVideoPlayer> {
  late VideoPlayerController videoController;

  @override void initState() {
     videoController=VideoPlayerController.network(widget.videoURL)..addListener(() => setState(() {
    }))..setLooping(true)..initialize().then((value) {videoController.play();});
    super.initState();
  }

  @override void dispose() {
    videoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: (){
        setState(() {
        });
        videoController.value.isPlaying? videoController.pause():videoController.play();},
      child: AspectRatio(aspectRatio: 1,
        child: Stack(
          alignment: Alignment.center,
          children: [
            AspectRatio(
              aspectRatio: videoController.value.aspectRatio,
              child: VideoPlayer(videoController),
            ),
            Positioned.fill(child: BasicOverlayWidget(videoController: videoController,isVideoInAddProductScreen: false,)),
          ],
        ),
      ),
    );

  }
}
