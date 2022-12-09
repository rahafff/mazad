import 'package:easy_localization/easy_localization.dart';
import 'package:elite_auction/core/resources/color_manager.dart';
import 'package:elite_auction/core/resources/strings_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../../../../core/utils/global.dart';
import '../../../../../core/widgets/build_reviews.dart';
import '../../manager/product_variation_cubit.dart';
import 'build_add_to_wishlist_and_share_buttons.dart';

class ProductDetails extends StatelessWidget {
  final String productPrice;
  final String? productPriceAfterDiscount;
  final String? discountName;
  final String productName;
  final int? discountRate;
  final double? average;
  final int? reviews;

  const ProductDetails({
    Key? key,
    required this.productPrice,
    this.productPriceAfterDiscount,
    this.discountName,
    required this.productName,
    this.discountRate,
    this.average,
    this.reviews,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorManager.kWhite,
      padding: EdgeInsets.symmetric(horizontal: 5.0.w),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 55.0.w,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                alignment: lang ? Alignment.centerLeft : Alignment.centerRight,
                child: Text(
                  productName,
                  style: Theme.of(context)
                      .textTheme
                      .headline2
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const AddToWishListAndShareButtonsRow(),
          ],
        ),
        if (discountRate != null) ...[
          SizedBox(
            width: 30.0.w,
            child: FittedBox(
              alignment: lang ? Alignment.centerLeft : Alignment.centerRight,
              fit: BoxFit.scaleDown,
              child: Builder(builder: (context) {
                final variationPriceAfterDiscount = context
                    .watch<ProductVariationCubit>()
                    .state
                    .variationPriceAfterDiscount;
                return RichText(
                  text: TextSpan(
                    text: variationPriceAfterDiscount ??
                        productPriceAfterDiscount,
                    style: Theme.of(context).textTheme.subtitle2,
                    children: [
                      TextSpan(
                        text: ' ${appCurrency.toString().toUpperCase()}',
                        style: Theme.of(context)
                            .textTheme
                            .subtitle2
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                );
              }),
            ),
          ),
          Row(
            children: [
              SizedBox(
                width: 30.0.w,
                child: FittedBox(
                  alignment:
                      lang ? Alignment.centerLeft : Alignment.centerRight,
                  fit: BoxFit.scaleDown,
                  child: Builder(builder: (context) {
                    final variationPrice = context
                        .watch<ProductVariationCubit>()
                        .state
                        .variationPrice;
                    return RichText(
                      text: TextSpan(
                        text: variationPrice ?? productPrice,
                        style: Theme.of(context).textTheme.subtitle2!.copyWith(
                            decoration: TextDecoration.lineThrough,
                            color: ColorManager.grayText),
                        children: [
                          TextSpan(
                              text: ' ${appCurrency.toString().toUpperCase()}',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                      decoration: TextDecoration.lineThrough,
                                      color: ColorManager.grayText,
                                      fontWeight: FontWeight.bold)),
                        ],
                      ),
                    );  //price and currency
                  }),
                ),
              ),
              Container(
                padding: EdgeInsets.all(1.0.w),
                decoration: BoxDecoration(
                    color: ColorManager.kGreen.withAlpha(70),
                    borderRadius: BorderRadius.circular(5.0.w)),
                child: Text(
                  '${AppStrings.offer.tr()} $discountRate%',
                  style: const TextStyle(
                      color: ColorManager.kGreen, fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
        ] else
          Builder(builder: (context) {
            final variationPrice =
                context.watch<ProductVariationCubit>().state.variationPrice;
            print(variationPrice);
            return SizedBox(
              width: 30.0.w,
              child: FittedBox(
                alignment: lang ? Alignment.centerLeft : Alignment.centerRight,
                fit: BoxFit.scaleDown,
                child: RichText(
                  text: TextSpan(
                    text: variationPrice ?? productPrice,
                    style: Theme.of(context)
                        .textTheme
                        .subtitle2!
                        .copyWith(fontWeight: FontWeight.bold),
                    children: [
                      TextSpan(
                        text: ' ${appCurrency.toString().toUpperCase()}',
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
        BuildReviews(
          average: average,
          reviews: reviews,
          width: 30.0.w,
          fontSize: 16.0.sp,
          starSize: 10.0.w,
        ),
      ]),
    );
  }
}
