import 'package:freezed_annotation/freezed_annotation.dart';

part 'delete_from_cart_body.g.dart';

@JsonSerializable()
class DeleteFromCartBody {
  @JsonKey(name: 'product_id')
  final int productId;
  @JsonKey(name: 'variation_id')
  final int? variationId;
  factory DeleteFromCartBody.fromJson(Map<String, dynamic> json) =>
      _$DeleteFromCartBodyFromJson(json);

  DeleteFromCartBody({required this.productId, this.variationId});

  Map<String, dynamic> toJson() => _$DeleteFromCartBodyToJson(this);
}
