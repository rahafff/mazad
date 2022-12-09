import 'package:json_annotation/json_annotation.dart';

part 'products_with_pagination_params.g.dart';

@JsonSerializable()
class ProductsWithPaginationParams {
  int? page;
  String? search;
  @JsonKey(name: "per_page")
  dynamic perPage;
  @JsonKey(name: "shop_id")
  int? shopId;
  @JsonKey(name: "shop_category_id")
  int? shopCategoryId;
  @JsonKey(name: "product_id")
  int? productId;
  @JsonKey(name: "category_id")
  int? categoryId;
  @JsonKey(name: "subcategory_id")
  int? subcategoryId;@JsonKey(name: "subsubcategory_id")
  int? subsubcategoryId;
  ProductsWithPaginationParams(
      {required this.page,
      this.perPage = 8,
      this.shopId,
      this.search,
      this.categoryId,
      this.subcategoryId,
      this.productId,
      this.shopCategoryId,this.subsubcategoryId});
  factory ProductsWithPaginationParams.fromJson(Map<String, dynamic> json) =>
      _$ProductsWithPaginationParamsFromJson(json);
  Map<String, dynamic> toJson() => _$ProductsWithPaginationParamsToJson(this);
}
