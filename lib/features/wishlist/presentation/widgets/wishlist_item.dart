import 'package:badges/badges.dart';
import 'package:elite_auction/core/widgets/constant_box_decorations_and_shadows.dart';
import 'package:elite_auction/core/widgets/custom_circular_menu.dart';
import 'package:elite_auction/core/widgets/custom_circular_menu_item.dart';
import 'package:elite_auction/features/wishlist/presentation/widgets/wishlist_item_details.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/resources/color_manager.dart';
import '../../../../core/utils/global.dart';
import '../../../../core/widgets/image_with_one_aspect_ratio.dart';

class WishlistSingleItem extends StatelessWidget {
  final int? discountRate;
  final String itemImage;
  final String itemName;
  final String itemPrice;
  final String? itemPriceAfterDiscount;
  final List<String> optionsIcons;
  final VoidCallback optionForFirstIcon;
  final VoidCallback optionForSecondIcon;
  final VoidCallback optionForThirdIcon;
  final int productMaxQuantity;
  final VoidCallback onTappingWishlistItem;
  final String fabTag;
  final num reviewsAverage;
  final int reviewsCount;

  const WishlistSingleItem(
      {Key? key,
      this.discountRate,
      required this.itemImage,
      required this.itemName,
      required this.itemPrice,
      this.itemPriceAfterDiscount,
      required this.optionsIcons,
      required this.optionForFirstIcon,
      required this.optionForSecondIcon,
      required this.optionForThirdIcon,
      required this.productMaxQuantity,
      required this.onTappingWishlistItem,
      required this.fabTag,
      required this.reviewsAverage,
      required this.reviewsCount})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return CustomCircularMenu(
      isConfirming: false,
      radius: 15.w,
      toggleButtonSize: 5.w,
      items: [
        _buildCustomCircularMenuItem(
            optionForFirstIcon, optionsIcons[0], false),
        _buildCustomCircularMenuItem(
            optionForSecondIcon, optionsIcons[1], false),
        _buildCustomCircularMenuItem(optionForThirdIcon, optionsIcons[2], true),
      ],
      toggleButtonColor: ColorManager.kGreen,
      alignment: lang ? Alignment.bottomRight : Alignment.bottomLeft,
      backgroundWidget: Badge(
        shape: BadgeShape.circle,
        padding: EdgeInsets.all(2.w),
        position: BadgePosition.topStart(top: 2.h, start: -2.w),
        showBadge: discountRate != null,
        badgeContent: Text(
          "$discountRate%",
          style: Theme.of(context)
              .textTheme
              .caption
              ?.copyWith(color: Colors.white),
        ),
        badgeColor: Colors.red,
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 2.h),
          decoration: BoxDecoration(
              color: ColorManager.kWhite,
              borderRadius: BorderRadius.circular(2.w),
              boxShadow: [ConstantBoxDecorationsAndShadows.lightShadow]),
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: GestureDetector(
                  onTap: onTappingWishlistItem,
                  child: ImageWithAspectRatioOfOne(itemImage: itemImage),
                ),
              ),
              Expanded(
                flex: 2,
                child: WishlistItemDetails(
                  itemName: itemName,
                  itemPrice: itemPrice,
                  itemPriceAfterDiscount: itemPriceAfterDiscount,
                  discountRate: discountRate,
                  reviewAverage: reviewsAverage,
                  reviewsCount: reviewsCount,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  CustomCircularMenuItem _buildCustomCircularMenuItem(
      VoidCallback onTap, String icon, bool enableMinusBadge) {
    return CustomCircularMenuItem(
      onTap: onTap,
      enableBadge: enableMinusBadge,
      badgeColor: Colors.red,
      badgeTextColor: Colors.white,
      badgeLabel: "-",
      badgeTextStyle: const TextStyle(fontWeight: FontWeight.bold),
      icon: icon,
      badgeTopOffet: -1.w,
      badgeRightOffet: -1.w,
      iconSize: 5.w,
      color: ColorManager.kGreen,
      margin: 0,
    );
  }
}
