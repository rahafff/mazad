import 'package:elite_auction/core/api/end_points.dart';
import 'package:elite_auction/core/resources/routes_manager.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';

class FirebaseDynamicLinkService {
  static Future<String> createDynamicLink(
      {required int productId, int? shopId}) async {
    late String linkMessage;
    final dynamicLinkParams = DynamicLinkParameters(
      link: Uri.parse(
          "https://eliteauc.page.link/product?product_id=$productId&shop_id=$shopId"),
      uriPrefix: "https://eliteauc.page.link",
      androidParameters: AndroidParameters(
        packageName: "com.sdnone.elite_auction",
        minimumVersion: 0,
        fallbackUrl: Uri.parse(EndPoints.playStoreUrl),
      ),
      iosParameters: IOSParameters(
        bundleId: "com.sdnone.elite",
        appStoreId: "1597116939",
        minimumVersion: "0",
        fallbackUrl: Uri.parse(EndPoints.appleStoreUrl),
        ipadFallbackUrl: Uri.parse(EndPoints.appleStoreUrl),
      ),
    );
    final dynamicLink =
        await FirebaseDynamicLinks.instance.buildShortLink(dynamicLinkParams);
    linkMessage = dynamicLink.shortUrl.toString();
    return linkMessage;
  }

  static void initDynamicLink(BuildContext context) async {
    final initialLink = FirebaseDynamicLinks.instance.getInitialLink();
    initialLink.then((value) {
      if (value != null) {
        _act(value, context);
      }
    });

    FirebaseDynamicLinks.instance.onLink.listen(
      (dynamicLink) {
        _act(dynamicLink, context);
      },
    );
  }

  static void _act(PendingDynamicLinkData dynamicLink, BuildContext context) {
    final deepLink = dynamicLink.link;
    final queryParams = deepLink.queryParameters;
    int productId = int.parse(
      queryParams["product_id"].toString(),
    );
    int? shopId = queryParams['shop_id'] != null
        ? int.parse(queryParams['shop_id'].toString())
        : null;
    Navigator.pushNamed(
      context,
      Routes.product,
      arguments: ProductArguments(
          productName: "", productId: productId, shopId: shopId),
    );
  }
}
