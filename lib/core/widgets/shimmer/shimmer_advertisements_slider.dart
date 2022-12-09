import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

import '../../resources/color_manager.dart';

class ShimmerAdvertisementsSlider extends StatelessWidget {
  const ShimmerAdvertisementsSlider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemBuilder: (context, index, realIndex) {
        return Shimmer.fromColors(
          baseColor: ColorManager.shimmerBaseColor,
          highlightColor: ColorManager.shimmerHighlightColor,
          child: Container(
            height: 18.0.h,
            width: 90.0.w,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3.0.w),
                color: ColorManager.kWhite),
          ),
        );
      },
      options: CarouselOptions(
        height: 15.0.h,
        aspectRatio: 9 / 16,
        viewportFraction: 1,
        enableInfiniteScroll: true,
        reverse: false,
        autoPlay: false,
        enlargeCenterPage: true,
        scrollDirection: Axis.horizontal,
      ),
      itemCount: 1,
    );
  }
}
