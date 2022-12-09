import 'package:elite_auction/core/widgets/constant_box_decorations_and_shadows.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

import '../../resources/color_manager.dart';

class ShimmerOrderListViewItem extends StatelessWidget {
  const ShimmerOrderListViewItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ConstantBoxDecorationsAndShadows.RoundedBoxWithLightShadow,
      margin: EdgeInsets.symmetric(vertical: 3.0.h),
      padding: EdgeInsets.symmetric(horizontal: 3.0.w, vertical: 3.0.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Shimmer.fromColors(
                highlightColor: ColorManager.shimmerHighlightColor,
                baseColor: ColorManager.shimmerBaseColor,
                child: Container(
                  width: 40.0.w,
                  color: ColorManager.kWhite,
                ),
              ),
              Shimmer.fromColors(
                highlightColor: ColorManager.shimmerHighlightColor,
                baseColor: ColorManager.shimmerBaseColor,
                child: Container(
                  width: 40.0.w,
                  color: ColorManager.kWhite,
                ),
              ),
            ],
          ),
          Shimmer.fromColors(
            highlightColor: ColorManager.shimmerHighlightColor,
            baseColor: ColorManager.shimmerBaseColor,
            child: Container(
              width: 30.0.w,
              color: ColorManager.kWhite,
            ),
          ),
          Shimmer.fromColors(
            highlightColor: ColorManager.shimmerHighlightColor,
            baseColor: ColorManager.shimmerBaseColor,
            child: Container(
              width: 40.0.w,
              color: ColorManager.kWhite,
            ),
          ),
        ],
      ),
    );
  }
}
