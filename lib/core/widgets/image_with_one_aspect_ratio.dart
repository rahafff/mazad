import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ImageWithAspectRatioOfOne extends StatelessWidget {
  const ImageWithAspectRatioOfOne({
    Key? key,
    required this.itemImage,
  }) : super(key: key);
  final String itemImage;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(2.0.w),
      child: AspectRatio(
        aspectRatio: 1,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5.0.w),
          child: Image.network(
            itemImage,
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}
