import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../../core/resources/color_manager.dart';

class SubsubcategoryListviewItem extends StatelessWidget {
  const SubsubcategoryListviewItem({
    Key? key,
    required this.subcategoryName,
    required this.subcategoryImage,
    required this.onTappingSubcategory,

  }) : super(key: key);

  final String subcategoryName;
  final String subcategoryImage;
  final VoidCallback? onTappingSubcategory;


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTappingSubcategory,
      child: Container(
        color: ColorManager.kWhite,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
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
                color: ColorManager.lightGray,
                image: DecorationImage(
                    image: ExtendedNetworkImageProvider(
                      subcategoryImage,
                    ),
                    fit: BoxFit.fill),
                  borderRadius: BorderRadius.circular(3.0.w)
              ),
            ),
            // FittedBox(
            //   fit: BoxFit.scaleDown,
            //   child: Text(
            //     subcategoryName.toUpperCase(),
            //     textAlign: TextAlign.center,
            //     style: Theme.of(context)
            //         .textTheme
            //         .bodyText1
            //         ?.copyWith(color: ColorManager.kGreen),
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
