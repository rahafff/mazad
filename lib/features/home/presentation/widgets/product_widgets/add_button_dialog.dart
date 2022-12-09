import 'package:elite_auction/core/resources/color_manager.dart';
import 'package:elite_auction/core/widgets/sized_box_functions.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class BuildAddButtonDialog extends StatelessWidget {
  final VoidCallback onTappingSecondOption;
  final VoidCallback onTappingThirdOption;

  final String secondRowTitle;
  final String thirdRowTitle;

  final String secondRowIcon;
  final String thirdRowIcon;

  const BuildAddButtonDialog(
      {Key? key,
      required this.onTappingSecondOption,
      required this.onTappingThirdOption,
      required this.secondRowTitle,
      required this.thirdRowTitle,
      required this.secondRowIcon,
      required this.thirdRowIcon})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(7.0.w)),
      ),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: onTappingSecondOption,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(secondRowTitle),
                ImageIcon(
                  AssetImage(secondRowIcon),
                  color: ColorManager.kGreen,
                  size: 5.0.w,
                ),
              ],
            ),
          ),
          SizedBoxFunctions.verticalSizedBox(1),
          Divider(
            color: Colors.grey.withOpacity(0.3),
            height: 0.1.h,
            thickness: 2.0,
          ),
          SizedBoxFunctions.verticalSizedBox(1),
          GestureDetector(
            onTap: onTappingThirdOption,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(thirdRowTitle),
                ImageIcon(
                  AssetImage(thirdRowIcon),
                  color: ColorManager.kGreen,
                  size: 5.0.w,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
