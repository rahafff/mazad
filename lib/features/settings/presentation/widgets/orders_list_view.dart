import 'package:easy_localization/easy_localization.dart';
import 'package:elite_auction/core/resources/routes_manager.dart';
import 'package:elite_auction/core/resources/strings_manager.dart';
import 'package:elite_auction/core/widgets/constant_box_decorations_and_shadows.dart';
import 'package:elite_auction/features/settings/domain/entities/order_entity.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/resources/color_manager.dart';
import 'order_listview_item.dart';

class OrdersListView extends StatelessWidget {
  const OrdersListView({Key? key, required this.orders}) : super(key: key);
  final List<PaginatedOrderEntity?> orders;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: EdgeInsets.symmetric(vertical: 1.0.h, horizontal: 5.0.w),
        physics: const ScrollPhysics(),
        shrinkWrap: true,
        itemCount: orders.length,
        itemBuilder: (BuildContext context, index) {
          final order = orders[index];
          if (index == (orders.length)) {
            return SizedBox(
              height: 4.5.h,
            );
          }
          return OrderListViewItem(
            total: order!.orderTotal!,
            date: order.createdAt!,
            status: order.orderStatus!,
            statusCode: order.orderCode!,
            orderButton: GestureDetector(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  Routes.orderTrackRout,
                  arguments: OrderTrackArguments(
                    orderId: order.id!,
                    statusCode: order.orderStatus!,
                  ),
                );
              },
              child: Container(
                padding: EdgeInsets.all(2.0.w),
                decoration:
                    ConstantBoxDecorationsAndShadows.RoundedBoxWithLightShadow,
                child: Text(
                  AppStrings.track.tr(),
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2
                      ?.copyWith(color: ColorManager.kGreen),
                ),
              ),
            ),
          );
        });
  }
}
