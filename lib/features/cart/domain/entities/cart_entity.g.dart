// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartEntity _$CartEntityFromJson(Map<String, dynamic> json) => CartEntity(
      cart: Cart.fromJson(json['cart'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CartEntityToJson(CartEntity instance) =>
    <String, dynamic>{
      'cart': instance.cart,
    };

Cart _$CartFromJson(Map<String, dynamic> json) => Cart(
      id: json['id'] as int?,
      subTotal: json['sub_total'] as String?,
      deliveryFees: json['delivery_fees'] as String?,
      overallTotal: json['overall_total'] as String?,
      cartItemsCount: json['cart_items_count'] as int?,
      cartItems: (json['cart_items'] as List<dynamic>?)
          ?.map((e) => CartItems.fromJson(e as Map<String, dynamic>))
          .toList(),
      shopId: json['shop_id'] as int?,
    );

Map<String, dynamic> _$CartToJson(Cart instance) => <String, dynamic>{
      'id': instance.id,
      'sub_total': instance.subTotal,
      'delivery_fees': instance.deliveryFees,
      'overall_total': instance.overallTotal,
      'cart_items_count': instance.cartItemsCount,
      'cart_items': instance.cartItems,
      'shop_id': instance.shopId,
    };

CartItems _$CartItemsFromJson(Map<String, dynamic> json) => CartItems(
      id: json['id'] as int,
      productName: json['product_name'] as String,
      productMobileDescription: json['product_mobile_description'] as String?,
      maxProductQuantity: json['max_product_quantity'] as int,
      productPrice: json['product_price'] as String,
      productMainImage: json['product_main_image'] as String,
      productReviewAvg: json['product_review_avg'] as num,
      productReviewsCount: json['product_reviews_count'] as int,
      productQuantity: json['product_quantity'] as int,
      productPriceAfterDiscount:
          json['product_price_after_discount'] as String?,
      discountRate: json['discount_rate'] as int?,
      discountName: json['discount_name'] as String?,
    )..productVariation = json['product_variation'] == null
        ? null
        : ProductVariation.fromJson(
            json['product_variation'] as Map<String, dynamic>);

Map<String, dynamic> _$CartItemsToJson(CartItems instance) => <String, dynamic>{
      'id': instance.id,
      'product_name': instance.productName,
      'product_mobile_description': instance.productMobileDescription,
      'max_product_quantity': instance.maxProductQuantity,
      'product_price': instance.productPrice,
      'product_main_image': instance.productMainImage,
      'product_review_avg': instance.productReviewAvg,
      'product_reviews_count': instance.productReviewsCount,
      'product_quantity': instance.productQuantity,
      'product_price_after_discount': instance.productPriceAfterDiscount,
      'discount_rate': instance.discountRate,
      'discount_name': instance.discountName,
      'product_variation': instance.productVariation,
    };

ProductVariation _$ProductVariationFromJson(Map<String, dynamic> json) =>
    ProductVariation(
      id: json['id'] as int?,
      productId: json['product_id'] as int?,
      sizeId: json['size_id'] as int?,
      colorId: json['color_id'] as int?,
      quantity: json['quantity'] as int?,
      price: json['price'] as String?,
      color: json['color'] == null
          ? null
          : Color.fromJson(json['color'] as Map<String, dynamic>),
      size: json['size'] == null
          ? null
          : Size.fromJson(json['size'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ProductVariationToJson(ProductVariation instance) =>
    <String, dynamic>{
      'id': instance.id,
      'product_id': instance.productId,
      'size_id': instance.sizeId,
      'color_id': instance.colorId,
      'quantity': instance.quantity,
      'price': instance.price,
      'color': instance.color,
      'size': instance.size,
    };

Size _$SizeFromJson(Map<String, dynamic> json) => Size(
      id: json['id'] as int?,
      sizeName: json['size_name'] as String?,
    );

Map<String, dynamic> _$SizeToJson(Size instance) => <String, dynamic>{
      'id': instance.id,
      'size_name': instance.sizeName,
    };

Color _$ColorFromJson(Map<String, dynamic> json) => Color(
      id: json['id'] as int?,
      colorHexaCode: json['color_hexacode'] as String?,
      colorName: json['color_name'] as String?,
    );

Map<String, dynamic> _$ColorToJson(Color instance) => <String, dynamic>{
      'id': instance.id,
      'color_hexacode': instance.colorHexaCode,
      'color_name': instance.colorName,
    };
