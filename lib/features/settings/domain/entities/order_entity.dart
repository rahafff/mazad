import 'package:freezed_annotation/freezed_annotation.dart';

part 'order_entity.g.dart';

@JsonSerializable()
class OrderResponseEntity {
  PaginatedOrderEntity order;

  OrderResponseEntity({required this.order});
  factory OrderResponseEntity.fromJson(Map<String, dynamic> json) =>
      _$OrderResponseEntityFromJson(json);

  Map<String, dynamic> toJson() => _$OrderResponseEntityToJson(this);
}

@JsonSerializable()
class PaginatedOrderEntity {
  int? id;
  @JsonKey(name: "order_code")
  String? orderCode;
  @JsonKey(name: "customer_id")
  int? customerId;
  @JsonKey(name: "customer_name")
  String? customerName;
  @JsonKey(name: "customer_phone_number")
  String? customerPhoneNumber;
  @JsonKey(name: "customer_email")
  String? customerEmail;
  @JsonKey(name: "customer_zone_number")
  String? customerZoneNumber;
  @JsonKey(name: "customer_address_street")
  String? customerAddressStreet;
  @JsonKey(name: "customer_address_building_number")
  String? customerAddressBuildingNumber;
  @JsonKey(name: "customer_address_additional_information")
  String? customerAddressAdditionalInformation;
  @JsonKey(name: "payment_method")
  String? paymentMethod;
  @JsonKey(name: "payment_code")
  String? paymentCode;
  @JsonKey(name: "payment_status")
  String? paymentStatus;
  @JsonKey(name: "order_total")
  String? orderTotal;
  Totals? totals;
  List<Items>? items;
  @JsonKey(name: "order_status")
  String? orderStatus;
  @JsonKey(name: "created_at")
  String? createdAt;
  @JsonKey(name: "updated_at")
  String? updatedAt;

  PaginatedOrderEntity({
    this.id,
    this.orderCode,
    this.customerId,
    this.customerName,
    this.customerPhoneNumber,
    this.customerEmail,
    this.customerZoneNumber,
    this.customerAddressStreet,
    this.customerAddressBuildingNumber,
    this.customerAddressAdditionalInformation,
    this.paymentMethod,
    this.paymentCode,
    this.paymentStatus,
    this.orderTotal,
    this.totals,
    this.items,
    this.orderStatus,
    this.createdAt,
    this.updatedAt,
  });

  factory PaginatedOrderEntity.fromJson(Map<String, dynamic> json) =>
      _$PaginatedOrderEntityFromJson(json);

  Map<String, dynamic> toJson() => _$PaginatedOrderEntityToJson(this);
}

@JsonSerializable()
class Totals {
  @JsonKey(name: "sub_total")
  String? subTotal;
  @JsonKey(name: "delivery_fees")
  String? deliveryFees;
  @JsonKey(name: "overall_total")
  String? overallTotal;

  factory Totals.fromJson(Map<String, dynamic> json) => _$TotalsFromJson(json);

  Map<String, dynamic> toJson() => _$TotalsToJson(this);

  Totals(
      {required this.subTotal,
      required this.deliveryFees,
      required this.overallTotal});
}

@JsonSerializable()
class Items {
  int? id;
  @JsonKey(name: "product_name")
  String? productName;
  @JsonKey(name: "product_main_image")
  String? productMainImage;
  @JsonKey(name: "product_price")
  String? productPrice;
  @JsonKey(name: "product_price_after_discount")
  String? productPriceAfterDiscount;
  @JsonKey(name: "discount_rate")
  int? discountRate;
  @JsonKey(name: "shop_id")
  int? shopId;
  @JsonKey(name: "product_mobile_description")
  String? productMobileDescription;
  @JsonKey(name: "product_quantity")
  int? productQuantity;
  factory Items.fromJson(Map<String, dynamic> json) => _$ItemsFromJson(json);

  Map<String, dynamic> toJson() => _$ItemsToJson(this);
  Items(
      {required this.id,
      this.shopId,
      this.discountRate,
      required this.productPrice,
      required this.productQuantity,
      required this.productMainImage,
      this.productPriceAfterDiscount,
      required this.productName,
      this.productMobileDescription});
}
