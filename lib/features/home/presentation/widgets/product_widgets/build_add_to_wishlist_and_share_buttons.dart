import 'package:elite_auction/core/global_states/posting_state.dart';
import 'package:elite_auction/core/models/empty_success_response_entity.dart';
import 'package:elite_auction/core/widgets/constant_box_decorations_and_shadows.dart';
import 'package:elite_auction/features/wishlist/domain/bodies/add_to_wishlist_body.dart';
import 'package:elite_auction/features/wishlist/domain/bodies/delete_from_wishlist_body.dart';
import 'package:elite_auction/features/wishlist/presentation/manager/wishlist_operations_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sizer/sizer.dart';

import '../../../../../core/error/network_exceptions.dart';
import '../../../../../core/resources/assets_manager.dart';
import '../../../../../core/resources/color_manager.dart';
import '../../../../../core/utils/Share/share.dart';
import '../../../../../core/utils/global.dart';
import '../../../../../core/widgets/loading_circular.dart';
import '../../manager/product_cubit.dart';

class AddToWishListAndShareButtonsRow extends StatefulWidget {
  const AddToWishListAndShareButtonsRow({
    Key? key,
  }) : super(key: key);

  @override
  State<AddToWishListAndShareButtonsRow> createState() =>
      _AddToWishListAndShareButtonsRowState();
}

class _AddToWishListAndShareButtonsRowState
    extends State<AddToWishListAndShareButtonsRow> {
  bool isWishListActive = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 30.0.w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: ColorManager.kWhite,
                boxShadow: [ConstantBoxDecorationsAndShadows.lightShadow]),
            child: IconButton(
              iconSize: 8.0.w,
              onPressed: () {
                ProductShare.share(
                    productId: context.read<ProductCubit>().product!.id,shopId: context.read<ProductCubit>().product?.shopId);
              },
              icon: const Icon(
                Icons.share,
                color: ColorManager.kGreen,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: ColorManager.midumeGray,
                boxShadow: [ConstantBoxDecorationsAndShadows.lightShadow]),
            child: BlocConsumer<WishlistOperationsCubit,
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
                  orElse: () {
                    if (isTokenExist) {
                      return IconButton(
                        color: ColorManager.kWhite,
                        iconSize: 8.0.w,
                        onPressed: () {
                          if (isWishListActive) {
                            context
                                .read<WishlistOperationsCubit>()
                                .emitDeleteFromWishlist(
                                  DeleteFromWishlistBody(
                                      productId: context
                                          .read<ProductCubit>()
                                          .product!
                                          .id),
                                );
                            setState(() {
                              isWishListActive = !isWishListActive;
                            });
                          } else {
                            context
                                .read<WishlistOperationsCubit>()
                                .emitAddToWishlist(
                                  AddToWishlistBody(
                                      productId: context
                                          .read<ProductCubit>()
                                          .product!
                                          .id),
                                );
                            setState(
                              () {
                                isWishListActive = !isWishListActive;
                              },
                            );
                          }
                        },
                        icon: ImageIcon(
                          const AssetImage(ImageAssetsManager.addToWishlist),
                          color: isWishListActive
                              ? Colors.yellow.shade600
                              : ColorManager.darkGrey,
                        ),
                      );
                    } else {
                      return IconButton(
                        color: ColorManager.kWhite,
                        iconSize: 8.0.w,
                        onPressed: () {},
                        icon: ImageIcon(
                          const AssetImage(ImageAssetsManager.addToWishlist),
                          color: ColorManager.darkGrey,
                        ),
                      );
                    }
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
