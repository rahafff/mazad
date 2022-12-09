import 'package:freezed_annotation/freezed_annotation.dart';

part 'cart_entity.g.dart';

@JsonSerializable()
class CartEntity {
  CartEntity({
    required this.cart,
  });
  Cart cart;
  factory CartEntity.fromJson(Map<String, dynamic> json) =>
      _$CartEntityFromJson(json);

  Map<String, dynamic> toJson() => _$CartEntityToJson(this);
}

@JsonSerializable()
class Cart {

  Cart({
    this.id,
    this.subTotal,
    this.deliveryFees,
    this.overallTotal,
    this.cartItemsCount,
    this.cartItems,
    this.shopId,
  });
  factory Cart.fromJson(Map<String, dynamic> json) => _$CartFromJson(json);

  Map<String, dynamic> toJson() => _$CartToJson(this);
  int? id;
  @JsonKey(name: 'sub_total')
  String? subTotal;
  @JsonKey(name: 'delivery_fees')
  String? deliveryFees;
  @JsonKey(name: 'overall_total')
  String? overallTotal;
  @JsonKey(name: 'cart_items_count')
  int? cartItemsCount;
  @JsonKey(name: 'cart_items')
  List<CartItems>? cartItems;
  @JsonKey(name: 'shop_id')
  int? shopId;
}

@JsonSerializable()
class CartItems {
  CartItems({
    required this.id,
    required this.productName,
    this.productMobileDescription,
    required this.maxProductQuantity,
    required this.productPrice,
    required this.productMainImage,
    required this.productReviewAvg,
    required this.productReviewsCount,
    required this.productQuantity,
    this.productPriceAfterDiscount,
    this.discountRate,
    this.discountName,
  });
  factory CartItems.fromJson(Map<String, dynamic> json) =>
      _$CartItemsFromJson(json);

  Map<String, dynamic> toJson() => _$CartItemsToJson(this);
  int id;
  @JsonKey(name: 'product_name')
  String productName;
  @JsonKey(name: 'product_mobile_description')
  String? productMobileDescription;
  @JsonKey(name: 'max_product_quantity')
  int maxProductQuantity;
  @JsonKey(name: 'product_price')
  String productPrice;
  @JsonKey(name: 'product_main_image')
  String productMainImage;
  @JsonKey(name: 'product_review_avg')
  num productReviewAvg;
  @JsonKey(name: 'product_reviews_count')
  int productReviewsCount;

  @JsonKey(name: 'product_quantity')
  int productQuantity;
  @JsonKey(name: 'product_price_after_discount')
  String? productPriceAfterDiscount;
  @JsonKey(name: 'discount_rate')
  int? discountRate;
  @JsonKey(name: 'discount_name')
  String? discountName;
  @JsonKey(name: 'product_variation')
  ProductVariation? productVariation;
}

@JsonSerializable()
class ProductVariation {
  ProductVariation({
    this.id,
    this.productId,
    this.sizeId,
    this.colorId,
    this.quantity,
    this.price,
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
  String? price;
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
