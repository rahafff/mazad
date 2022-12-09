import 'package:freezed_annotation/freezed_annotation.dart';

part 'paginated_product_entity.g.dart';

@JsonSerializable()
class PaginatedProductEntity {
  int id;
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
  @JsonKey(name: "shop_id")
  int? shopId;
  @JsonKey(name: "product_reviews_count")
  int? productReviewCount;
  @JsonKey(name: "product_review_avg")
  double? productReviewAvg;
  PaginatedProductEntity(
      {required this.id,
      required this.productName,
      required this.productMainImage,
      required this.productPrice,
      this.productPriceAfterDiscount,
      this.discountRate,
      this.shopId,
      this.productReviewAvg,
      this.productReviewCount});

  factory PaginatedProductEntity.fromJson(Map<String, dynamic> json) =>
      _$PaginatedProductEntityFromJson(json);

  Map<String, dynamic> toJson() => _$PaginatedProductEntityToJson(this);
}
