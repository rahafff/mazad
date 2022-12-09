import 'package:badges/badges.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:elite_auction/core/global_states/standard_state.dart';
import 'package:elite_auction/core/resources/color_manager.dart';
import 'package:elite_auction/core/widgets/app_functions.dart';
import 'package:elite_auction/core/widgets/loading_circular.dart';
import 'package:elite_auction/features/home/presentation/manager/product_cubit.dart';
import 'package:elite_auction/features/home/presentation/manager/product_variation_cubit.dart';
import 'package:elite_auction/features/home/presentation/manager/product_variation_state.dart';
import 'package:elite_auction/features/home/presentation/widgets/product_widgets/add_and_show_review_button.dart';
import 'package:elite_auction/features/home/presentation/widgets/product_widgets/add_to_cart_button.dart';
import 'package:elite_auction/features/home/presentation/widgets/product_widgets/product_description.dart';
import 'package:elite_auction/features/home/presentation/widgets/product_widgets/product_details.dart';
import 'package:elite_auction/features/home/presentation/widgets/product_widgets/product_images_slider.dart';
import 'package:elite_auction/injection_container.dart' as di;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/resources/assets_manager.dart';
import '../../../../core/resources/bottom_navigation_bar_Items_Ids.dart';
import '../../../../core/resources/routes_manager.dart';
import '../../../../core/widgets/back_button.dart';
import '../../../../core/widgets/build_indicator.dart';
import '../../../../injection_container.dart';
import '../../../app_navigation_bar/presentation/manager/app_bottom_navigation_bar_index_changer_cubit.dart';
import '../../../app_navigation_bar/presentation/manager/app_navigation_bar_badges_cubit.dart';
import '../../domain/entities/product_response_entity.dart';
import '../manager/slided_products_cubit.dart';
import '../widgets/product_widgets/product_color.dart';
import '../widgets/product_widgets/product_size.dart';
import '../widgets/products_slider_builder.dart';

class ProductScreen extends StatefulWidget {
  final int productId;
  final int? shopId;
  final String productName;

  const ProductScreen({
    Key? key,
    required this.productId,
    this.shopId,
    required this.productName,
  }) : super(key: key);

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen>
    with SingleTickerProviderStateMixin {
  int _index = 0;
  final SlidedProductsCubit _slidedProductsCubit = SlidedProductsCubit(sl());

  @override
  void initState() {
  
    widget.shopId != null
        ? _slidedProductsCubit.emitGetShopProductSimilarProducts(
            shopId: widget.shopId!, productId: widget.productId)
        : _slidedProductsCubit.emitGetOwnerProductSimilarProducts(
            productId: widget.productId);
    context.read<ProductVariationCubit>().disposeStateValues();

    super.initState();
  }

  @override
  void dispose() {
    _slidedProductsCubit.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () {
          AppFunctions.unfocus(context);
        },
        child: BlocProvider<ProductCubit>(
          create: (context) => di.sl<ProductCubit>()
            ..emitGetProduct(
                productId: widget.productId, shopId: widget.shopId),
          child: Builder(builder: (context) {
            return Scaffold(
              backgroundColor: ColorManager.kWhite,
              resizeToAvoidBottomInset: true,
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.endFloat,
              floatingActionButton: BlocBuilder<AppNavigationBarBadgesCubit,
                  AppNavigationBarBadgesState>(
                builder: (context, state) {
                  final cartCount = state.cartItemsCount;
                  return Badge(
                    shape: BadgeShape.circle,
                    position: BadgePosition(top: 0.h, end: 0.w),
                    badgeContent: Text(
                      cartCount.toString(),
                      style: Theme.of(context)
                          .textTheme
                          .caption!
                          .copyWith(color: ColorManager.kWhite),
                    ),
                    showBadge:
                        (cartCount != null && cartCount != 0) ? true : false,
                    child: FloatingActionButton(
                      onPressed: () {
                        context
                            .read<AppBottomNavigationBarIndexChangerCubit>()
                            .changeScreen(cartId);
                        Navigator.restorablePopAndPushNamed(
                          context,
                          Routes.bottomNavigationBarRoute,
                        );
                      },
                      child: const ImageIcon(
                          AssetImage(ImageAssetsManager.addToCart)),
                    ),
                  );
                },
              ),
              appBar: AppBar(
                title: Text(widget.productName),
                leading: const BackButtonWidget(),
              ),
              body: BlocConsumer<ProductCubit,
                      StandardState<ProductResponseEntity>>(
                  listener: (context, state) {
                state.whenOrNull(
                  success: (data) => data.product.productVariations != null
                      ? context
                          .read<ProductVariationCubit>()
                          .initColorsAndSizes(data.product.productVariations!)
                      : null,
                );
              }, builder: (context, state) {
                return state.when(
                  loading: () => LoadingCircularWidget(),
                  success: (product) {
                    return SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ProductImagesSlider(
                            product: product.product,
                            onPageChanged: (imageIndex) {
                              setState(
                                () {
                                  _index = imageIndex;
                                },
                              );
                            },
                          ),
                          Container(
                            color: ColorManager.kWhite,
                            height: 5.0.h,
                          ),
                          BuildIndicator(
                              length:
                                  product.product.productImages?.length ?? 0,
                              index: _index),
                          const Divider(),
                          ProductDetails(
                            average: product.product.productReviewAvg,
                            reviews: product.product.productReviewCount,
                            productPrice: product.product.productPrice,
                            productPriceAfterDiscount:
                                product.product.productPriceAfterDiscount,
                            discountRate: product.product.discountRate,
                            discountName: product.product.discountName,
                            productName: product.product.productName,
                          ),
                          const Divider(),
                          ProductDescription(
                              productDescription:
                                  product.product.productMobileDescription),
                          product.product.productVariations!.isNotEmpty
                              ? const Divider()
                              : Container(),
                          product.product.productVariations!.isNotEmpty
                              ? BlocBuilder<ProductVariationCubit,
                                  ProductVariationState>(
                                  buildWhen: (previous, current) =>
                                      previous != current,
                                  builder: (context, state) {
                                    final sizes = context
                                        .watch<ProductVariationCubit>()
                                        .state
                                        .sizes;
                                    final colors = context
                                        .watch<ProductVariationCubit>()
                                        .state
                                        .colors;
                                    return Container(
                                      width: double.infinity,
                                      margin: EdgeInsets.only(bottom: 3.0.h),
                                      padding:
                                          EdgeInsets.symmetric(vertical: 3.0.h),
                                      color: ColorManager.kWhite,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          colors!.isNotEmpty
                                              ? Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 5.0.w,
                                                              vertical: 2.0.h),
                                                      child: Text(
                                                        'Colors'.tr(),
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 14.0.sp),
                                                      ),
                                                    ),
                                                    _buildColors(),
                                                  ],
                                                )
                                              : Container(),
                                          sizes!.isNotEmpty
                                              ? Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 5.0.w,
                                                              vertical: 2.0.h),
                                                      child: Text(
                                                        'Sizes'.tr(),
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 14.0.sp),
                                                      ),
                                                    ),
                                                    _buildSizes()
                                                  ],
                                                )
                                              : Container()
                                        ],
                                      ),
                                    );
                                  },
                                )
                              : Container(),
                          const Divider(),
                          AddToCartButton(
                            product: product.product,
                          ),
                          AddAndShowReviewButton(),
                          //todo find better solution
                          const Divider(),
                          ProductsSliderBuilder(cubit: _slidedProductsCubit),
                        ],
                      ),
                    );
                  },
                  error: (error) {
                    return const SizedBox.shrink();
                  },
                );
              }),
            );
          }),
        ),
      ),
    );
  }

  _buildColors() {
    final colors = context.watch<ProductVariationCubit>().state.colors;
    final pickedColorId =
        context.watch<ProductVariationCubit>().state.pickedColorId;
    return colors != null
        ? SizedBox(
            height: 15.0.h,
            child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 5.0.w),
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: colors.length,
                itemBuilder: (context, index) {
                  final color = colors[index].color;
                  return color != null
                      ? GestureDetector(
                          onTap: () {
                            context
                                .read<ProductVariationCubit>()
                                .sortSizesByColorIdOrSelectColorWhenAlreadySortingBySizes(
                                    color.id!,
                                    colors[index].id!,
                                    colors[index].productPrice,
                                    colors[index].productPriceAfterDiscount,
                                    colors[index].quantity!);
                          },
                          child: ProductColor(
                            color: color.colorHexaCode!,
                            colorsName: color.colorName!,
                            borderColor: pickedColorId == colors[index].colorId
                                ? Colors.lightBlueAccent
                                : ColorManager.lightGrayButtonColor,
                          ),
                        )
                      : Container();
                }),
          )
        : Container();
  }

  _buildSizes() {
    final sizes = context.watch<ProductVariationCubit>().state.sizes;
    final pickedSizeId =
        context.watch<ProductVariationCubit>().state.pickedSizeId;
    return sizes != null
        ? SizedBox(
            height: 10.0.h,
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 5.0.w),
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: sizes.length,
              itemBuilder: (context, index) {
                final size = sizes[index].size;
                return size != null
                    ? GestureDetector(
                        onTap: () {
                          context
                              .read<ProductVariationCubit>()
                              .sortColorsBySizeIdOrSelectSizeWhenAlreadySortingByColors(
                                  size.id!,
                                  sizes[index].id!,
                                  sizes[index].productPrice,
                                  sizes[index].productPriceAfterDiscount,
                                  sizes[index].quantity!);
                        },
                        child: ProductSize(
                          size: size.sizeName!,
                          borderColor: pickedSizeId == sizes[index].sizeId
                              ? Colors.lightBlueAccent
                              : ColorManager.lightGrayButtonColor,
                        ),
                      )
                    : Container();
              },
            ),
          )
        : Container();
  }
}
