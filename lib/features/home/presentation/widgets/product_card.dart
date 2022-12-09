import 'package:badges/badges.dart';
import 'package:elite_auction/core/resources/color_manager.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/utils/global.dart';
import '../../../../core/widgets/build_reviews.dart';
import '../../../../core/widgets/constant_box_decorations_and_shadows.dart';

class ProductCard extends StatelessWidget {
  final String animalName;
  final String animalImage;
  final String animalPrice;
  final String? animalPriceAfterDiscount;
  final int? reviewsCount;
  final double? reviewAverage;
  final VoidCallback? onTappingAddButton;
  final VoidCallback? onTappingShareButton;
  final VoidCallback onTappingProduct;
  final int? discountRate;

  const ProductCard(
      {Key? key,
      required this.animalName,
      required this.animalImage,
      required this.animalPrice,
      this.animalPriceAfterDiscount,
      this.reviewsCount,
      this.reviewAverage,
      this.onTappingAddButton,
      this.onTappingShareButton,
      required this.onTappingProduct,
      this.discountRate})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Badge(
      position: BadgePosition(top: 1.h, end: 1.w),
      badgeColor: Colors.red,
      shape: BadgeShape.circle,
      showBadge: discountRate != null,
      badgeContent: _buildDiscountText(context),
      child: Badge(
        position: BadgePosition(bottom: 1.h, end: 1.w),



        badgeColor: ColorManager.kGreen,
        badgeContent: _buildBadgeContent(),
        child: GestureDetector(
          onTap: onTappingProduct,
          child: Container(
            // clipBehavior: Clip.antiAliasWithSaveLayer,
            decoration: ConstantBoxDecorationsAndShadows
                .RoundedBoxWithLightShadow.copyWith(
              // borderRadius: BorderRadius.all(
              //   Radius.circular(3.0.w),
              // ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: ExtendedImage.network(
                    animalImage,
                    fit: BoxFit.fill,
                    width: double.infinity,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(3.0.w) ,topRight: Radius.circular(3.0.w) ),
                    cacheWidth: 500,
                    cacheHeight: 500,
                    enableMemoryCache: true,
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 2.0.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          alignment: lang
                              ? Alignment.centerLeft
                              : Alignment.centerRight,
                          child: Text(
                            animalName,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                        FittedBox(
                          alignment: lang
                              ? Alignment.centerLeft
                              : Alignment.centerRight,
                          fit: BoxFit.scaleDown,
                          child: RichText(
                            text: TextSpan(
                              text: discountRate != null
                                  ? animalPriceAfterDiscount
                                  : animalPrice,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  ?.copyWith(
                                    color: discountRate != null
                                        ? ColorManager.kGreen
                                        : ColorManager.kBlack,
                                  ),
                              children: [
                                TextSpan(
                                  text: " $appCurrency",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1
                                      ?.copyWith(
                                        color: discountRate != null
                                            ? ColorManager.kGreen
                                            : ColorManager.kBlack,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        discountRate != null
                            ? FittedBox(
                                alignment: lang
                                    ? Alignment.centerLeft
                                    : Alignment.centerRight,
                                fit: BoxFit.scaleDown,
                                child: RichText(
                                  text: TextSpan(
                                    text: animalPrice,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1
                                        ?.copyWith(
                                            color: ColorManager.kMove,
                                            decoration:
                                                TextDecoration.lineThrough),
                                    children: [
                                      TextSpan(
                                        text: " $appCurrency",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1
                                            ?.copyWith(
                                                color: ColorManager.kMove,
                                                decoration:
                                                    TextDecoration.lineThrough),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            : const Spacer(),
                        Expanded(
                          child: BuildReviews(
                            average: reviewAverage,
                            reviews: reviewsCount,
                            width: 30.0.w,
                            starSize: 5.0.w,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  GestureDetector _buildBadgeContent() {
    return GestureDetector(
      onTap: onTappingAddButton,
      child: const Icon(
        Icons.add,
        color: ColorManager.kWhite,
      ),
    );
  }

  Widget _buildDiscountText(BuildContext context) {
    return discountRate != null
        ? Padding(
            padding: EdgeInsets.all(0.5.w),
            child: Text(
              "$discountRate%",
              style: Theme.of(context).textTheme.caption?.copyWith(
                  color: ColorManager.kWhite, fontWeight: FontWeight.bold),
            ),
          )
        : Container();
  }
}
