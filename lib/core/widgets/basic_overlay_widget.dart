import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:video_player/video_player.dart';

import '../resources/color_manager.dart';

class BasicOverlayWidget extends StatefulWidget {
  final VideoPlayerController videoController;
    bool isVideoInAddProductScreen=false;

   BasicOverlayWidget({
     Key? key,
    required this.isVideoInAddProductScreen,
    required this.videoController,
  }) : super(key: key);

  @override
  State<BasicOverlayWidget> createState() => _BasicOverlayWidgetState();
}

class _BasicOverlayWidgetState extends State<BasicOverlayWidget> {



  @override
  Widget build(BuildContext context) => AspectRatio(aspectRatio: 1,
    child: GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        widget.videoController.value.isPlaying ? widget.videoController.pause() : widget.videoController.play();
        setState(() {
        });
      },
      child: Stack(
        children: <Widget>[
          buildPlay(),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: buildIndicator(),
          ),
        ],
      ),
    ),
  );

  Widget buildIndicator() {
    setState(() {
    });
    return VideoProgressIndicator(
      widget.videoController,
      allowScrubbing: true,
      colors: VideoProgressColors(playedColor: ColorManager.kMove,),
    );
  }

  Widget buildPlay() {
    setState(() {
    });
    return widget.videoController.value.isPlaying
        ? Container()
        : Container(
      alignment: Alignment.center,
      color: Colors.black26,
      child:  CircleAvatar(backgroundColor:Colors.white.withOpacity(0.3) ,
          child: Icon(Icons.play_arrow, color: Colors.white, size: widget.isVideoInAddProductScreen!? 8.w: 10.w )),
    );
  }
}