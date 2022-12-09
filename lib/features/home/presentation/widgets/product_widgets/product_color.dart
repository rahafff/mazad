import 'package:elite_auction/core/resources/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ProductColor extends StatelessWidget {
  const ProductColor({
    Key? key,
    required this.color,
    required this.colorsName,
    required this.borderColor,
  }) : super(key: key);

  final String color;
  final Color borderColor;
  final String colorsName;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 20.0.w,
      margin: EdgeInsets.symmetric(horizontal: 1.0.w),
      decoration: BoxDecoration(
        border: Border.all(color: borderColor),
        borderRadius: BorderRadius.circular(3.0.w),
      ),
      padding: EdgeInsets.all(1.0.w),
      child: Column(
        children: [
          Expanded(
            flex: 3,
            child: Container(
              decoration: BoxDecoration(
                color: HexColor.fromHex(color),
                borderRadius: BorderRadius.circular(3.0.w),
              ),
            ),
          ),
          SizedBox(
            height: 1.0.h,
          ),
          Expanded(
            child: FittedBox(
              child: Text(
                colorsName,
                style: TextStyle(fontSize: 10.0.sp),
              ),
            ),
          )
        ],
      ),
    );
  }
}
