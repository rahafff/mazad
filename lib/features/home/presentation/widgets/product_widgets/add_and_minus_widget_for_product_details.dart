import 'package:easy_localization/easy_localization.dart';
import 'package:elite_auction/core/global_states/posting_state.dart';
import 'package:elite_auction/core/models/empty_success_response_entity.dart';
import 'package:elite_auction/core/resources/color_manager.dart';
import 'package:elite_auction/core/resources/strings_manager.dart';
import 'package:elite_auction/core/utils/global.dart';
import 'package:elite_auction/core/widgets/loading_circular.dart';
import 'package:elite_auction/features/cart/domain/bodies/add_to_cart_body.dart';
import 'package:elite_auction/features/cart/presentation/manager/cart_operations_cubit.dart';
import 'package:elite_auction/features/home/presentation/manager/product_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sizer/sizer.dart';

import '../../../../../core/error/network_exceptions.dart';
import '../../../../../core/resources/routes_manager.dart';
import '../../manager/product_variation_cubit.dart';

class AddAndMinusWidgetForProductDetails extends StatelessWidget {
  final VoidCallback removeItem;
  final VoidCallback addItem;
  final int itemCount;
  final int maxQuantity;
  final int productId;

  const AddAndMinusWidgetForProductDetails({
    Key? key,
    required this.removeItem,
    required this.addItem,
    this.itemCount = 1,
    required this.maxQuantity,
    required this.productId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final variationReadContext = context.read<ProductVariationCubit>();
    final variationWatchContext = context.watch<ProductVariationCubit>();
    final int? variationId =
        context.watch<ProductVariationCubit>().state.variationId;
    final int variationStatusCode = variationReadContext.variationStatusCode;

    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(2.0.w),
          color: ColorManager.kGreen),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          itemCount > 1
              ? AddOrMinusButton(
                  function: removeItem,
                  icon: Icons.remove,
                  iconColor: ColorManager.kWhite,
                )
              : AddOrMinusButton(
                  icon: Icons.remove,
                  iconColor: ColorManager.kWhiteWithAlpha90,
                ),
          Expanded(
            flex: 3,
            child: Center(
              child: BlocConsumer<CartOperationsCubit,
                  PostingState<EmptySuccessResponseEntity>>(
                listener: (context, state) {
                  state.whenOrNull(
                    success: (entity) {
                      return Fluttertoast.showToast(
                          msg: entity.message, toastLength: Toast.LENGTH_SHORT);
                    },
                    error: (error) {
                      return Fluttertoast.showToast(
                          msg: NetworkExceptions.getErrorMessage(error),
                          toastLength: Toast.LENGTH_SHORT);
                    },
                  );
                },
                builder: (context, state) {
                  return state.maybeWhen(
                    loading: () => LoadingCircularWidget(),
                    orElse: () => Container(
                      decoration: const BoxDecoration(
                        color: ColorManager.kGreen,
                      ),
                      child: MaterialButton(
                        onPressed: () {
                          if (!isTokenExist) {
                            Fluttertoast.showToast(
                                msg: AppStrings.youHaveToLoginFirst.tr(),
                                toastLength: Toast.LENGTH_SHORT);
                            Navigator.pushNamed(context, Routes.loginRoute);
                            return;
                          }
                          if (context.read<ProductCubit>().isVariationsNull()) {
                            context.read<CartOperationsCubit>().emitAddToCart(
                                  AddToCartBody(
                                    quantity: itemCount,
                                    productId: productId,
                                  ),
                                );
                          } else {
                            switch (variationStatusCode) {
                              case noColors:
                                {
                                  if (variationReadContext.sizePicked()) {
                                    context
                                        .read<CartOperationsCubit>()
                                        .emitAddToCart(
                                          AddToCartBody(
                                            quantity: itemCount,
                                            productId: productId,
                                            variationId: variationId,
                                          ),
                                        );
                                  } else {
                                    Fluttertoast.showToast(
                                        msg: AppStrings.plzSelectSize.tr());
                                  }
                                }
                                break;
                              case noSizes:
                                {
                                  if (variationReadContext.colorPicked()) {
                                    context
                                        .read<CartOperationsCubit>()
                                        .emitAddToCart(
                                          AddToCartBody(
                                            quantity: itemCount,
                                            productId: productId,
                                            variationId: variationId,
                                          ),
                                        );
                                  } else {
                                    Fluttertoast.showToast(
                                        msg: AppStrings.plzSelectColor.tr());
                                  }
                                }
                                break;
                              case colorsAndSizesExist:
                                {
                                  if (!variationReadContext.colorPicked() &&
                                      !variationReadContext.sizePicked()) {
                                    Fluttertoast.showToast(
                                        msg: AppStrings.plzSelectColorAndSize
                                            .tr());
                                  } else if (variationReadContext
                                          .colorPicked() &&
                                      !variationReadContext.sizePicked()) {
                                    if (variationWatchContext
                                        .state.sizes!.isNotEmpty) {
                                      Fluttertoast.showToast(
                                          msg: AppStrings.plzSelectSize.tr());
                                    } else {
                                      context
                                          .read<CartOperationsCubit>()
                                          .emitAddToCart(
                                            AddToCartBody(
                                              quantity: itemCount,
                                              productId: productId,
                                              variationId: variationId,
                                            ),
                                          );
                                    }
                                  } else if (!variationReadContext
                                          .colorPicked() &&
                                      variationReadContext.sizePicked()) {
                                    if (variationWatchContext
                                        .state.colors!.isNotEmpty) {
                                      Fluttertoast.showToast(
                                          msg: AppStrings.plzSelectColor.tr());
                                    } else {
                                      context
                                          .read<CartOperationsCubit>()
                                          .emitAddToCart(
                                            AddToCartBody(
                                              quantity: itemCount,
                                              productId: productId,
                                              variationId: variationId,
                                            ),
                                          );
                                    }
                                  } else {
                                    context
                                        .read<CartOperationsCubit>()
                                        .emitAddToCart(
                                          AddToCartBody(
                                            quantity: itemCount,
                                            productId: productId,
                                            variationId: variationId,
                                          ),
                                        );
                                  }
                                }
                                break;
                              default:
                            }
                          }
                        },
                        child: Text(
                          AppStrings.add2Cart.tr(),
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1!
                              .copyWith(color: ColorManager.kWhite),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          itemCount < maxQuantity
              ? AddOrMinusButton(
                  function: addItem,
                  icon: Icons.add,
                  iconColor: ColorManager.kWhite,
                )
              : AddOrMinusButton(
                  icon: Icons.add,
                  iconColor: ColorManager.kWhiteWithAlpha90,
                )
        ],
      ),
    );
  }
}

class AddOrMinusButton extends StatelessWidget {
  const AddOrMinusButton({
    Key? key,
    this.function,
    required this.icon,
    required this.iconColor,
  }) : super(key: key);

  final VoidCallback? function;
  final IconData icon;
  final Color iconColor;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: function,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2.0.w),
            color: ColorManager.kWhite.withOpacity(0.1),
          ),
          child: Icon(
            icon,
            color: iconColor,
            size: 8.0.w,
          ),
        ),
      ),
    );
  }
}
