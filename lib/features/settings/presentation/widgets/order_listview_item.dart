import 'package:easy_localization/easy_localization.dart';
import 'package:elite_auction/core/widgets/constant_box_decorations_and_shadows.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/resources/color_manager.dart';
import '../../../../core/resources/constant_backend_values.dart';
import '../../../../core/resources/strings_manager.dart';
import '../../../../core/utils/global.dart';

class OrderListViewItem extends StatelessWidget {
  OrderListViewItem({
    Key? key,
    required this.statusCode,
    required this.status,
    required this.total,
    required this.date,
    required this.orderButton,
  }) : super(key: key);

  final String statusCode;
  final String status;
  final String total;
  final String date;
  final Widget orderButton;
  final OrderStatus orderStatus = OrderStatus();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ConstantBoxDecorationsAndShadows.RoundedBoxWithLightShadow,
      margin: EdgeInsets.symmetric(vertical: 3.0.h),
      padding: EdgeInsets.symmetric(horizontal: 3.0.w, vertical: 3.0.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 40.0.w,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment:
                      lang ? Alignment.centerLeft : Alignment.centerRight,
                  child: Text("${AppStrings.statusCode.tr()} : $statusCode",
                      style: Theme.of(context).textTheme.subtitle2),
                ),
              ),
              SizedBox(
                width: 40.0.w,
                child: FittedBox(
                  alignment:
                      lang ? Alignment.centerRight : Alignment.centerLeft,
                  fit: BoxFit.scaleDown,
                  child: RichText(
                    text: TextSpan(
                      text: "${AppStrings.status.tr()} : ",
                      style: Theme.of(context).textTheme.bodyText1?.copyWith(
                            fontWeight: FontWeight.normal,
                            color: ColorManager.kBlack,
                          ),
                      children: [
                        TextSpan(
                          text: orderStatus.statusesNames[status]
                              ?.tr(), //todo translate
                          style:
                              Theme.of(context).textTheme.bodyText1?.copyWith(
                                    fontWeight: FontWeight.normal,
                                    color: orderStatus.statusesColors[status],
                                  ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Text('${AppStrings.total.tr()} : ${"$total $appCurrency"} ',
              style: Theme.of(context).textTheme.bodyText2),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('${AppStrings.date.tr()} $date',
                  style: Theme.of(context).textTheme.bodyText2),
              orderButton
            ],
          ),
        ],
      ),
    );
  }
}
