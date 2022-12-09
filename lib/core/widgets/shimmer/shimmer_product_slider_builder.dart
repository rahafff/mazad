import 'package:carousel_slider/carousel_slider.dart';
import 'package:elite_auction/core/widgets/shimmer/shimmer_product_card.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ShimmerProductsSliderBuilder extends StatelessWidget {
  const ShimmerProductsSliderBuilder({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 3.0.h, horizontal: 3.0.w),
      child: CarouselSlider(
        items: [
          ShimmerProductCard(),
          ShimmerProductCard(),
          ShimmerProductCard()
        ],
        options: CarouselOptions(
          viewportFraction: 0.5,
          initialPage: 0,
          aspectRatio: 1.3,
          enableInfiniteScroll: true,
          reverse: false,
          autoPlay: false,
          enlargeCenterPage: true,
          scrollDirection: Axis.horizontal,
        ),
      ),
    );
  }
}
