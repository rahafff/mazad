import 'package:easy_localization/easy_localization.dart';
import 'package:elite_auction/core/resources/color_manager.dart';
import 'package:elite_auction/core/resources/strings_manager.dart';
import 'package:elite_auction/features/home/domain/entities/product_response_entity.dart';
import 'package:elite_auction/features/home/presentation/manager/product_variation_cubit.dart';
import 'package:elite_auction/features/home/presentation/manager/product_variation_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import 'add_and_minus_widget_for_product_details.dart';

class AddToCartButton extends StatefulWidget {
  const AddToCartButton({Key? key, required this.product}) : super(key: key);
  final ProductEntity product;
  @override
  State<AddToCartButton> createState() => _AddToCartButtonState();
}

class _AddToCartButtonState extends State<AddToCartButton> {
  final TextEditingController _itemCountController = TextEditingController();

  int _itemCount = 1;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductVariationCubit, ProductVariationState>(
      buildWhen: (previous, current) {
        if (previous != current) {
          _itemCount = 1;
          return true;
        }
        return false;
      },
      builder: (context, state) {
        return Container(
          height: 8.0.h,
          padding: EdgeInsets.symmetric(horizontal: 5.0.w),
          margin: EdgeInsets.symmetric(vertical: 3.0.h),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: AddAndMinusWidgetForProductDetails(
                  productId: widget.product.id,
                  removeItem: () {
                    setState(
                      () {
                        _itemCount--;
                        _itemCountController.text = _itemCount.toString();
                        // decrementing value
                      },
                    );
                  },
                  addItem: () {
                    setState(
                      () {
                        _itemCount++;
                        _itemCountController.text = _itemCount.toString();
                      },
                    );
                  },
                  maxQuantity: context
                          .watch<ProductVariationCubit>()
                          .state
                          .variationQuantity ??
                      widget.product.productMaxQuantity!,
                  itemCount: _itemCount,
                ),
              ),
              SizedBox(
                width: 5.0.w,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 2.0.w),
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: ColorManager.lightGray,
                    ),
                    bottom: BorderSide(
                      color: ColorManager.lightGray,
                    ),
                  ),
                ),
                child: Column(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Text(
                        AppStrings.quantity.tr(),
                        style: Theme.of(context)
                            .textTheme
                            .caption!
                            .copyWith(color: ColorManager.grayText),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                        _itemCount.toString(),
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
