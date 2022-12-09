
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:video_player/video_player.dart';

import '../../../../core/resources/color_manager.dart';
import '../../../../core/widgets/back_button.dart';
import '../../../../core/widgets/file_video_player.dart';
import '../../../../core/widgets/sized_box_functions.dart';

class PreviewVideoScreen extends StatefulWidget {
  VideoPlayerController videoController;
  PreviewVideoScreen({Key? key,
    required this.videoController
  }) : super(key: key);
  @override
  State<PreviewVideoScreen> createState() => _PreviewVideoScreenState();
}

class _PreviewVideoScreenState extends State<PreviewVideoScreen> {



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Video Preview'), //todo
        leading: const BackButtonWidget(),
      ),
      body: Column(
        children: [
          FileVideoPlayer( videoController:widget.videoController , ),
          SizedBoxFunctions.verticalSizedBox(7),
          SizedBox(width: 80.w,
            child: TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
              style: TextButton.styleFrom(
                  backgroundColor: ColorManager.kGreen,
                  foregroundColor: ColorManager.kWhite),
              child: Text(
                  "OK",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: ColorManager.kWhite),
                ),
            ),
          ),
        ],
      ),
    );
  }
}
