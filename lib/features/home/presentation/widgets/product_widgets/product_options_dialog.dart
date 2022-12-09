import 'package:easy_localization/easy_localization.dart';
import 'package:elite_auction/core/error/network_exceptions.dart';
import 'package:elite_auction/core/global_states/posting_state.dart';
import 'package:elite_auction/core/models/empty_success_response_entity.dart';
import 'package:elite_auction/core/resources/assets_manager.dart';
import 'package:elite_auction/core/resources/routes_manager.dart';
import 'package:elite_auction/core/resources/strings_manager.dart';
import 'package:elite_auction/core/utils/global.dart';
import 'package:elite_auction/features/home/domain/entities/paginated_product_entity.dart';
import 'package:elite_auction/features/wishlist/domain/bodies/add_to_wishlist_body.dart';
import 'package:elite_auction/features/wishlist/presentation/manager/wishlist_operations_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../../../core/utils/Share/share.dart';
import '../../../../../core/widgets/loading_circular.dart';
import 'add_button_dialog.dart';

class ProductOptionsDialog extends StatelessWidget {
  final PaginatedProductEntity product;

  const ProductOptionsDialog({Key? key, required this.product})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<WishlistOperationsCubit,
            PostingState<EmptySuccessResponseEntity>>(
          listener: (context, state) {
            state.whenOrNull(
              success: (entity) {
                Navigator.pop(context);
                return Fluttertoast.showToast(
                    msg: entity.message, toastLength: Toast.LENGTH_SHORT);
              },
              error: (error) {
                Navigator.pop(context);
                return Fluttertoast.showToast(
                    msg: NetworkExceptions.getErrorMessage(error),
                    toastLength: Toast.LENGTH_SHORT);
              },
            );
          },
        ),
      ],
      child: BlocBuilder<WishlistOperationsCubit,
          PostingState<EmptySuccessResponseEntity>>(
        builder: (context, state) {
          return state.maybeWhen(
            loading: () => LoadingCircularWidget(),
            orElse: () => BuildAddButtonDialog(
              secondRowTitle: AppStrings.add2Wishlist.tr(),
              thirdRowTitle: AppStrings.share.tr(),
              secondRowIcon: ImageAssetsManager.addToWishlist,
              thirdRowIcon: ImageAssetsManager.share,
              onTappingSecondOption: () {
                if (isTokenExist) {
                  context.read<WishlistOperationsCubit>().emitAddToWishlist(
                        AddToWishlistBody(productId: product.id),
                      );
                } else {
                  Fluttertoast.showToast(
                      msg: AppStrings.youHaveToLoginFirst.tr(),
                      toastLength: Toast.LENGTH_SHORT);
                  Navigator.popAndPushNamed(context, Routes.loginRoute);
                }
              },
              onTappingThirdOption: () {
                ProductShare.share(productId: product.id,shopId: product.shopId);
                Navigator.pop(context);
              },
            ),
          );
        },
      ),
    );
  }
}
