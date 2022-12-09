import 'package:elite_auction/core/api/end_points.dart';
import 'package:elite_auction/core/models/empty_success_response_entity.dart';
import 'package:elite_auction/features/cart/domain/bodies/add_to_cart_body.dart';
import 'package:elite_auction/features/cart/domain/bodies/delete_from_cart_body.dart';
import 'package:elite_auction/features/cart/domain/entities/cart_entity.dart';
import 'package:elite_auction/features/cart/domain/entities/search_detailes_response_entity.dart';
import 'package:elite_auction/features/cart/domain/entities/search_response_entity.dart';

import '../../../../../core/api/api_consumer.dart';
import '../../../../../core/models/base_entity.dart';
import '../../../domain/bodies/checkout_body.dart';
import '../../../domain/entities/online_payment_entity.dart';

abstract class CartRemoteDataSource {
  Future<EmptySuccessResponseEntity> addToCart(AddToCartBody body);

  Future<EmptySuccessResponseEntity> deleteFromCart(DeleteFromCartBody body);

  Future<BaseEntity<CartEntity>> getDetailedCart();
  Future<List<Prediction>> getSearchResults(String search,String sessionToken);
  Future<Geometry> getSearchDeResults(String palceId );

  Future<BaseEntity<OnlinePaymentEntity>> createPayment();

  Future<EmptySuccessResponseEntity> checkout(CheckOutBody body);
}
const kGoogleApiKey = "AIzaSyB6yd5r3BEwDcbxRDdxosYrTJrClix6lXA";

class CartRemoteDataSourceImp implements CartRemoteDataSource {
  final ApiConsumer _apiConsumer;

  CartRemoteDataSourceImp(this._apiConsumer);

  @override
  Future<EmptySuccessResponseEntity> addToCart(AddToCartBody body) async {
    return await _getEmptySuccessResponseResult(
      () => _apiConsumer.post(
        EndPoints.addToCart,
        body: body.toJson(),
      ),
    );
  }

  @override
  Future<BaseEntity<CartEntity>> getDetailedCart() async {
    return await _getBaseEntityResult(
      apiCall: () => _apiConsumer.get(
        EndPoints.getDetailedCart,
      ),
      fromJson: (json) => CartEntity.fromJson(json),
    );
  }

  @override
  Future<EmptySuccessResponseEntity> deleteFromCart(
      DeleteFromCartBody body) async {
    return await _getEmptySuccessResponseResult(
      () => _apiConsumer.post(
        EndPoints.deleteFromCart,
        body: body.toJson(),
      ),
    );
  }

  @override
  Future<BaseEntity<OnlinePaymentEntity>> createPayment() async {
    return await _getBaseEntityResult(
      apiCall: () => _apiConsumer.post(EndPoints.createPayment),
      fromJson: (json) => OnlinePaymentEntity.fromJson(json),
    );
  }

  @override
  Future<List<Prediction>> getSearchResults(String search,String sessionToken) async {
    var response = await _apiConsumer.get(EndPoints.googleSearchPlacesBaseUrl,
        queryParameters: {
          'input': search,
          'key': kGoogleApiKey,
          'sessiontoken': sessionToken,
          
        });
    List<Prediction> locations = [];
    SearchResponseEntity jj = SearchResponseEntity();
    print("palllllaaccesssssss" '${response.toString()}');
    jj =  SearchResponseEntity.fromJson(response);
    locations = jj.predictions ?? [];
    return locations;
  }

  @override
  Future<Geometry> getSearchDeResults(String search) async {
    var response = await _apiConsumer.get(EndPoints.googleSearchPlacesDeBaseUrl,
        queryParameters: {
          'place_id': search,
          'key': kGoogleApiKey,});
    // List<Prediction> locations = [];
    print(response);
    print('detttaaillllesss');
    SearchDetResponseEntity  jj = SearchDetResponseEntity();
    // print("palllllaaccesssssss" '${response.toString()}');
    jj =  SearchDetResponseEntity.fromJson(response);
    // locations = jj.predictions ?? [];
    return jj.result?.geometry ?? Geometry();
  }

  @override
  Future<EmptySuccessResponseEntity> checkout(CheckOutBody body) async {
    return await _getEmptySuccessResponseResult(
      () => _apiConsumer.post(EndPoints.checkout, body: body.toJson()),
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
