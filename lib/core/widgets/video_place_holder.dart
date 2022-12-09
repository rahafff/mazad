import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:video_player/video_player.dart';

import '../resources/color_manager.dart';
import 'basic_overlay_widget.dart';

class VideoPlaceHolder extends StatefulWidget {
  late final File? video;
  late final VideoPlayerController? videoController;
   VideoPlaceHolder({
    Key? key,
    this.video,
    this.videoController
  }) : super(key: key);
   VideoPlaceHolder.videoPlacer({
    Key? key,
    this.video,
    this.videoController
  }) : super(key: key);


  @override
  State<VideoPlaceHolder> createState() => _VideoPlaceHolderState();
}



class _VideoPlaceHolderState extends State<VideoPlaceHolder> {


  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: AspectRatio(
        aspectRatio: 1,
        child: Container(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3.0.w),
              color: ColorManager.lightGrayButtonColor),
          child: Stack(
                  alignment: Alignment.center,
                  children: [
                    LayoutBuilder(
                      builder: (context, constrains) {
                        return Icon(
                          Icons.video_camera_back_rounded,
                          color: ColorManager.midumeGray,
                          size: constrains.maxWidth / 4,
                        );
                      },
                    ),
                    if(widget!.video!=null)
                      GestureDetector(onTap: (){
                      if (mounted) {
                        setState (() => widget.videoController!.value.isPlaying? widget.videoController!.pause():widget.videoController!.play());
                      }
                    },
                        child: VideoPlayer(widget.videoController!)),
                    if(widget!.video!=null)
                      Positioned.fill(child: BasicOverlayWidget(videoController: widget.videoController!,isVideoInAddProductScreen: true,)),
                    // if(widget!.video!=null)
                    //   Positioned(right: 0,top: 0,
                    //   child: IconButton(icon: const Icon(Icons.close),alignment: Alignment.topRight,onPressed: (){
                    //       widget!.video=null;
                    //       setState(() {
                    //       });
                    //   }),
                    // ),
                  ],
                )
        ),
      ),
    );
  }
}



//
// Widget buildHolder(){
//   return  VideoPlayer(widget.videoController!);
// }
