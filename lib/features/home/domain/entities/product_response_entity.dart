import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_response_entity.g.dart';

@JsonSerializable()
class ProductResponseEntity {
  ProductEntity product;

  ProductResponseEntity(this.product);

  factory ProductResponseEntity.fromJson(Map<String, dynamic> json) =>
      _$ProductResponseEntityFromJson(json);

  Map<String, dynamic> toJson() => _$ProductResponseEntityToJson(this);
}

@JsonSerializable()
class ProductEntity {
  int id;
  @JsonKey(name: "category_id")
  int? categoryId;
  @JsonKey(name: "category_name")
  String? categoryName;
  @JsonKey(name: "subcategory_id")
  int? subcategoryId;
  @JsonKey(name: "subcategory_name")
  String? subcategoryName;
  @JsonKey(name: "product_name")
  String productName;
  @JsonKey(name: "product_main_image")
  String productMainImage;
  @JsonKey(name: "product_price")
  String productPrice;
  @JsonKey(name: "product_price_after_discount")
  String? productPriceAfterDiscount;
  @JsonKey(name: "discount_rate")
  int? discountRate;
  @JsonKey(name: "discount_name")
  String? discountName;
  @JsonKey(name: "is_discount_date_active")
  bool? isDiscountDateActive;
  @JsonKey(name: "end_at")
  String? endAt;
  @JsonKey(name: "shop_id")
  int? shopId;
  @JsonKey(name: "shop_name")
  String? shopName;
  @JsonKey(name: "shop_mobile_description")
  String? shopMobileDescription;
  @JsonKey(name: "product_mobile_description")
  String? productMobileDescription;
  @JsonKey(name: "max_product_quantity")
  int? productMaxQuantity;
  @JsonKey(name: "product_reviews_count")
  int? productReviewCount;
  @JsonKey(name: "product_review_avg")
  double? productReviewAvg;
  @JsonKey(name: "shop_category_id")
  int? shopCategoryId;
  @JsonKey(name: "shop_category_name")
  String? shopCategoryName;
  @JsonKey(name: "images")
  List<Images>? productImages;
  @JsonKey(name: "product_variations")
  List<ProductVariation>? productVariations;
  ProductEntity(
      {required this.id,
      this.categoryId,
      this.categoryName,
      this.subcategoryId,
      this.subcategoryName,
      required this.productName,
      required this.productMainImage,
      required this.productPrice,
      this.productPriceAfterDiscount,
      this.discountRate,
      this.discountName,
      this.isDiscountDateActive,
      this.endAt,
      this.shopName,
      this.shopId,
      this.productMobileDescription,
      this.productImages,
      this.shopMobileDescription,
      this.productMaxQuantity,
      this.productReviewAvg,
      this.productVariations,
      this.productReviewCount});

  factory ProductEntity.fromJson(Map<String, dynamic> json) =>
      _$ProductEntityFromJson(json);

  Map<String, dynamic> toJson() => _$ProductEntityToJson(this);
}

@JsonSerializable()
class Images {
  int? id;
  @JsonKey(name: "product_id")
  int? productId;
  @JsonKey(name: "image_name")
  String? imageName;

  Images({
    this.id,
    this.productId,
    this.imageName,
  });

  factory Images.fromJson(Map<String, dynamic> json) => _$ImagesFromJson(json);

  Map<String, dynamic> toJson() => _$ImagesToJson(this);
}

@JsonSerializable()
class ProductVariation {
  ProductVariation({
    this.id,
    this.productId,
    this.sizeId,
    this.colorId,
    this.quantity,
    this.productPrice,
    this.productPriceAfterDiscount,
    this.color,
    this.size,
  });
  factory ProductVariation.fromJson(Map<String, dynamic> json) =>
      _$ProductVariationFromJson(json);

  Map<String, dynamic> toJson() => _$ProductVariationToJson(this);
  int? id;
  @JsonKey(name: 'product_id')
  int? productId;
  @JsonKey(name: 'size_id')
  int? sizeId;
  @JsonKey(name: 'color_id')
  int? colorId;
  int? quantity;
  @JsonKey(name: 'product_price')
  String? productPrice;
  @JsonKey(name: 'product_price_after_discount')
  String? productPriceAfterDiscount;
  Color? color;
  Size? size;
}

@JsonSerializable()
class Size {
  Size({
    this.id,
    this.sizeName,
  });
  factory Size.fromJson(Map<String, dynamic> json) => _$SizeFromJson(json);

  Map<String, dynamic> toJson() => _$SizeToJson(this);
  int? id;
  @JsonKey(name: 'size_name')
  String? sizeName;
}

@JsonSerializable()
class Color {
  Color({
    this.id,
    this.colorHexaCode,
    this.colorName,
  });
  factory Color.fromJson(Map<String, dynamic> json) => _$ColorFromJson(json);

  Map<String, dynamic> toJson() => _$ColorToJson(this);
  int? id;
  @JsonKey(name: 'color_hexacode')
  String? colorHexaCode;
  @JsonKey(name: 'color_name')
  String? colorName;
}
