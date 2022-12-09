// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_to_cart_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddToCartBody _$AddToCartBodyFromJson(Map<String, dynamic> json) =>
    AddToCartBody(
      quantity: json['quantity'] as int,
      productId: json['product_id'] as int,
      variationId: json['variation_id'] as int?,
    );

Map<String, dynamic> _$AddToCartBodyToJson(AddToCartBody instance) =>
    <String, dynamic>{
      'quantity': instance.quantity,
      'product_id': instance.productId,
      'variation_id': instance.variationId,
    };
