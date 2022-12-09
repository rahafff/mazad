import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../../core/resources/color_manager.dart';

class ProductDescription extends StatelessWidget {
  const ProductDescription({Key? key, required this.productDescription})
      : super(key: key);
  final String? productDescription;
  @override
  Widget build(BuildContext context) {
    return productDescription != null
        ? Container(
            width: double.infinity,
            color: ColorManager.kWhite,
            padding: EdgeInsets.all(2.0.w),
            child: AutoSizeText(
              productDescription!,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyText1,
            ),
          )
        : Container();
  }
}
