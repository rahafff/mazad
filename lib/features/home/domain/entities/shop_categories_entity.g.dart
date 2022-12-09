// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shop_categories_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShopCategoriesEntity _$ShopCategoriesEntityFromJson(
        Map<String, dynamic> json) =>
    ShopCategoriesEntity(
      shop: json['shop'] == null
          ? null
          : Shop.fromJson(json['shop'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ShopCategoriesEntityToJson(
    ShopCategoriesEntity instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('shop', instance.shop);
  return val;
}

Shop _$ShopFromJson(Map<String, dynamic> json) => Shop(
      id: json['id'] as int?,
      shopName: json['shop_name'] as String?,
      shopDescription: json['shop_description'] as String?,
      shopMobileDescription: json['shop_mobile_description'] as String?,
      shopImage: json['shop_image'] as String?,
      shopCategories: (json['shop_categories'] as List<dynamic>?)
          ?.map((e) => ShopCategories.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ShopToJson(Shop instance) => <String, dynamic>{
      'id': instance.id,
      'shop_name': instance.shopName,
      'shop_description': instance.shopDescription,
      'shop_mobile_description': instance.shopMobileDescription,
      'shop_image': instance.shopImage,
      'shop_categories': instance.shopCategories,
    };

ShopCategories _$ShopCategoriesFromJson(Map<String, dynamic> json) =>
    ShopCategories(
      id: json['id'] as int,
      shopCategoryName: json['shop_category_name'] as String,
    );

Map<String, dynamic> _$ShopCategoriesToJson(ShopCategories instance) =>
    <String, dynamic>{
      'id': instance.id,
      'shop_category_name': instance.shopCategoryName,
    };
