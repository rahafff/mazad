import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../resources/color_manager.dart';

class BuildIndicator extends StatelessWidget {
  const BuildIndicator({
    Key? key,
    required this.length,
    required this.index,
  }) : super(key: key);

  final int length;
  final int index;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorManager.kWhite,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: length != 0
            ? [
                for (int i = 0; i < length; i++)
                  Icon(
                    Icons.circle,
                    size: 3.0.w,
                    color: index == i
                        ? ColorManager.kGreen
                        : ColorManager.darkGrey,
                  ),
              ]
            : [
                /// indicator for the main image in case the list of additional images is null
                Container()
              ],
      ),
    );
  }
}
