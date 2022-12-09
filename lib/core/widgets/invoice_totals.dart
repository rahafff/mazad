// import 'package:easy_localization/easy_localization.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:elite_auction/core/resources/strings_manager.dart';
import 'package:elite_auction/core/widgets/InfoRow.dart';
import 'package:elite_auction/core/widgets/constant_box_decorations_and_shadows.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../utils/global.dart';

class InvoiceTotals extends StatelessWidget {
  final String subTotal;
  final String totalAmount;
  final String deliveryFees;
  final Widget? totalAmountButton;

  const InvoiceTotals(
      {Key? key,
      required this.subTotal,
      required this.totalAmount,
      required this.deliveryFees,
      this.totalAmountButton})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ConstantBoxDecorationsAndShadows.RoundedBoxWithLightShadow,
      padding: EdgeInsets.symmetric(horizontal: 5.0.w, vertical: 3.h),
      child: Column(
        children: [
          Align(
            alignment: Alignment.center,
            child: Text(
              AppStrings.yourInvoice.tr(),
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ),
          InfoRow(
              title: AppStrings.subTotal, value: "$subTotal $appCurrency"),
          InfoRow(
              title: AppStrings.deliveryFees,
              value: "$deliveryFees $appCurrency"),
          InfoRow(
              title: AppStrings.totalAmount,
              value: "$totalAmount $appCurrency"),
          totalAmountButton ?? Container()
        ],
      ),
    );
  }
}
