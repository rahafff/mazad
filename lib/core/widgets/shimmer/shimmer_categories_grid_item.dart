import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

import '../../../../../core/resources/color_manager.dart';
import '../../../../../core/widgets/constant_box_decorations_and_shadows.dart';

class ShimmerCategoriesGridItem extends StatelessWidget {
  const ShimmerCategoriesGridItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: ColorManager.shimmerBaseColor,
      highlightColor: ColorManager.shimmerHighlightColor,
      child: Container(
        padding: EdgeInsets.all(1.0.w),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2.0.w),
            color: ColorManager.kWhite,
            boxShadow: [ConstantBoxDecorationsAndShadows.lightShadow]),
      ),
    );
  }
}
