import 'package:elite_auction/core/resources/routes_manager.dart';
import 'package:elite_auction/features/settings/domain/entities/customer_paginated_product_entity.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/api/end_points.dart';
import 'my_product_listview_item.dart';

class MyProductsListView extends StatelessWidget {
  const MyProductsListView({
    Key? key,
    required this.products,
  }) : super(key: key);
  final List<CustomerPaginatedProductEntity?> products;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: EdgeInsets.symmetric(vertical: 1.0.h, horizontal: 5.0.w),
        physics: const ScrollPhysics(),
        shrinkWrap: true,
        itemCount: products.length,
        itemBuilder: (BuildContext context, index)
        {
          final product = products[index];
          if (index == (products.length))
          {
            return SizedBox(
              height: 4.5.h,
            );
          }
          return MyProductListviewItem(
            image: EndPoints.baseUrl + product!.productMainImage,
            name: product.productDetails[0].productName,
            price: product.productPrice.toString(),
            ownerName: product.user.fullName,
            statusCode: product.productStatus.productStatusCode,
            isMine: true,
            onTap: () {
              Navigator.pushNamed(context, Routes.myProductDetails,
                  arguments: MyProductDetailsArguments(productId: product.id));
            },
          );
        });
  }
}
