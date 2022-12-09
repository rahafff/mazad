import 'package:elite_auction/core/models/empty_success_response_entity.dart';
import 'package:elite_auction/features/wishlist/domain/bodies/delete_from_wishlist_body.dart';
import 'package:elite_auction/features/wishlist/domain/entities/wishlist_entity.dart';

import '../../../../core/models/api_response.dart';
import '../../../../core/models/base_entity.dart';
import '../bodies/add_to_wishlist_body.dart';

abstract class WishlistRepository {
  Future<ApiResponse<EmptySuccessResponseEntity>> addToWishlist(
      AddToWishlistBody body);
  Future<ApiResponse<EmptySuccessResponseEntity>> deleteFromWishlist(
      DeleteFromWishlistBody body);
  Future<ApiResponse<BaseEntity<WishlistEntity>>> getDetailedWishlist();
}
