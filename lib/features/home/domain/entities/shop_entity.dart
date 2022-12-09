import 'package:freezed_annotation/freezed_annotation.dart';

part 'shop_entity.g.dart';

@JsonSerializable()
class ShopEntity {
  int? id;
  @JsonKey(name: "shop_name")
  String? shopName;
  @JsonKey(name: "shop_mobile_description")
  String? shopMobileDescription;
  @JsonKey(name: "shop_image")
  String? shopImage;

  ShopEntity({
    this.id,
    this.shopName,
    this.shopMobileDescription,
    this.shopImage,
  });
  factory ShopEntity.fromJson(Map<String, dynamic> json,) => _$ShopEntityFromJson(json);
  Map<String, dynamic> toJson() => _$ShopEntityToJson(this);
}
