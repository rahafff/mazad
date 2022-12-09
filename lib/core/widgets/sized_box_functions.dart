import 'package:flutter/cupertino.dart';
import 'package:sizer/sizer.dart';

class SizedBoxFunctions {
  static SizedBox verticalSizedBox(double height) {
    return SizedBox(
      height: height.h,
    );
  }

  static SizedBox horizontalSizedBox(double width) {
    return SizedBox(
      width: width.w,
    );
  }
}
