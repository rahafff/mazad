import 'package:elite_auction/core/utils/firebase_dynamic_link_service.dart';
import 'package:share_plus/share_plus.dart';

class ProductShare {
  static Future<void> share({required int productId, int? shopId}) async {
    String link = await FirebaseDynamicLinkService.createDynamicLink(
        productId: productId, shopId: shopId);
    String details = "Check This out\n$link";
    Share.share(details);
  }
}
