import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_params.g.dart';

@JsonSerializable()
class ProductParams {
  @JsonKey(name: "product_id")
  int productId;
  @JsonKey(name: "shop_id")
  int? shopId;

  ProductParams({
    required this.productId,
    this.shopId,
  });
  factory ProductParams.fromJson(Map<String, dynamic> json) =>
      _$ProductParamsFromJson(json);

  Map<String, dynamic> toJson() => _$ProductParamsToJson(this);
}
