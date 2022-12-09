import 'package:elite_auction/core/models/api_response.dart';
import 'package:elite_auction/core/models/base_entity.dart';
import 'package:elite_auction/features/app_navigation_bar/data/data_sources/remote_data_source/navigation_bar_remote_data_source.dart';
import 'package:elite_auction/features/app_navigation_bar/domain/entities/cart_and_wishlist_items_count_entity.dart';
import 'package:elite_auction/features/app_navigation_bar/domain/repositories/navigation_bar_repository.dart';

import '../../../../core/error/network_exceptions.dart';
import '../../../../core/network/netwok_info.dart';

class NavigationBarRepositoryImp implements NavigationBarRepository {
  final NavigationBarRemoteDataSource _navigationBarRemoteDataSource;
  final NetworkInfo _networkInfo;

  NavigationBarRepositoryImp(
      this._navigationBarRemoteDataSource, this._networkInfo);
  @override
  Future<ApiResponse<BaseEntity<CartAndWishListItemsCountEntity>>>
      getCartAndWishlistItemCount() async {
    return await _getBaseEntityResult(
      () => _navigationBarRemoteDataSource.getCartAndWishlistItemCount(),
    );
  }

  Future<ApiResponse<BaseEntity<T>>> _getBaseEntityResult<T>(
      Future<BaseEntity<T>> Function() getResult) async {
    try {
      if (await _networkInfo.isConnected) {
        var response = await getResult();
        return ApiResponse.success(response);
      } else {
        return const ApiResponse.failure(
            NetworkExceptions.noInternetConnection());
      }
    } catch (error) {
      return ApiResponse.failure(NetworkExceptions.getException(error));
    }
  }
}
