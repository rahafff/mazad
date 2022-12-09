// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delete_from_cart_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeleteFromCartBody _$DeleteFromCartBodyFromJson(Map<String, dynamic> json) =>
    DeleteFromCartBody(
      productId: json['product_id'] as int,
      variationId: json['variation_id'] as int?,
    );

Map<String, dynamic> _$DeleteFromCartBodyToJson(DeleteFromCartBody instance) =>
    <String, dynamic>{
      'product_id': instance.productId,
      'variation_id': instance.variationId,
    };
