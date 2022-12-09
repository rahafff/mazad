import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

import '../../../../../core/resources/color_manager.dart';

class SubcategoryGridViewItem extends StatelessWidget {
  const SubcategoryGridViewItem({
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
            Expanded(
              flex: 3,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: ColorManager.kWhite,
                  boxShadow: const [
                    BoxShadow(
                      offset: Offset(0, 4),
                      blurRadius: 2,
                      color: Colors.grey,
                    )
                  ],
                  image: DecorationImage(
                      image: ExtendedNetworkImageProvider(
                        subcategoryImage,
                      ),
                      fit: BoxFit.fill),
                ),
              ),
            ),
            Expanded(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  subcategoryName.toUpperCase(),
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      ?.copyWith(color: ColorManager.kGreen),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
