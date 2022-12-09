import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/resources/color_manager.dart';
import '../../../../core/utils/global.dart';

class OrderTrackingDots extends StatelessWidget {
  final bool isPassed;

  const OrderTrackingDots({
    Key? key,
    this.isPassed = false,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: lang
          ? EdgeInsets.only(
              left: 19.0.w,
            )
          : EdgeInsets.only(
              right: 19.0.w,
            ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.circle,
            size: 3.0.w,
            color: isPassed ? ColorManager.kGreen : ColorManager.midumeGray,
          ),
          SizedBox(
            height: 1.0.h,
          ),
          Icon(
            Icons.circle,
            size: 3.0.w,
            color: isPassed ? ColorManager.kGreen : ColorManager.midumeGray,
          ),
        ],
      ),
    );
  }
}
