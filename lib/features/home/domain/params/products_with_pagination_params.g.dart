// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'products_with_pagination_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductsWithPaginationParams _$ProductsWithPaginationParamsFromJson(
        Map<String, dynamic> json) =>
    ProductsWithPaginationParams(
      page: json['page'] as int?,
      perPage: json['per_page'] ?? 8,
      shopId: json['shop_id'] as int?,
      search: json['search'] as String?,
      categoryId: json['category_id'] as int?,
      subcategoryId: json['subcategory_id'] as int?,
      productId: json['product_id'] as int?,
      shopCategoryId: json['shop_category_id'] as int?,
      subsubcategoryId: json['subsubcategory_id'] as int?,
    );

Map<String, dynamic> _$ProductsWithPaginationParamsToJson(
        ProductsWithPaginationParams instance) =>
    <String, dynamic>{
      'page': instance.page,
      'search': instance.search,
      'per_page': instance.perPage,
      'shop_id': instance.shopId,
      'shop_category_id': instance.shopCategoryId,
      'product_id': instance.productId,
      'category_id': instance.categoryId,
      'subcategory_id': instance.subcategoryId,
      'subsubcategory_id': instance.subsubcategoryId,
    };
