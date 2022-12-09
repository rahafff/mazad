import 'package:freezed_annotation/freezed_annotation.dart';

part 'shop_categories_params.g.dart';

@JsonSerializable()
class ShopCategoriesParams {
  @JsonKey(name: "shop_id")
  int shopId;

  ShopCategoriesParams({
    required this.shopId,
  });
  factory ShopCategoriesParams.fromJson(Map<String, dynamic> json) =>
      _$ShopCategoriesParamsFromJson(json);

  Map<String, dynamic> toJson() => _$ShopCategoriesParamsToJson(this);
}
