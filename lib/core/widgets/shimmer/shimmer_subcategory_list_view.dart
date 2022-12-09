import 'package:elite_auction/core/widgets/shimmer/shimmer_subcategory_listview_item.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ShimmerSubcategoryListView extends StatelessWidget {
  const ShimmerSubcategoryListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const AlwaysScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: EdgeInsets.symmetric(horizontal: 5.0.w, vertical: 4.0.h),
      itemCount: 8,
      itemBuilder: (BuildContext context, int index) {
        return const ShimmerSubcategoryListviewItem();
      },
    );
  }
}
