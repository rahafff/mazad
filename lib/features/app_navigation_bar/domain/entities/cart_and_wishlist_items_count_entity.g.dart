// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_and_wishlist_items_count_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartAndWishListItemsCountEntity _$CartAndWishListItemsCountEntityFromJson(
        Map<String, dynamic> json) =>
    CartAndWishListItemsCountEntity(
      cartItemsCount: json['cart_items_count'] as int?,
      wishlistItemsCount: json['wishlist_items_count'] as int?,
    );

Map<String, dynamic> _$CartAndWishListItemsCountEntityToJson(
        CartAndWishListItemsCountEntity instance) =>
    <String, dynamic>{
      'cart_items_count': instance.cartItemsCount,
      'wishlist_items_count': instance.wishlistItemsCount,
    };
