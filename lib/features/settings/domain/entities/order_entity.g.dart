// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderResponseEntity _$OrderResponseEntityFromJson(Map<String, dynamic> json) =>
    OrderResponseEntity(
      order:
          PaginatedOrderEntity.fromJson(json['order'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$OrderResponseEntityToJson(
        OrderResponseEntity instance) =>
    <String, dynamic>{
      'order': instance.order,
    };

PaginatedOrderEntity _$PaginatedOrderEntityFromJson(
        Map<String, dynamic> json) =>
    PaginatedOrderEntity(
      id: json['id'] as int?,
      orderCode: json['order_code'] as String?,
      customerId: json['customer_id'] as int?,
      customerName: json['customer_name'] as String?,
      customerPhoneNumber: json['customer_phone_number'] as String?,
      customerEmail: json['customer_email'] as String?,
      customerZoneNumber: json['customer_zone_number'] as String?,
      customerAddressStreet: json['customer_address_street'] as String?,
      customerAddressBuildingNumber:
          json['customer_address_building_number'] as String?,
      customerAddressAdditionalInformation:
          json['customer_address_additional_information'] as String?,
      paymentMethod: json['payment_method'] as String?,
      paymentCode: json['payment_code'] as String?,
      paymentStatus: json['payment_status'] as String?,
      orderTotal: json['order_total'] as String?,
      totals: json['totals'] == null
          ? null
          : Totals.fromJson(json['totals'] as Map<String, dynamic>),
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => Items.fromJson(e as Map<String, dynamic>))
          .toList(),
      orderStatus: json['order_status'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );

Map<String, dynamic> _$PaginatedOrderEntityToJson(
        PaginatedOrderEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'order_code': instance.orderCode,
      'customer_id': instance.customerId,
      'customer_name': instance.customerName,
      'customer_phone_number': instance.customerPhoneNumber,
      'customer_email': instance.customerEmail,
      'customer_zone_number': instance.customerZoneNumber,
      'customer_address_street': instance.customerAddressStreet,
      'customer_address_building_number':
          instance.customerAddressBuildingNumber,
      'customer_address_additional_information':
          instance.customerAddressAdditionalInformation,
      'payment_method': instance.paymentMethod,
      'payment_code': instance.paymentCode,
      'payment_status': instance.paymentStatus,
      'order_total': instance.orderTotal,
      'totals': instance.totals,
      'items': instance.items,
      'order_status': instance.orderStatus,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };

Totals _$TotalsFromJson(Map<String, dynamic> json) => Totals(
      subTotal: json['sub_total'] as String?,
      deliveryFees: json['delivery_fees'] as String?,
      overallTotal: json['overall_total'] as String?,
    );

Map<String, dynamic> _$TotalsToJson(Totals instance) => <String, dynamic>{
      'sub_total': instance.subTotal,
      'delivery_fees': instance.deliveryFees,
      'overall_total': instance.overallTotal,
    };

Items _$ItemsFromJson(Map<String, dynamic> json) => Items(
      id: json['id'] as int?,
      shopId: json['shop_id'] as int?,
      discountRate: json['discount_rate'] as int?,
      productPrice: json['product_price'] as String?,
      productQuantity: json['product_quantity'] as int?,
      productMainImage: json['product_main_image'] as String?,
      productPriceAfterDiscount:
          json['product_price_after_discount'] as String?,
      productName: json['product_name'] as String?,
      productMobileDescription: json['product_mobile_description'] as String?,
    );

Map<String, dynamic> _$ItemsToJson(Items instance) => <String, dynamic>{
      'id': instance.id,
      'product_name': instance.productName,
      'product_main_image': instance.productMainImage,
      'product_price': instance.productPrice,
      'product_price_after_discount': instance.productPriceAfterDiscount,
      'discount_rate': instance.discountRate,
      'shop_id': instance.shopId,
      'product_mobile_description': instance.productMobileDescription,
      'product_quantity': instance.productQuantity,
    };
