import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ProductSize extends StatelessWidget {
  const ProductSize({
    Key? key,
    required this.size,
    required this.borderColor,
  }) : super(key: key);

  final String size;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 30.0.w,
      margin: EdgeInsets.symmetric(horizontal: 1.0.w),
      decoration: BoxDecoration(
        border: Border.all(color: borderColor),
        borderRadius: BorderRadius.circular(3.0.w),
      ),
      padding: EdgeInsets.all(1.0.w),
      child: Center(
        child: FittedBox(
          child: Text(
            size,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 10.sp),
          ),
        ),
      ),
    );
  }
}
