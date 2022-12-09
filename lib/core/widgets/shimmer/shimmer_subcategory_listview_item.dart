import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

import '../../../../../core/resources/color_manager.dart';

class ShimmerSubcategoryListviewItem extends StatelessWidget {
  const ShimmerSubcategoryListviewItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: ColorManager.shimmerBaseColor,
      highlightColor: ColorManager.shimmerHighlightColor,
      child: Container(
        width: 90.0.w,
        height: 20.0.h,
        margin: EdgeInsets.symmetric(vertical: 1.0.h),
        padding: EdgeInsets.all(1.0.w),
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: ColorManager.lightGray,
          borderRadius: BorderRadius.circular(3.0.w),
        ),
      ),
    );
  }
}
