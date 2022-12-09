import 'package:elite_auction/features/home/domain/entities/paginated_product_entity.dart';
import 'package:elite_auction/features/home/presentation/widgets/product_card.dart';
import 'package:elite_auction/features/home/presentation/widgets/product_widgets/product_options_dialog.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/api/end_points.dart';
import '../../../../core/resources/routes_manager.dart';
import '../../../../core/utils/Share/share.dart';

class ProductsGridView extends StatelessWidget {
  final List<PaginatedProductEntity?> products;

  const ProductsGridView({Key? key, required this.products}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const ScrollPhysics(),
      itemCount: products.length,
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 0.7,
          crossAxisCount: 2,
          crossAxisSpacing: 3.0.w,
          mainAxisSpacing: 2.0.h),
      padding: EdgeInsets.only(left: 3.0.w, right: 3.0.w, top: 2.0.h),
      itemBuilder: (BuildContext context, int index) {
        final product = products[index];
        if (index == (products.length)) {
          return SizedBox(
            height: 4.5.h,
          );
        }
        return ProductCard(
          animalImage: EndPoints.baseUrl + product!.productMainImage.toString(),
          animalName: product.productName.toString(),
          reviewsCount: product.productReviewCount,
          reviewAverage: product.productReviewAvg,
          animalPrice: product.productPrice.toString(),
          animalPriceAfterDiscount: product.productPriceAfterDiscount,
          discountRate: product.discountRate,
          onTappingShareButton: () {
            ProductShare.share(productId: product.id,shopId: product.shopId);
          },
          onTappingAddButton: () {
            showDialog(
              context: context,
              builder: (context) => ProductOptionsDialog(
                product: products[index]!,
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
        );
      },
    );
  }
}
