import 'package:carousel_slider/carousel_slider.dart';
import 'package:elite_auction/core/widgets/shimmer/shimmer_product_slider_builder.dart';
import 'package:elite_auction/features/home/presentation/widgets/product_card.dart';
import 'package:elite_auction/features/home/presentation/widgets/product_widgets/product_options_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/api/end_points.dart';
import '../../../../core/error/network_exceptions.dart';
import '../../../../core/global_states/standard_state.dart';
import '../../../../core/resources/routes_manager.dart';
import '../../../../core/utils/Share/share.dart';
import '../../domain/entities/paginated_product_entity.dart';
import '../manager/slided_products_cubit.dart';

class ProductsSliderBuilder extends StatelessWidget {
  const ProductsSliderBuilder({
    Key? key,
    required this.cubit,
  }) : super(key: key);

  final SlidedProductsCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 3.0.h, horizontal: 3.0.w),
      child: BlocBuilder<SlidedProductsCubit,
          StandardState<List<PaginatedProductEntity?>>>(
        bloc: cubit,
        builder: (context, state) {
          return state.when(
              loading: () => const ShimmerProductsSliderBuilder(),
              success: (List<PaginatedProductEntity?> products) =>
                  products.isEmpty
                      ? const SizedBox.shrink()
                      : CarouselSlider.builder(
                          itemCount: products.length,
                          itemBuilder: (context, index, realIndex) {
                            final product = products[index];
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ProductCard(
                                animalImage: EndPoints.baseUrl +
                                    product!.productMainImage.toString(),
                                animalName: product.productName.toString(),
                                reviewsCount: product.productReviewCount,
                                reviewAverage: product.productReviewAvg,
                                animalPrice: product.productPrice.toString(),
                                animalPriceAfterDiscount:
                                    product.productPriceAfterDiscount,
                                discountRate: product.discountRate,
                                onTappingShareButton: () {
                                  ProductShare.share(
                                      productId: product.id,
                                      shopId: product.shopId);
                                },
                                onTappingAddButton: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) => ProductOptionsDialog(
                                      product: product,
                                    ),
                                  );
                                },
                                onTappingProduct: () {
                                  Navigator.pushNamed(context, Routes.product,
                                      arguments: ProductArguments(
                                          productName: product.productName,
                                          productId: product.id,
                                          shopId: product.shopId));
                                },
                              ),
                            );
                          },
                          options: CarouselOptions(
                            viewportFraction: 0.6,
                            aspectRatio: 1.3,
                            enableInfiniteScroll: true,
                            enlargeStrategy: CenterPageEnlargeStrategy.height,
                            enlargeCenterPage: true,
                            scrollDirection: Axis.horizontal,
                          ),
                        ),
              error: (NetworkExceptions networkExceptions) =>
                  const SizedBox.shrink());
        },
      ),
    );
  }
}
