import 'package:badges/badges.dart';
import 'package:elite_auction/core/resources/color_manager.dart';
import 'package:elite_auction/core/widgets/sized_box_functions.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/widgets/constant_box_decorations_and_shadows.dart';

class ShimmerProductCard extends StatelessWidget {
  ShimmerProductCard({
    Key? key,
  }) : super(key: key);
  final height = 1.h;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width / 4;
    return Badge(
      position: BadgePosition(bottom: 1.h, end: 1.w),
      badgeColor: ColorManager.shimmerBaseColor,
      badgeContent: Shimmer.fromColors(
        baseColor: ColorManager.shimmerBaseColor,
        highlightColor: ColorManager.shimmerHighlightColor,
        child: Container(
          decoration: const BoxDecoration(
            color: ColorManager.kWhite,
            shape: BoxShape.circle,
          ),
          width: 7.w,
          height: 7.w,
        ),
      ),
      child: Container(
        decoration:
            ConstantBoxDecorationsAndShadows.RoundedBoxWithLightShadow.copyWith(
          borderRadius: BorderRadius.all(
            Radius.circular(3.0.w),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: Shimmer.fromColors(
                baseColor: ColorManager.shimmerBaseColor,
                highlightColor: ColorManager.shimmerHighlightColor,
                child: Container(
                  decoration: ConstantBoxDecorationsAndShadows
                      .RoundedBoxWithLightShadow.copyWith(
                    color: ColorManager.kWhite,
                    borderRadius: BorderRadius.all(
                      Radius.circular(3.0.w),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBoxFunctions.verticalSizedBox(1),
                  Expanded(
                    child: Shimmer.fromColors(
                      baseColor: ColorManager.shimmerBaseColor,
                      highlightColor: ColorManager.shimmerHighlightColor,
                      child: Container(
                        color: ColorManager.kWhite,
                        height: height,
                        width: width,
                      ),
                    ),
                  ),
                  SizedBoxFunctions.verticalSizedBox(1),
                  Expanded(
                    child: Shimmer.fromColors(
                      baseColor: ColorManager.shimmerBaseColor,
                      highlightColor: ColorManager.shimmerHighlightColor,
                      child: Container(
                        color: ColorManager.kWhite,
                        height: height,
                        width: width,
                      ),
                    ),
                  ),
                  SizedBoxFunctions.verticalSizedBox(1),
                  Expanded(
                    child: Shimmer.fromColors(
                      baseColor: ColorManager.shimmerBaseColor,
                      highlightColor: ColorManager.shimmerHighlightColor,
                      child: Container(
                        color: ColorManager.kWhite,
                        height: height,
                        width: width,
                      ),
                    ),
                  ),
                  SizedBoxFunctions.verticalSizedBox(1),
                  Expanded(
                    child: Shimmer.fromColors(
                      baseColor: ColorManager.shimmerBaseColor,
                      highlightColor: ColorManager.shimmerHighlightColor,
                      child: Container(
                        color: ColorManager.kWhite,
                        height: height,
                        width: width,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
