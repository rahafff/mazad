import 'package:badges/badges.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../../core/resources/color_manager.dart';

class SubcategoryListviewItem extends StatelessWidget {
  const SubcategoryListviewItem(
      {Key? key,
      required this.onTappingSubcategory,
      required this.subcategoryImage,
      required this.subcategoryName,
      this.onTappingAdd})
      : super(key: key);
  final VoidCallback onTappingSubcategory;
  final VoidCallback? onTappingAdd;
  final String subcategoryImage;
  final String subcategoryName;
  @override
  Widget build(BuildContext context) {
    return Badge(
      badgeContent: IconButton(
        onPressed: onTappingAdd,
        icon: const Icon(Icons.add, color: ColorManager.kWhite),
      ),
      badgeColor: ColorManager.kGreen,
      elevation: 3,
      position: BadgePosition.bottomStart(),
      showBadge: onTappingAdd != null,
      padding: EdgeInsets.all(0.1.w),
      child: GestureDetector(
        onTap: onTappingSubcategory,
        child: Container(
          height: 20.h,
          margin: EdgeInsets.symmetric(vertical: 2.0.h),
          padding: EdgeInsets.all(1.0.w),
          decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(
                  offset: Offset(0, 4),
                  blurRadius: 2,
                  color: Colors.grey,
                )
              ],
              shape: BoxShape.rectangle,
              image: DecorationImage(
                fit: BoxFit.fill,
                image: ExtendedNetworkImageProvider(
                  subcategoryImage,
                ),
              ),
              color: ColorManager.lightGray,
              borderRadius: BorderRadius.circular(3.0.w)
          ),
        ),
      ),
    );
  }
}
