import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../resources/color_manager.dart';

class ImagePlaceHolder extends StatefulWidget {
   ImagePlaceHolder({
    Key? key,
    this.image,
     required this.index,
  }) : super(key: key);
   ImagePlaceHolder.imagePlacer({Key? key, required this.image,required this.index})
      : super(key: key);
  late final File? image;
   int index;

  @override
  State<ImagePlaceHolder> createState() => _ImagePlaceHolderState();
}

class _ImagePlaceHolderState extends State<ImagePlaceHolder> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 0.5.w),
        child: AspectRatio(
          aspectRatio: 1,
          child: Container(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3.0.w),
                color: ColorManager.lightGrayButtonColor),
            child:Stack(alignment: Alignment.center,
              children: [
                LayoutBuilder(
                  builder: (context, constrains) {
                    return Icon(
                      Icons.perm_media,
                      color: ColorManager.midumeGray,
                      size: constrains.maxWidth / 4,
                    );
                  },
                ),
                AspectRatio(aspectRatio: 1,
                  child: Image.file(
                          File(widget.image!.path),
                          fit: BoxFit.fill,
                        ),
                ),
                // Positioned(right: 0,top: 0,
                //   child: IconButton(icon: const Icon(Icons.close),alignment: Alignment.topRight,onPressed: (){
                //     if(widget.image!=null) {
                //       widget.image==null;
                //       // assets.removeAt(widget.index);
                //       if (kDebugMode) {
                //         print( widget.image);
                //       }
                //       setState(() {
                //       });
                //     }
                //     else null;
                //   }),
                // ),
              ],
            )
                  ),
          ),
      ),
    );
  }
}


Widget  buildHolder({bool? isMainImage=false}){
  return Expanded(
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 0.5.w),
      child: AspectRatio(
        aspectRatio: 1,
        child: Container(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3.0.w),
              color: ColorManager.lightGrayButtonColor),
          child: LayoutBuilder(
            builder: (context, constrains) {
              return Icon(
                isMainImage==true? Icons.camera_alt_rounded: Icons.perm_media,
                color: ColorManager.midumeGray,
                size: constrains.maxWidth / 4,
              );
            },
          ),
        ),
      ),
    ),
  );
}

