import 'package:elite_auction/core/api/end_points.dart';
import 'package:elite_auction/features/app_navigation_bar/domain/entities/cart_and_wishlist_items_count_entity.dart';

import '../../../../../../core/api/api_consumer.dart';
import '../../../../../../core/models/base_entity.dart';

abstract class NavigationBarRemoteDataSource {
  Future<BaseEntity<CartAndWishListItemsCountEntity>>
      getCartAndWishlistItemCount();
}

class NavigationBarRemoteDataSourceImp
    implements NavigationBarRemoteDataSource {
  final ApiConsumer _apiConsumer;

  NavigationBarRemoteDataSourceImp(this._apiConsumer);

  @override
  Future<BaseEntity<CartAndWishListItemsCountEntity>>
      getCartAndWishlistItemCount() async {
    return await _getBaseEntityResult(
      apiCall: () => _apiConsumer.get(
        EndPoints.getCartAndWishlistItemCount,
      ),
      fromJson: (json) => CartAndWishListItemsCountEntity.fromJson(json),
    );
  }

  Future<BaseEntity<T>> _getBaseEntityResult<T>(
      {required Future<dynamic> Function() apiCall,
      required T Function(dynamic json) fromJson}) async {
    var response = await apiCall();
    return BaseEntity.fromJson(response, (json) => fromJson(json));
  }
}
