import 'package:json_annotation/json_annotation.dart';

part 'shop_categories_entity.g.dart';

@JsonSerializable(
  includeIfNull: false,
)
class ShopCategoriesEntity {
  ShopCategoriesEntity({
    this.shop,
  });
  Shop? shop;
  factory ShopCategoriesEntity.fromJson(Map<String, dynamic> json) =>
      _$ShopCategoriesEntityFromJson(json);

  Map<String, dynamic> toJson() => _$ShopCategoriesEntityToJson(this);
}

@JsonSerializable()
class Shop {
  Shop({
    this.id,
    this.shopName,
    this.shopDescription,
    this.shopMobileDescription,
    this.shopImage,
    this.shopCategories,
  });
  int? id;
  @JsonKey(name: "shop_name")
  String? shopName;
  @JsonKey(name: "shop_description")
  String? shopDescription;
  @JsonKey(name: "shop_mobile_description")
  String? shopMobileDescription;
  @JsonKey(name: "shop_image")
  String? shopImage;
  @JsonKey(name: "shop_categories")
  List<ShopCategories>? shopCategories;
  factory Shop.fromJson(Map<String, dynamic> json) => _$ShopFromJson(json);

  Map<String, dynamic> toJson() => _$ShopToJson(this);
}

@JsonSerializable()
class ShopCategories {
  ShopCategories({
    required this.id,
    required this.shopCategoryName,
  });
  int id;
  @JsonKey(name: "shop_category_name")
  String shopCategoryName;
  factory ShopCategories.fromJson(Map<String, dynamic> json) =>
      _$ShopCategoriesFromJson(json);

  Map<String, dynamic> toJson() => _$ShopCategoriesToJson(this);
}
