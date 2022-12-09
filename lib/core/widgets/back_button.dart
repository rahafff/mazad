import 'dart:math';

import 'package:elite_auction/core/resources/assets_manager.dart';
import 'package:flutter/material.dart';

import '../utils/global.dart';


class BackButtonWidget extends StatelessWidget {
  const BackButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return lang
        ? GestureDetector(
            onTap: () {
              isCustomerScreen=false;
              Navigator.pop(context);
            },
            child: Transform.translate(
              offset: const Offset(0, 2),
              child: Transform.scale(
                scale: 1.2,
                child: Image.asset(ImageAssetsManager.back),
              ),
            ),
          )
        : GestureDetector(
            onTap: () {
              isCustomerScreen=false;
              Navigator.pop(context);
            },
            child: Transform.translate(
              offset: const Offset(0, -2),
              child: Transform.rotate(
                angle: pi,
                child: Transform.scale(
                  scale: 1.2,
                  child: Image.asset(ImageAssetsManager.back),
                ),
              ),
            ),
          );
  }
}
