// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shop_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShopEntity _$ShopEntityFromJson(Map<String, dynamic> json) => ShopEntity(
      id: json['id'] as int?,
      shopName: json['shop_name'] as String?,
      shopMobileDescription: json['shop_mobile_description'] as String?,
      shopImage: json['shop_image'] as String?,
    );

Map<String, dynamic> _$ShopEntityToJson(ShopEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'shop_name': instance.shopName,
      'shop_mobile_description': instance.shopMobileDescription,
      'shop_image': instance.shopImage,
    };
