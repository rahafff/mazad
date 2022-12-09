import 'package:flutter/material.dart';

class ProductImage extends StatelessWidget {
  final String productImage;

  const ProductImage({
    Key? key,
    required this.productImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Image.network(
        productImage,
        fit: BoxFit.fill,
      ),
    );
  }
}
