import 'package:auto_size_text/auto_size_text.dart';
import 'package:elite_auction/core/resources/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/utils/global.dart';
import '../../../../core/widgets/build_reviews.dart';

class WishlistItemDetails extends StatelessWidget {
  const WishlistItemDetails({
    Key? key,
    required this.itemPrice,
    required this.itemName,
    this.discountRate,
    required this.reviewsCount,
    required this.reviewAverage,
    this.itemPriceAfterDiscount,
  }) : super(key: key);
  final String itemPrice;
  final String? itemPriceAfterDiscount;
  final int? discountRate;
  final String itemName;
  final int reviewsCount;
  final num reviewAverage;
  @override
  Widget build(BuildContext context) {
    return discountRate != null
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 30.0.w,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment:
                      lang ? Alignment.centerLeft : Alignment.centerRight,
                  child: AutoSizeText(itemName, // animalName,
                      style: Theme.of(context).textTheme.bodyText1),
                ),
              ),
              SizedBox(
                width: 30.0.w,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment:
                      lang ? Alignment.centerLeft : Alignment.centerRight,
                  child: RichText(
                    text: TextSpan(
                      text: '$itemPriceAfterDiscount',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(color: ColorManager.kGreen),
                      children: [
                        TextSpan(
                          text: " $appCurrency",
                          style: Theme.of(context)
                              .textTheme
                              .caption!
                              .copyWith(color: ColorManager.kGreen),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 30.0.w,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment:
                      lang ? Alignment.centerLeft : Alignment.centerRight,
                  child: RichText(
                    text: TextSpan(
                      text: itemPrice.toString(), //animalPrice.toString(),
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          color: ColorManager.kMove,
                          decoration: TextDecoration.lineThrough),
                      children: [
                        TextSpan(
                          text: " $appCurrency",
                          style: Theme.of(context).textTheme.caption!.copyWith(
                              color: ColorManager.kMove,
                              decoration: TextDecoration.lineThrough),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              BuildReviews(
                average: reviewAverage,
                reviews: reviewsCount,
                width: 25.0.w,
                starSize: 5.w,
              ),
            ],
          )
        : Column(
            // build details when there isn't any discount
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 30.0.w,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment:
                      lang ? Alignment.centerLeft : Alignment.centerRight,
                  child: AutoSizeText(
                    itemName, // animalName,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(
                width: 30.0.w,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment:
                      lang ? Alignment.centerLeft : Alignment.centerRight,
                  child: RichText(
                    text: TextSpan(
                      text: itemPrice.toString(),
                      style: Theme.of(context).textTheme.bodyText1,
                      children: [
                        TextSpan(
                            text: " $appCurrency",
                            style: Theme.of(context).textTheme.caption),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 2.9.h),
                child: BuildReviews(
                  average: reviewAverage,
                  reviews: reviewsCount,
                  width: 25.0.w,
                  starSize: 5.w,
                ),
              ),
            ],
          );
  }
}
