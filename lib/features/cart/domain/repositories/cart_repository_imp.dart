import 'package:elite_auction/core/models/empty_success_response_entity.dart';
import 'package:elite_auction/features/cart/data/remote/data_sources/cart_remote_data_source.dart';
import 'package:elite_auction/features/cart/domain/bodies/add_to_cart_body.dart';
import 'package:elite_auction/features/cart/domain/bodies/checkout_body.dart';
import 'package:elite_auction/features/cart/domain/bodies/delete_from_cart_body.dart';
import 'package:elite_auction/features/cart/domain/entities/cart_entity.dart';
import 'package:elite_auction/features/cart/domain/entities/online_payment_entity.dart';
import 'package:elite_auction/features/cart/domain/entities/search_detailes_response_entity.dart';
import 'package:elite_auction/features/cart/domain/entities/search_response_entity.dart';
import 'package:elite_auction/features/cart/domain/repositories/cart_repository.dart';

import '../../../../core/error/network_exceptions.dart';
import '../../../../core/models/api_response.dart';
import '../../../../core/models/base_entity.dart';
import '../../../../core/network/netwok_info.dart';

class CartRepositoryImp implements CartRepository {
  final CartRemoteDataSource _cartRemoteDataSource;
  final NetworkInfo _networkInfo;

  CartRepositoryImp(this._cartRemoteDataSource, this._networkInfo);

  @override
  Future<ApiResponse<EmptySuccessResponseEntity>> addToCart(
      AddToCartBody body) async {
    return await _getEmptySuccessResponseEntityResult(
      () => _cartRemoteDataSource.addToCart(body),
    );
  }

  @override
  Future<ApiResponse<BaseEntity<CartEntity>>> getDetailedCart() async {
    return await _getBaseEntityResult(
      () => _cartRemoteDataSource.getDetailedCart(),
    );
  }

  @override
  Future<ApiResponse<EmptySuccessResponseEntity>> deleteFromCart(
      DeleteFromCartBody body) async {
    return await _getEmptySuccessResponseEntityResult(
      () => _cartRemoteDataSource.deleteFromCart(body),
    );
  }

  @override
  Future<ApiResponse<EmptySuccessResponseEntity>> checkout(
      CheckOutBody body) async {
    return await _getEmptySuccessResponseEntityResult(
      () => _cartRemoteDataSource.checkout(body),
    );
  }

  @override
  Future<ApiResponse<BaseEntity<OnlinePaymentEntity>>> createPayment() async {
    return await _getBaseEntityResult(
      () => _cartRemoteDataSource.createPayment(),
    );
  }

  @override
  Future<ApiResponse<List<Prediction>>> getSearchResults(
      String search,String sessionToken) async {
    try {
    if (await _networkInfo.isConnected) {
      var response = await _cartRemoteDataSource.getSearchResults(search,sessionToken);
      return ApiResponse.success(response);
    } else {
      return const ApiResponse.failure(
          NetworkExceptions.noInternetConnection());
    }
    } catch (error) {
      return ApiResponse.failure(NetworkExceptions.getException(error));
    }
  }

  @override
  Future<ApiResponse<Geometry>> getSearchDeResults(
      String palceId ) async {
    try {
    if (await _networkInfo.isConnected) {
      var response = await _cartRemoteDataSource.getSearchDeResults(palceId);
      return ApiResponse.success(response);
    } else {
      return const ApiResponse.failure(
          NetworkExceptions.noInternetConnection());
    }
    } catch (error) {
      return ApiResponse.failure(NetworkExceptions.getException(error));
    }
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
