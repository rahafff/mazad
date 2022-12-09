// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wishlist_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WishlistEntity _$WishlistEntityFromJson(Map<String, dynamic> json) =>
    WishlistEntity(
      wishlist: Wishlist.fromJson(json['wishlist'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$WishlistEntityToJson(WishlistEntity instance) =>
    <String, dynamic>{
      'wishlist': instance.wishlist,
    };

Wishlist _$WishlistFromJson(Map<String, dynamic> json) => Wishlist(
      id: json['id'] as int?,
      wishlistItems: (json['wishlist_items'] as List<dynamic>?)
          ?.map((e) => WishlistItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      wishlistItemsCount: json['wishlist_items_count'] as int?,
    );

Map<String, dynamic> _$WishlistToJson(Wishlist instance) => <String, dynamic>{
      'id': instance.id,
      'wishlist_items_count': instance.wishlistItemsCount,
      'wishlist_items': instance.wishlistItems,
    };

WishlistItem _$WishlistItemFromJson(Map<String, dynamic> json) => WishlistItem(
      id: json['id'] as int,
      productName: json['product_name'] as String,
      productMobileDescription: json['product_mobile_description'] as String?,
      maxProductQuantity: json['max_product_quantity'] as int,
      productPrice: json['product_price'] as String,
      productMainImage: json['product_main_image'] as String,
      productReviewAvg: json['product_review_avg'] as num,
      productReviewsCount: json['product_reviews_count'] as int,
      shopId: json['shop_id'] as int?,
      productPriceAfterDiscount:
          json['product_price_after_discount'] as String?,
      discountRate: json['discount_rate'] as int?,
      discountName: json['discount_name'] as String?,
    );

Map<String, dynamic> _$WishlistItemToJson(WishlistItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'product_name': instance.productName,
      'product_mobile_description': instance.productMobileDescription,
      'max_product_quantity': instance.maxProductQuantity,
      'product_price': instance.productPrice,
      'product_main_image': instance.productMainImage,
      'product_review_avg': instance.productReviewAvg,
      'product_reviews_count': instance.productReviewsCount,
      'shop_id': instance.shopId,
      'product_price_after_discount': instance.productPriceAfterDiscount,
      'discount_rate': instance.discountRate,
      'discount_name': instance.discountName,
    };
