import 'package:elite_auction/core/resources/routes_manager.dart';
import 'package:elite_auction/features/home/domain/entities/categories_entity.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../../core/api/end_points.dart';
import '../../../../../core/resources/color_manager.dart';
import '../../../../../core/utils/global.dart';
import '../../../../../core/widgets/constant_box_decorations_and_shadows.dart';

class CategoriesGridItem extends StatelessWidget {
  const CategoriesGridItem({Key? key, required this.category})
      : super(key: key);
  final Category category;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, Routes.subcategories,
            arguments:
                SubcategoriesArguments(category.categoryName!, category.id!));
      },
      child: Container(
        padding: EdgeInsets.all(1.0.w),
        decoration: BoxDecoration(
            image: DecorationImage(
              image: ExtendedNetworkImageProvider(
                EndPoints.baseUrl + category.categoryImage!,
              ),
              fit: BoxFit.fill,
            ),
            borderRadius: BorderRadius.circular(2.0.w),
            color: ColorManager.kWhite,
            boxShadow: [ConstantBoxDecorationsAndShadows.lightShadow]),
        child: SizedBox(
          width: 20.0.w,
          child: Align(
            alignment: lang ? Alignment.bottomLeft : Alignment.bottomLeft,
            child: Text(
              category.categoryName!,
              softWrap: true,
              style: Theme.of(context)
                  .textTheme
                  .bodyText2!
                  .copyWith(color: ColorManager.kGreen),
            ),
          ),
        ),
      ),
    );
  }
}
