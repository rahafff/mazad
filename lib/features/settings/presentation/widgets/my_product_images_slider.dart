import 'package:elite_auction/core/api/end_points.dart';
import 'package:elite_auction/features/home/presentation/widgets/product_widgets/product_image.dart';
import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';

import '../../../../core/widgets/network_video_player.dart';
import '../../domain/entities/my_product_details_entity.dart';

class MyProductImagesSlider extends StatefulWidget {
  const MyProductImagesSlider(
      {Key? key, required this.product, required this.onPageChanged})
      : super(key: key);
  final MyProductDetailsEntity product;
  final Function(int) onPageChanged;
  @override
  State<MyProductImagesSlider> createState() => _MyProductImagesSliderState();
}

class _MyProductImagesSliderState extends State<MyProductImagesSlider> {


  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: ExpandablePageView(
        onPageChanged: widget.onPageChanged,
        physics: const PageScrollPhysics(),
        children: [
          ProductImage(
            productImage: EndPoints.baseUrl + widget.product.productMainImage.toString(),
          ),
          if (widget.product.productImages != null ||
              widget.product.productImages!.isNotEmpty) ...[
            for (var image in widget.product.productImages!)
              image.fileType=='image'? ProductImage(
                productImage: EndPoints.baseUrl + image.imageName.toString(),
              ): NetworkVideoPlayer(videoURL:EndPoints.baseUrl+image.imageName.toString()),
          ]
  ]
      ),
    );
  }
}
