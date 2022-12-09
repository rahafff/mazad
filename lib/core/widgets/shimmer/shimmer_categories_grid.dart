import 'package:elite_auction/core/widgets/shimmer/shimmer_categories_grid_item.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ShimmerCategoriesGrid extends StatelessWidget {
  const ShimmerCategoriesGrid({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 6,
      padding: EdgeInsets.symmetric(horizontal: 2.5.w),
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        return const ShimmerCategoriesGridItem();
      },
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 5.0.w,
        mainAxisSpacing: 3.0.h,
        childAspectRatio: 1,
      ),
    );
  }
}
