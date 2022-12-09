import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/resources/color_manager.dart';
import '../../../../core/utils/global.dart';
import '../../../../core/widgets/constant_box_decorations_and_shadows.dart';

class OrderStatusBox extends StatelessWidget {
  final bool orderStatus;
  final String orderStatusTitle;
  final String orderStatusDescription;
  const OrderStatusBox(
      {Key? key,
      this.orderStatus = false,
      required this.orderStatusTitle,
      required this.orderStatusDescription})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 35.0.w,
            height: 10.0.h,
            margin: lang
                ? EdgeInsets.only(right: 2.0.w)
                : EdgeInsets.only(left: 2.0.w),
            padding: EdgeInsets.symmetric(horizontal: 5.0.w),
            decoration: BoxDecoration(
                color: orderStatus == true
                    ? ColorManager.kGreen
                    : ColorManager.kWhite,
                borderRadius: BorderRadius.circular(5.0.w),
                boxShadow: [ConstantBoxDecorationsAndShadows.lightShadow]),
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                orderStatusTitle,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: lang ? 'Walter_Becker' : 'Farsi_Far_Tow',
                    fontSize: 14.0.sp,
                    color: orderStatus == true
                        ? ColorManager.kWhite
                        : ColorManager.kMove),
              ),
            ),
          ),
          Container(
            width: 40.0.w,
            height: 15.0.h,
            padding: EdgeInsets.symmetric(vertical: 2.0.h),
            child: Align(
              alignment: lang ? Alignment.centerLeft : Alignment.centerRight,
              child: AutoSizeText(
                orderStatusDescription,
                maxLines: 3,
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontFamily: lang ? 'Walter_Becker' : 'Farsi_Far_Tow',
                  fontSize: 12.0.sp,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
