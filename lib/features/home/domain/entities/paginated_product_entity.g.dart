// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paginated_product_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaginatedProductEntity _$PaginatedProductEntityFromJson(
        Map<String, dynamic> json) =>
    PaginatedProductEntity(
      id: json['id'] as int,
      productName: json['product_name'] as String,
      productMainImage: json['product_main_image'] as String,
      productPrice: json['product_price'] as String,
      productPriceAfterDiscount:
          json['product_price_after_discount'] as String?,
      discountRate: json['discount_rate'] as int?,
      shopId: json['shop_id'] as int?,
      productReviewAvg: (json['product_review_avg'] as num?)?.toDouble(),
      productReviewCount: json['product_reviews_count'] as int?,
    );

Map<String, dynamic> _$PaginatedProductEntityToJson(
        PaginatedProductEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'product_name': instance.productName,
      'product_main_image': instance.productMainImage,
      'product_price': instance.productPrice,
      'product_price_after_discount': instance.productPriceAfterDiscount,
      'discount_rate': instance.discountRate,
      'shop_id': instance.shopId,
      'product_reviews_count': instance.productReviewCount,
      'product_review_avg': instance.productReviewAvg,
    };
