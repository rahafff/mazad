import 'package:elite_auction/core/models/base_entity.dart';
import 'package:elite_auction/features/app_navigation_bar/domain/entities/cart_and_wishlist_items_count_entity.dart';

import '../../../../core/models/api_response.dart';

abstract class NavigationBarRepository {
  Future<ApiResponse<BaseEntity<CartAndWishListItemsCountEntity>>>
      getCartAndWishlistItemCount();
}
