import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

import '../../../../../core/resources/color_manager.dart';

class ShopWidget extends StatelessWidget {
  const ShopWidget({
    Key? key,
    required this.shopName,
    required this.shopImage,
    required this.onTappingShop,
  }) : super(key: key);

  final String shopName;
  final String shopImage;
  final VoidCallback? onTappingShop;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTappingShop,
      child: Container(
        color: ColorManager.kWhite,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 3,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: ColorManager.kWhite,
                  boxShadow: const [
                    BoxShadow(
                      offset: Offset(0, 4),
                      blurRadius: 2,
                      color: Colors.grey,
                    )
                  ],
                  image: DecorationImage(
                      image: ExtendedNetworkImageProvider(
                        shopImage,
                       
                      ),
                      fit: BoxFit.scaleDown),
                ),
              ),
            ),
            Expanded(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  shopName.toUpperCase(),
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      ?.copyWith(color: ColorManager.kGreen),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
