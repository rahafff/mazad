import 'package:freezed_annotation/freezed_annotation.dart';

part 'wishlist_entity.g.dart';

@JsonSerializable()
class WishlistEntity {
  WishlistEntity({
    required this.wishlist,
  });
  Wishlist wishlist;
  factory WishlistEntity.fromJson(Map<String, dynamic> json) =>
      _$WishlistEntityFromJson(json);

  Map<String, dynamic> toJson() => _$WishlistEntityToJson(this);
}

@JsonSerializable()
class Wishlist {
  Wishlist({this.id, this.wishlistItems, this.wishlistItemsCount});
  factory Wishlist.fromJson(Map<String, dynamic> json) =>
      _$WishlistFromJson(json);

  Map<String, dynamic> toJson() => _$WishlistToJson(this);
  int? id;
  @JsonKey(name: 'wishlist_items_count')
  int? wishlistItemsCount;
  @JsonKey(name: 'wishlist_items')
  List<WishlistItem>? wishlistItems;
}

@JsonSerializable()
class WishlistItem {
  WishlistItem({
    required this.id,
    required this.productName,
    this.productMobileDescription,
    required this.maxProductQuantity,
    required this.productPrice,
    required this.productMainImage,
    required this.productReviewAvg,
    required this.productReviewsCount,
    this.shopId,
    this.productPriceAfterDiscount,
    this.discountRate,
    this.discountName,
  });
  factory WishlistItem.fromJson(Map<String, dynamic> json) =>
      _$WishlistItemFromJson(json);

  Map<String, dynamic> toJson() => _$WishlistItemToJson(this);
  int id;
  @JsonKey(name: 'product_name')
  String productName;
  @JsonKey(name: 'product_mobile_description')
  String? productMobileDescription;
  @JsonKey(name: 'max_product_quantity')
  int maxProductQuantity;
  @JsonKey(name: 'product_price')
  String productPrice;
  @JsonKey(name: 'product_main_image')
  String productMainImage;
  @JsonKey(name: 'product_review_avg')
  num productReviewAvg;
  @JsonKey(name: 'product_reviews_count')
  int productReviewsCount;
  @JsonKey(name: 'shop_id')
  int? shopId;
  @JsonKey(name: 'product_price_after_discount')
  String? productPriceAfterDiscount;
  @JsonKey(name: 'discount_rate')
  int? discountRate;
  @JsonKey(name: 'discount_name')
  String? discountName;
}
