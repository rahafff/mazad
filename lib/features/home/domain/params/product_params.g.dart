// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductParams _$ProductParamsFromJson(Map<String, dynamic> json) =>
    ProductParams(
      productId: json['product_id'] as int,
      shopId: json['shop_id'] as int?,
    );

Map<String, dynamic> _$ProductParamsToJson(ProductParams instance) =>
    <String, dynamic>{
      'product_id': instance.productId,
      'shop_id': instance.shopId,
    };
