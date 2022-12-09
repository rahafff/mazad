import 'package:elite_auction/core/api/end_points.dart';
import 'package:elite_auction/core/models/empty_success_response_entity.dart';
import 'package:elite_auction/features/wishlist/domain/bodies/add_to_wishlist_body.dart';
import 'package:elite_auction/features/wishlist/domain/bodies/delete_from_wishlist_body.dart';
import 'package:elite_auction/features/wishlist/domain/entities/wishlist_entity.dart';

import '../../../../../core/api/api_consumer.dart';
import '../../../../../core/models/base_entity.dart';

abstract class WishlistRemoteDataSource {
  Future<EmptySuccessResponseEntity> addToWishlist(AddToWishlistBody body);
  Future<EmptySuccessResponseEntity> deleteFromWishlist(
      DeleteFromWishlistBody body);
  Future<BaseEntity<WishlistEntity>> getDetailedWishlist();
}

class WishlistRemoteDataSourceImp implements WishlistRemoteDataSource {
  final ApiConsumer _apiConsumer;

  WishlistRemoteDataSourceImp(this._apiConsumer);
  @override
  Future<EmptySuccessResponseEntity> addToWishlist(
      AddToWishlistBody body) async {
    return await _getEmptySuccessResponseResult(
      () => _apiConsumer.post(
        EndPoints.addToWishlist,
        body: body.toJson(),
      ),
    );
  }

  @override
  Future<EmptySuccessResponseEntity> deleteFromWishlist(
      DeleteFromWishlistBody body) async {
    return await _getEmptySuccessResponseResult(
      () => _apiConsumer.post(
        EndPoints.deleteFromWishlist,
        body: body.toJson(),
      ),
    );
  }

  @override
  Future<BaseEntity<WishlistEntity>> getDetailedWishlist() async {
    return await _getBaseEntityResult(
      apiCall: () => _apiConsumer.get(
        EndPoints.getDetailedWishlist,
      ),
      fromJson: (json) => WishlistEntity.fromJson(json),
    );
  }

  Future<BaseEntity<T>> _getBaseEntityResult<T>(
      {required Future<dynamic> Function() apiCall,
      required T Function(dynamic json) fromJson}) async {
    var response = await apiCall();
    return BaseEntity.fromJson(response, (json) => fromJson(json));
  }

  Future<EmptySuccessResponseEntity> _getEmptySuccessResponseResult<T>(
      Future<dynamic> Function() apiCall) async {
    var response = await apiCall();
    return EmptySuccessResponseEntity.fromJson(response);
  }
}
