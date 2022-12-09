import 'package:freezed_annotation/freezed_annotation.dart';

part 'subcategories_params.g.dart';

@JsonSerializable()
class SubCategoriesParams {
  @JsonKey(name: "category_id")
  int categoryId;

  SubCategoriesParams({required this.categoryId});
  factory SubCategoriesParams.fromJson(Map<String, dynamic> json) =>
      _$SubCategoriesParamsFromJson(json);

  Map<String, dynamic> toJson() => _$SubCategoriesParamsToJson(this);
}
