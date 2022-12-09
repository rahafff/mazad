import 'package:elite_auction/core/models/base_entity.dart';
import 'package:elite_auction/core/models/empty_success_response_entity.dart';
import 'package:elite_auction/features/cart/domain/bodies/delete_from_cart_body.dart';
import 'package:elite_auction/features/cart/domain/entities/cart_entity.dart';
import 'package:elite_auction/features/cart/domain/entities/online_payment_entity.dart';
import 'package:elite_auction/features/cart/domain/entities/search_detailes_response_entity.dart';
import 'package:elite_auction/features/cart/domain/entities/search_response_entity.dart';

import '../../../../core/models/api_response.dart';
import '../bodies/add_to_cart_body.dart';
import '../bodies/checkout_body.dart';

abstract class CartRepository {
  Future<ApiResponse<EmptySuccessResponseEntity>> addToCart(AddToCartBody body);
  Future<ApiResponse<BaseEntity<OnlinePaymentEntity>>> createPayment();
  Future<ApiResponse<EmptySuccessResponseEntity>> deleteFromCart(
      DeleteFromCartBody body);
  Future<ApiResponse<BaseEntity<CartEntity>>> getDetailedCart();
  Future<ApiResponse<List<Prediction>>> getSearchResults(String search,String sessionToken);
  Future<ApiResponse<Geometry>> getSearchDeResults(String placeId);
  //added by me
  Future<ApiResponse<EmptySuccessResponseEntity>> checkout(CheckOutBody body);
}
