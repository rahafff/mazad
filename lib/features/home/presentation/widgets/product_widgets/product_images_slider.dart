import 'package:elite_auction/core/api/end_points.dart';
import 'package:elite_auction/features/home/presentation/widgets/product_widgets/product_image.dart';
import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';

import '../../../domain/entities/product_response_entity.dart';

class ProductImagesSlider extends StatefulWidget {
  const ProductImagesSlider(
      {Key? key, required this.product, required this.onPageChanged})
      : super(key: key);
  final ProductEntity product;
  final Function(int) onPageChanged;
  @override
  State<ProductImagesSlider> createState() => _ProductImagesSliderState();
}

class _ProductImagesSliderState extends State<ProductImagesSlider> {
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: ExpandablePageView(
        onPageChanged: widget.onPageChanged,
        physics: const PageScrollPhysics(),
        children: [
          if (widget.product.productImages == null ||
              widget.product.productImages!.isEmpty) ...[
            ProductImage(
              productImage: EndPoints.baseUrl + widget.product.productMainImage,
            ),
          ] else
            for (var image in widget.product.productImages!)
              ProductImage(
                productImage: EndPoints.baseUrl + image.imageName.toString(),
              ),
        ],
      ),
    );
  }
}
