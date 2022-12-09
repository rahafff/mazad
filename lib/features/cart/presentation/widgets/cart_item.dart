import 'package:badges/badges.dart';
import 'package:elite_auction/core/resources/color_manager.dart';
import 'package:elite_auction/core/widgets/constant_box_decorations_and_shadows.dart';
import 'package:elite_auction/features/cart/presentation/manager/cart_operations_cubit.dart';
import 'package:elite_auction/features/cart/presentation/widgets/cart_item_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/utils/global.dart';
import '../../../../core/widgets/add_and_minus_widget.dart';
import '../../../../core/widgets/custom_circular_menu.dart';
import '../../../../core/widgets/custom_circular_menu_item.dart';
import '../../../../core/widgets/image_with_one_aspect_ratio.dart';
import '../../domain/bodies/add_to_cart_body.dart';

class CartSingleItem extends StatefulWidget {
  final int? discountRate;
  final String itemImage;
  final String itemName;
  final String itemPrice;
  final String? itemPriceAfterDiscount;
  final List<String> optionsIcons;
  final VoidCallback optionForFirstIcon;
  final VoidCallback optionForSecondIcon;
  final VoidCallback optionForThirdIcon;
  final Function confirmCartItemFunction;
  final int productMaxQuantity;
  final VoidCallback onTappingCartItem;
  final num reviewsAverage;
  final int reviewsCount;
  final int productQuantity;
  final int productId;
  final int? variationId;
  const CartSingleItem(
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
      required this.confirmCartItemFunction,
      required this.productMaxQuantity,
      required this.onTappingCartItem,
      required this.reviewsAverage,
      required this.reviewsCount,
      required this.productQuantity,
      required this.productId,
      required this.variationId})
      : super(key: key);

  @override
  State<CartSingleItem> createState() => _CartSingleItemState();
}

class _CartSingleItemState extends State<CartSingleItem> {
  late int productQuantity;

  @override
  void initState() {
    productQuantity = widget.productQuantity;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomCircularMenu(
      radius: 15.w,
      toggleButtonSize: 5.w,
      isConfirming: productQuantity != widget.productQuantity,
      toggleButtonOnPressed: () {
        if (productQuantity != widget.productQuantity) {
          context.read<CartOperationsCubit>().emitAddToCart(
                AddToCartBody(
                    quantity: productQuantity,
                    productId: widget.productId,
                    variationId: widget.variationId),
              );
        }
      },
      items: [
        _buildCustomCircularMenuItem(
            widget.optionForFirstIcon, widget.optionsIcons[0], false),
        _buildCustomCircularMenuItem(
            widget.optionForSecondIcon, widget.optionsIcons[1], false),
        _buildCustomCircularMenuItem(
            widget.optionForThirdIcon, widget.optionsIcons[2], true),
      ],
      toggleButtonColor: ColorManager.kGreen,
      alignment: lang ? Alignment.bottomRight : Alignment.bottomLeft,
      backgroundWidget: Badge(
        shape: BadgeShape.circle,
        padding: EdgeInsets.all(2.w),
        position: BadgePosition.topStart(top: 2.h, start: -2.w),
        showBadge: widget.discountRate != null,
        badgeContent: Text(
          "${widget.discountRate}%",
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: GestureDetector(
                        onTap: widget.onTappingCartItem,
                        child: ImageWithAspectRatioOfOne(
                            itemImage: widget.itemImage),
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: CartItemDetails(
                        itemName: widget.itemName,
                        itemPrice: widget.itemPrice,
                        itemPriceAfterDiscount: widget.itemPriceAfterDiscount,
                        discountRate: widget.discountRate,
                        reviewAverage: widget.reviewsAverage,
                        reviewsCount: widget.reviewsCount,
                      ),
                    ),
                  ],
                ),
              ),
              AddAndMinusWidget(
                removeItem: () {
                  setState(
                    () {
                      productQuantity--;
                    },
                  );
                },
                addItem: () {
                  setState(
                    () {
                      productQuantity++;
                    },
                  );
                },
                maxQuantity: widget.productMaxQuantity,
                itemCount: productQuantity,
              )
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
