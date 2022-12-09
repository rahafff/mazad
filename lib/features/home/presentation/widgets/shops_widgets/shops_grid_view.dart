import 'package:elite_auction/features/home/domain/entities/shop_entity.dart';
import 'package:elite_auction/features/home/presentation/widgets/shops_widgets/shop_widget.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../../core/api/end_points.dart';
import '../../../../../core/resources/routes_manager.dart';

class ShopsGridView extends StatelessWidget {
  final List<ShopEntity?> shops;

  const ShopsGridView({Key? key, required this.shops}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const ScrollPhysics(),
      shrinkWrap: true,
      itemCount: shops.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 5.0.w,
        mainAxisSpacing: 3.0.h,
      ),
      padding: EdgeInsets.only(right: 3.0.w, left: 3.0.w, top: 5.0.h),
      itemBuilder: (BuildContext context, int index) {
        final shop = shops[index];
        if (index == (shops.length)) {
          return SizedBox(
            height: 4.5.h,
          );
        }
        return ShopWidget(
          onTappingShop: () {
            Navigator.pushNamed(
              context,
              Routes.shopRoute,
              arguments: ShopArguments(
                shop!.shopName.toString(),
                shop.id!.toInt(),
              ),
            );
          },
          shopImage: EndPoints.baseUrl + shop!.shopImage.toString(),
          shopName: shop.shopName.toString(),
        );
      },
    );
  }
}
