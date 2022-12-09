import 'package:freezed_annotation/freezed_annotation.dart';

part 'add_to_cart_body.g.dart';

@JsonSerializable()
class AddToCartBody {
  final int quantity;
  @JsonKey(name: 'product_id')
  final int productId;
  @JsonKey(name: 'variation_id')
  final int? variationId;

  factory AddToCartBody.fromJson(Map<String, dynamic> json) =>
      _$AddToCartBodyFromJson(json);

  AddToCartBody(
      {required this.quantity, required this.productId, this.variationId});

  Map<String, dynamic> toJson() => _$AddToCartBodyToJson(this);
}
