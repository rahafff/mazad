import 'package:elite_auction/core/widgets/shimmer/shimmer_product_card.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ShimmerProductsGridView extends StatelessWidget {
  const ShimmerProductsGridView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 8,
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 0.7,
            crossAxisCount: 2,
            crossAxisSpacing: 3.0.w,
            mainAxisSpacing: 2.0.h),
        padding: EdgeInsets.only(left: 3.0.w, right: 3.0.w, top: 2.0.h),
        itemBuilder: (BuildContext context, int index) {
          return ShimmerProductCard();
        });
  }
}
