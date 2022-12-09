import 'package:elite_auction/core/widgets/shimmer/shimmer_shop_widget.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ShimmerShopsGridView extends StatelessWidget {
  const ShimmerShopsGridView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const ScrollPhysics(),
      shrinkWrap: true,
      itemCount: 8,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 5.0.w,
        mainAxisSpacing: 3.0.h,
      ),
      padding: EdgeInsets.only(right: 3.0.w, left: 3.0.w, top: 5.0.h),
      itemBuilder: (BuildContext context, int index) {
        return const ShimmerShopWidget();
      },
    );
  }
}
