import 'package:elite_auction/core/resources/color_manager.dart';
import 'package:elite_auction/core/utils/global.dart';
import 'package:elite_auction/core/widgets/sized_box_functions.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'constant_box_decorations_and_shadows.dart';

class AddAndMinusWidget extends StatelessWidget {
  final VoidCallback removeItem;
  final VoidCallback addItem;
  final int itemCount;
  final BoxDecoration buttonDecoration = BoxDecoration(
    boxShadow: [ConstantBoxDecorationsAndShadows.lightShadow],
    shape: BoxShape.circle,
    color: ColorManager.kWhite,
  );
  final int maxQuantity;
  final double iconSize = 7.w;

  AddAndMinusWidget({
    Key? key,
    required this.removeItem,
    required this.addItem,
    required this.itemCount,
    required this.maxQuantity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 25.w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          itemCount > 1
              ? _activeButton(Icons.remove, removeItem)
              : _inactiveButton(Icons.remove),
          SizedBoxFunctions.horizontalSizedBox(1),
          Flexible(
            child: Text(
              itemCount.toString(),
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          SizedBoxFunctions.horizontalSizedBox(1),
          itemCount < maxQuantity
              ? _activeButton(Icons.add, addItem)
              : _inactiveButton(Icons.add),
        ],
      ),
    );
  }

  _activeButton(IconData icon, VoidCallback onTap) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.all(0.1.w),
          decoration: buttonDecoration,
          child: Icon(
            icon,
            color: isTokenExist ? ColorManager.kGreen : ColorManager.lightGray,
            size: iconSize,
          ),
        ),
      ),
    );
  }

  _inactiveButton(IconData icon) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(0.1.w),
        decoration: buttonDecoration,
        child: Icon(
          icon,
          color: ColorManager.lightGray,
          size: iconSize,
        ),
      ),
    );
  }
}
