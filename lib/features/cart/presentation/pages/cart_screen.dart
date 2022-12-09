import 'package:easy_localization/easy_localization.dart';
import 'package:elite_auction/core/api/end_points.dart';
import 'package:elite_auction/core/global_states/posting_state.dart';
import 'package:elite_auction/core/models/empty_success_response_entity.dart';
import 'package:elite_auction/core/resources/assets_manager.dart';
import 'package:elite_auction/core/resources/routes_manager.dart';
import 'package:elite_auction/core/resources/strings_manager.dart';
import 'package:elite_auction/core/utils/global.dart';
import 'package:elite_auction/core/widgets/invoice_totals.dart';
import 'package:elite_auction/core/widgets/loading_circular.dart';
import 'package:elite_auction/features/cart/domain/bodies/add_to_cart_body.dart';
import 'package:elite_auction/features/cart/domain/bodies/delete_from_cart_body.dart';
import 'package:elite_auction/features/cart/presentation/manager/cart_getter_cubit.dart';
import 'package:elite_auction/features/cart/presentation/manager/cart_operations_cubit.dart';
import 'package:elite_auction/features/cart/presentation/widgets/cart_item.dart';
import 'package:elite_auction/features/wishlist/domain/bodies/add_to_wishlist_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/error/network_exceptions.dart';
import '../../../../core/global_states/standard_state.dart';
import '../../../../core/utils/Share/share.dart';
import '../../../../core/widgets/app_dialog.dart';
import '../../../../core/widgets/no_items_image.dart';
import '../../../wishlist/presentation/manager/wishlist_operations_cubit.dart';
import '../../domain/entities/cart_entity.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    context.read<CartGetterCubit>().emitGetDetailedCart();

    super.initState();
  }

  @override
  Widget build(BuildContext cartContext) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text(
              AppStrings.shoppingCart.tr(),
            ),
          ),
          body: MultiBlocListener(
            listeners: [
              BlocListener<CartOperationsCubit,
                  PostingState<EmptySuccessResponseEntity>>(
                listener: (context, state) {
                  state.whenOrNull(
                    success: (entity) {
                      Fluttertoast.showToast(
                          msg: entity.message, toastLength: Toast.LENGTH_SHORT);
                      context.read<CartGetterCubit>().emitGetDetailedCart();
                    },
                    error: (error) {
                      Fluttertoast.showToast(
                          msg: NetworkExceptions.getErrorMessage(error),
                          toastLength: Toast.LENGTH_SHORT);
                      context.read<CartGetterCubit>().emitGetDetailedCart();
                    },
                  );
                },
              ),
              BlocListener<WishlistOperationsCubit,
                  PostingState<EmptySuccessResponseEntity>>(
                listener: (context, state) {
                  state.whenOrNull(
                    success: (entity) => Fluttertoast.showToast(
                        msg: entity.message, toastLength: Toast.LENGTH_SHORT),
                    error: (error) => Fluttertoast.showToast(
                        msg: NetworkExceptions.getErrorMessage(error),
                        toastLength: Toast.LENGTH_SHORT),
                  );
                },
              ),
            ],
            child: BlocBuilder<CartGetterCubit, StandardState<Cart>>(
              builder: (context, state) {
                return state.when(
                  loading: () => LoadingCircularWidget(),
                  success: (cart) => cart.cartItems != null
                      ? SingleChildScrollView(
                          physics: const NeverScrollableScrollPhysics(),
                          child: SizedBox(
                            height: 80.h,
                            child: Column(
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: ListView.builder(
                                    physics: const ClampingScrollPhysics(),
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 5.w),
                                    itemCount: cart.cartItems!.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      final cartItem = cart.cartItems![index];
                                      return CartSingleItem(
                                        itemImage: EndPoints.baseUrl +
                                            cartItem.productMainImage,
                                        itemName: cartItem.productName,
                                        itemPrice: cartItem.productPrice,
                                        itemPriceAfterDiscount:
                                            cartItem.productPriceAfterDiscount,
                                        optionsIcons: const [
                                          ImageAssetsManager.share,
                                          ImageAssetsManager.addToWishlist,
                                          ImageAssetsManager.removeFromCart,
                                        ],
                                        optionForFirstIcon: () {
                                          ProductShare.share(productId: cartItem.id,shopId: cart.shopId);
                                        },
                                        optionForSecondIcon: () {
                                          context
                                              .read<WishlistOperationsCubit>()
                                              .emitAddToWishlist(
                                                AddToWishlistBody(
                                                  productId: cartItem.id,
                                                ),
                                              );
                                        },
                                        optionForThirdIcon: () {
                                          context
                                              .read<CartOperationsCubit>()
                                              .emitDeleteFromCart(
                                                DeleteFromCartBody(
                                                    productId: cartItem.id,
                                                    variationId: cartItem
                                                        .productVariation?.id),
                                              );
                                        },
                                        productMaxQuantity:
                                            cartItem.maxProductQuantity,
                                        onTappingCartItem: () {
                                          Navigator.pushNamed(
                                            context,
                                            Routes.product,
                                            arguments: ProductArguments(
                                                productName:
                                                    cartItem.productName,
                                                productId: cartItem.id,
                                                shopId: cart.shopId),
                                          );
                                        },
                                        confirmCartItemFunction: () {
                                          context
                                              .read<CartOperationsCubit>()
                                              .emitAddToCart(
                                                AddToCartBody(
                                                    quantity: cartItem
                                                        .productQuantity,
                                                    variationId: cartItem
                                                        .productVariation?.id,
                                                    productId: cartItem.id),
                                              );
                                        },
                                        discountRate: cartItem.discountRate,
                                        reviewsAverage:
                                            cartItem.productReviewAvg,
                                        reviewsCount:
                                            cartItem.productReviewsCount,
                                        productQuantity:
                                            cartItem.productQuantity,
                                        productId: cartItem.id,
                                        variationId:
                                            cartItem.productVariation?.id,
                                      );
                                    },
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: InvoiceTotals(
                                    subTotal:
                                        cart.subTotal!, //state.cart.subTotal,
                                    totalAmount: cart
                                        .overallTotal!, //state.cart.overallTotal,
                                    deliveryFees: cart
                                        .deliveryFees!, //state.cart.deliveryFees,
                                    totalAmountButton: ElevatedButton(
                                      onPressed: () {
                                        Navigator.pushNamed(context,
                                            Routes.shippingAddressRout);
                                      },
                                      child: Text(
                                        AppStrings.checkout.tr(),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      : const NoItemsWidget(),
                  error: (error) {
                    if (error is LoggingInRequired) {
                      return  AppDialog(dialogText: AppStrings.youHaveToLoginFirst.tr(),buttonText: AppStrings.login.tr(), buttonFunction: () {  Navigator.pushNamed(context, Routes.loginRoute); },);
                    } else {
                      return lang
                          ? Center(
                              child: Image.asset(
                                  ImageAssetsManager.noInternetErrorEn),
                            )
                          : Center(
                              child: Image.asset(
                                  ImageAssetsManager.noInternetErrorAr),
                            );
                    }
                  },
                );
              },
            ),
          )),
    );
  }
}
