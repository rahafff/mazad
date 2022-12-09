import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

import '../../../../../core/resources/color_manager.dart';

class ShimmerShopWidget extends StatelessWidget {
  const ShimmerShopWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorManager.kWhite,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 3,
            child: Shimmer.fromColors(
              baseColor: ColorManager.shimmerBaseColor,
              highlightColor: ColorManager.shimmerHighlightColor,
              child: Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: ColorManager.kWhite,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 2.h,
          ),
          Shimmer.fromColors(
            baseColor: ColorManager.shimmerBaseColor,
            highlightColor: ColorManager.shimmerHighlightColor,
            child: Container(
              width: 30.w,
              height: 2.h,
              color: ColorManager.kWhite,
            ),
          )
        ],
      ),
    );
  }
}
