import 'package:freezed_annotation/freezed_annotation.dart';

part 'add_to_wishlist_body.g.dart';

@JsonSerializable()
class AddToWishlistBody {
  @JsonKey(name: 'product_id')
  final int productId;

  factory AddToWishlistBody.fromJson(Map<String, dynamic> json) =>
      _$AddToWishlistBodyFromJson(json);

  AddToWishlistBody({required this.productId});

  Map<String, dynamic> toJson() => _$AddToWishlistBodyToJson(this);
}
