import 'package:elite_auction/core/models/empty_success_response_entity.dart';
import 'package:elite_auction/features/wishlist/data/remote/data_sources/wishlist_remote_data_source.dart';
import 'package:elite_auction/features/wishlist/domain/bodies/add_to_wishlist_body.dart';
import 'package:elite_auction/features/wishlist/domain/bodies/delete_from_wishlist_body.dart';
import 'package:elite_auction/features/wishlist/domain/entities/wishlist_entity.dart';
import 'package:elite_auction/features/wishlist/domain/repositories/wishlist_repository.dart';

import '../../../../core/error/network_exceptions.dart';
import '../../../../core/models/api_response.dart';
import '../../../../core/models/base_entity.dart';
import '../../../../core/network/netwok_info.dart';

class WishlistRepositoryImp implements WishlistRepository {
  final WishlistRemoteDataSource _wishlistRemoteDataSource;
  final NetworkInfo _networkInfo;

  WishlistRepositoryImp(this._wishlistRemoteDataSource, this._networkInfo);

  @override
  Future<ApiResponse<EmptySuccessResponseEntity>> addToWishlist(
      AddToWishlistBody body) async {
    return await _getEmptySuccessResponseEntityResult(
      () => _wishlistRemoteDataSource.addToWishlist(body),
    );
  }

  @override
  Future<ApiResponse<EmptySuccessResponseEntity>> deleteFromWishlist(
      DeleteFromWishlistBody body) async {
    return await _getEmptySuccessResponseEntityResult(
      () => _wishlistRemoteDataSource.deleteFromWishlist(body),
    );
  }

  @override
  Future<ApiResponse<BaseEntity<WishlistEntity>>> getDetailedWishlist() async {
    return await _getBaseEntityResult(
      () => _wishlistRemoteDataSource.getDetailedWishlist(),
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

  Future<ApiResponse<EmptySuccessResponseEntity>>
      _getEmptySuccessResponseEntityResult<T>(
          Future<EmptySuccessResponseEntity> Function() getResult) async {
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
