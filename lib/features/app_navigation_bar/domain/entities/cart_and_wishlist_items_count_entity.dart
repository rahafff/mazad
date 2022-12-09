import 'package:freezed_annotation/freezed_annotation.dart';

part 'cart_and_wishlist_items_count_entity.g.dart';

@JsonSerializable()
class CartAndWishListItemsCountEntity {
  @JsonKey(name: 'cart_items_count')
  int? cartItemsCount;
  @JsonKey(name: 'wishlist_items_count')
  int? wishlistItemsCount;

  CartAndWishListItemsCountEntity(
      {this.cartItemsCount, this.wishlistItemsCount});
  factory CartAndWishListItemsCountEntity.fromJson(Map<String, dynamic> json) =>
      _$CartAndWishListItemsCountEntityFromJson(json);

  Map<String, dynamic> toJson() =>
      _$CartAndWishListItemsCountEntityToJson(this);
}
