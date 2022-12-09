import 'package:elite_auction/core/widgets/shimmer/shimmer_order_list_view_item.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ShimmerOrdersListView extends StatelessWidget {
  const ShimmerOrdersListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: EdgeInsets.symmetric(vertical: 1.0.h, horizontal: 5.0.w),
        physics: const ScrollPhysics(),
        shrinkWrap: true,
        itemCount: 8,
        itemBuilder: (BuildContext context, index) {
          return const ShimmerOrderListViewItem();
        });
  }
}
