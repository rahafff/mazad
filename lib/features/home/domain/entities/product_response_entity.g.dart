// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_response_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductResponseEntity _$ProductResponseEntityFromJson(
        Map<String, dynamic> json) =>
    ProductResponseEntity(
      ProductEntity.fromJson(json['product'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ProductResponseEntityToJson(
        ProductResponseEntity instance) =>
    <String, dynamic>{
      'product': instance.product,
    };

ProductEntity _$ProductEntityFromJson(Map<String, dynamic> json) =>
    ProductEntity(
      id: json['id'] as int,
      categoryId: json['category_id'] as int?,
      categoryName: json['category_name'] as String?,
      subcategoryId: json['subcategory_id'] as int?,
      subcategoryName: json['subcategory_name'] as String?,
      productName: json['product_name'] as String,
      productMainImage: json['product_main_image'] as String,
      productPrice: json['product_price'] as String,
      productPriceAfterDiscount:
          json['product_price_after_discount'] as String?,
      discountRate: json['discount_rate'] as int?,
      discountName: json['discount_name'] as String?,
      isDiscountDateActive: json['is_discount_date_active'] as bool?,
      endAt: json['end_at'] as String?,
      shopName: json['shop_name'] as String?,
      shopId: json['shop_id'] as int?,
      productMobileDescription: json['product_mobile_description'] as String?,
      productImages: (json['images'] as List<dynamic>?)
          ?.map((e) => Images.fromJson(e as Map<String, dynamic>))
          .toList(),
      shopMobileDescription: json['shop_mobile_description'] as String?,
      productMaxQuantity: json['max_product_quantity'] as int?,
      productReviewAvg: (json['product_review_avg'] as num?)?.toDouble(),
      productVariations: (json['product_variations'] as List<dynamic>?)
          ?.map((e) => ProductVariation.fromJson(e as Map<String, dynamic>))
          .toList(),
      productReviewCount: json['product_reviews_count'] as int?,
    )
      ..shopCategoryId = json['shop_category_id'] as int?
      ..shopCategoryName = json['shop_category_name'] as String?;

Map<String, dynamic> _$ProductEntityToJson(ProductEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'category_id': instance.categoryId,
      'category_name': instance.categoryName,
      'subcategory_id': instance.subcategoryId,
      'subcategory_name': instance.subcategoryName,
      'product_name': instance.productName,
      'product_main_image': instance.productMainImage,
      'product_price': instance.productPrice,
      'product_price_after_discount': instance.productPriceAfterDiscount,
      'discount_rate': instance.discountRate,
      'discount_name': instance.discountName,
      'is_discount_date_active': instance.isDiscountDateActive,
      'end_at': instance.endAt,
      'shop_id': instance.shopId,
      'shop_name': instance.shopName,
      'shop_mobile_description': instance.shopMobileDescription,
      'product_mobile_description': instance.productMobileDescription,
      'max_product_quantity': instance.productMaxQuantity,
      'product_reviews_count': instance.productReviewCount,
      'product_review_avg': instance.productReviewAvg,
      'shop_category_id': instance.shopCategoryId,
      'shop_category_name': instance.shopCategoryName,
      'images': instance.productImages,
      'product_variations': instance.productVariations,
    };

Images _$ImagesFromJson(Map<String, dynamic> json) => Images(
      id: json['id'] as int?,
      productId: json['product_id'] as int?,
      imageName: json['image_name'] as String?,
    );

Map<String, dynamic> _$ImagesToJson(Images instance) => <String, dynamic>{
      'id': instance.id,
      'product_id': instance.productId,
      'image_name': instance.imageName,
    };

ProductVariation _$ProductVariationFromJson(Map<String, dynamic> json) =>
    ProductVariation(
      id: json['id'] as int?,
      productId: json['product_id'] as int?,
      sizeId: json['size_id'] as int?,
      colorId: json['color_id'] as int?,
      quantity: json['quantity'] as int?,
      productPrice: json['product_price'] as String?,
      productPriceAfterDiscount:
          json['product_price_after_discount'] as String?,
      color: json['color'] == null
          ? null
          : Color.fromJson(json['color'] as Map<String, dynamic>),
      size: json['size'] == null
          ? null
          : Size.fromJson(json['size'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ProductVariationToJson(ProductVariation instance) =>
    <String, dynamic>{
      'id': instance.id,
      'product_id': instance.productId,
      'size_id': instance.sizeId,
      'color_id': instance.colorId,
      'quantity': instance.quantity,
      'product_price': instance.productPrice,
      'product_price_after_discount': instance.productPriceAfterDiscount,
      'color': instance.color,
      'size': instance.size,
    };

Size _$SizeFromJson(Map<String, dynamic> json) => Size(
      id: json['id'] as int?,
      sizeName: json['size_name'] as String?,
    );

Map<String, dynamic> _$SizeToJson(Size instance) => <String, dynamic>{
      'id': instance.id,
      'size_name': instance.sizeName,
    };

Color _$ColorFromJson(Map<String, dynamic> json) => Color(
      id: json['id'] as int?,
      colorHexaCode: json['color_hexacode'] as String?,
      colorName: json['color_name'] as String?,
    );

Map<String, dynamic> _$ColorToJson(Color instance) => <String, dynamic>{
      'id': instance.id,
      'color_hexacode': instance.colorHexaCode,
      'color_name': instance.colorName,
    };
