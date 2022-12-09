import 'package:easy_localization/easy_localization.dart';
import 'package:elite_auction/core/utils/global.dart';
import 'package:elite_auction/core/widgets/sized_box_functions.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../../../../../core/resources/strings_manager.dart';
import '../../../../../../../../core/widgets/constant_box_decorations_and_shadows.dart';
import '../../domain/entities/order_entity.dart';

class OrderPurchasedItems extends StatelessWidget {
  const OrderPurchasedItems({Key? key, required this.items}) : super(key: key);
  final List<Items> items;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ConstantBoxDecorationsAndShadows.RoundedBoxWithLightShadow,
      padding: EdgeInsets.symmetric(horizontal: 5.0.w, vertical: 3.h),
      child: Column(
        children: [
          Text(AppStrings.orderPurchasedItems.tr(),
              style: Theme.of(context).textTheme.subtitle2),
          SizedBoxFunctions.verticalSizedBox(1),
          Table(
            border: TableBorder.all(),
            columnWidths: const {
              0: FractionColumnWidth(0.48),
              1: FractionColumnWidth(0.3),
              2: FractionColumnWidth(0.22),
            },
            children: [
              TableRow(children: [
                Text(
                  AppStrings.name.tr(),
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                Text(AppStrings.price.tr(),
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center),
                Text(AppStrings.quantity.tr(),
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center),
              ]),
              for (var item in items)
                TableRow(children: [
                  Text(item.productName!,
                      style: Theme.of(context).textTheme.bodyText1,
                      textAlign: TextAlign.center),
                  item.discountRate != null
                      ? Text(item.productPriceAfterDiscount!,
                          style: Theme.of(context).textTheme.bodyText1,
                          textAlign: TextAlign.center)
                      : Text("${item.productPrice!} $appCurrency",
                          style: Theme.of(context).textTheme.bodyText1,
                          textAlign: TextAlign.center),
                  Text(item.productQuantity.toString(),
                      style: Theme.of(context).textTheme.bodyText1,
                      textAlign: TextAlign.center),
                ])
            ],
          ),
        ],
      ),
    );
  }
}
