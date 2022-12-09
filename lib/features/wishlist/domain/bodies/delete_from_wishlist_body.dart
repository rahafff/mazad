import 'package:freezed_annotation/freezed_annotation.dart';

part 'delete_from_wishlist_body.g.dart';

@JsonSerializable()
class DeleteFromWishlistBody {
  @JsonKey(name: 'product_id')
  final int productId;

  factory DeleteFromWishlistBody.fromJson(Map<String, dynamic> json) =>
      _$DeleteFromWishlistBodyFromJson(json);

  DeleteFromWishlistBody({required this.productId});

  Map<String, dynamic> toJson() => _$DeleteFromWishlistBodyToJson(this);
}
