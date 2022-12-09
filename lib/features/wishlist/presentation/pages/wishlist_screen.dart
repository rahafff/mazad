import 'package:easy_localization/easy_localization.dart';
import 'package:elite_auction/core/api/end_points.dart';
import 'package:elite_auction/core/global_states/posting_state.dart';
import 'package:elite_auction/core/models/empty_success_response_entity.dart';
import 'package:elite_auction/core/resources/assets_manager.dart';
import 'package:elite_auction/core/resources/strings_manager.dart';
import 'package:elite_auction/core/utils/global.dart';
import 'package:elite_auction/core/widgets/loading_circular.dart';
import 'package:elite_auction/features/cart/presentation/manager/cart_operations_cubit.dart';
import 'package:elite_auction/features/wishlist/domain/bodies/delete_from_wishlist_body.dart';
import 'package:elite_auction/features/wishlist/domain/entities/wishlist_entity.dart';
import 'package:elite_auction/features/wishlist/presentation/manager/wishlist_getter_cubit.dart';
import 'package:elite_auction/features/wishlist/presentation/widgets/wishlist_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/error/network_exceptions.dart';
import '../../../../core/global_states/standard_state.dart';
import '../../../../core/resources/routes_manager.dart';
import '../../../../core/utils/Share/share.dart';
import '../../../../core/widgets/app_dialog.dart';
import '../../../../core/widgets/no_items_image.dart';
import '../../../wishlist/presentation/manager/wishlist_operations_cubit.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({Key? key}) : super(key: key);

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  @override
  void initState() {
    context.read<WishlistGetterCubit>().emitGetDetailedWishlist();

    super.initState();
  }

  @override
  Widget build(BuildContext cartContext) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text(
              AppStrings.wishlist.tr(),
            ),
          ),
          body: MultiBlocListener(
            listeners: [
              BlocListener<CartOperationsCubit,
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
              BlocListener<WishlistOperationsCubit,
                  PostingState<EmptySuccessResponseEntity>>(
                listener: (context, state) {
                  state.whenOrNull(
                    success: (entity) {
                      Fluttertoast.showToast(
                          msg: entity.message, toastLength: Toast.LENGTH_SHORT);
                      context
                          .read<WishlistGetterCubit>()
                          .emitGetDetailedWishlist();
                    },
                    error: (error) {
                      Fluttertoast.showToast(
                          msg: NetworkExceptions.getErrorMessage(error),
                          toastLength: Toast.LENGTH_SHORT);
                      context
                          .read<WishlistGetterCubit>()
                          .emitGetDetailedWishlist();
                    },
                  );
                },
              ),
            ],
            child: BlocBuilder<WishlistGetterCubit, StandardState<Wishlist>>(
              builder: (context, state) {
                return state.when(
                  loading: () => LoadingCircularWidget(),
                  success: (wishlist) => wishlist.wishlistItems != null
                      ? ListView.builder(
                          padding: EdgeInsets.only(
                              left: 5.w, right: 5.0.w, bottom: 10.h),
                          itemCount: wishlist.wishlistItems?.length,
                          physics: const ScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            final wishlistItem = wishlist.wishlistItems?[index];
                            return WishlistSingleItem(
                              itemImage: EndPoints.baseUrl +
                                  wishlistItem!.productMainImage,
                              itemName: wishlistItem.productName,
                              itemPrice: wishlistItem.productPrice,
                              itemPriceAfterDiscount:
                                  wishlistItem.productPriceAfterDiscount,
                              optionsIcons: const [
                                ImageAssetsManager.share,
                                ImageAssetsManager.addToCart,
                                ImageAssetsManager.removeFromWishList,
                              ],
                              optionForFirstIcon: () {
                                ProductShare.share(
                                    productId: wishlistItem.id,
                                    shopId: wishlistItem.shopId);
                              },
                              optionForSecondIcon: () {
                                // context
                                //     .read<CartOperationsCubit>()
                                //     .emitAddToCart(
                                //       AddToCartBody(
                                //           productId: wishlistItem.id,
                                //           quantity: 1),
                                //     );
                              },
                              optionForThirdIcon: () {
                                context
                                    .read<WishlistOperationsCubit>()
                                    .emitDeleteFromWishlist(
                                      DeleteFromWishlistBody(
                                          productId: wishlistItem.id),
                                    );
                              },
                              productMaxQuantity:
                                  wishlistItem.maxProductQuantity,
                              onTappingWishlistItem: () {
                                Navigator.pushNamed(
                                  context,
                                  Routes.product,
                                  arguments: ProductArguments(
                                      productName: wishlistItem.productName,
                                      productId: wishlistItem.id,
                                      shopId: wishlistItem.shopId),
                                );
                              },
                              fabTag: index.toString(),
                              discountRate: wishlistItem.discountRate,
                              reviewsAverage: wishlistItem.productReviewAvg,
                              reviewsCount: wishlistItem.productReviewsCount,
                            );
                          },
                        )
                      : const NoItemsWidget(),
                  error: (error) {
                    if (error is LoggingInRequired) {
                      return AppDialog(
                          dialogText: AppStrings.youHaveToLoginFirst.tr(),
                          buttonText: AppStrings.login.tr(),
                          buttonFunction: () {
                            Navigator.pushNamed(context, Routes.loginRoute);
                          });
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
