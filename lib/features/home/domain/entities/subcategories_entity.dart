import 'package:freezed_annotation/freezed_annotation.dart';

part 'subcategories_entity.g.dart';

@JsonSerializable()
class SubCategoriesEntity {
  Subcategories subcategories;

  SubCategoriesEntity({required this.subcategories});
  factory SubCategoriesEntity.fromJson(Map<String, dynamic> json) =>
      _$SubCategoriesEntityFromJson(json);

  Map<String, dynamic> toJson() => _$SubCategoriesEntityToJson(this);
}

@JsonSerializable()
class Subcategories {
  int id;
  @JsonKey(name: "category_image")
  String categoryImage;
  @JsonKey(name: "category_name")
  String categoryName;
  List<Subcategory> subcategories;

  Subcategories({
    required this.id,
    required this.categoryImage,
    required this.categoryName,
    required this.subcategories,
  });
  factory Subcategories.fromJson(Map<String, dynamic> json) =>
      _$SubcategoriesFromJson(json);

  Map<String, dynamic> toJson() => _$SubcategoriesToJson(this);
}

@JsonSerializable()
class Subcategory {
  int id;
  @JsonKey(name: "subcategory_image")
  String subcategoryImage;
  @JsonKey(name: "subcategory_name")
  String subcategoryName;

  Subcategory(
      {required this.id,
      required this.subcategoryImage,
      required this.subcategoryName});
  factory Subcategory.fromJson(Map<String, dynamic> json) =>
      _$SubcategoryFromJson(json);

  Map<String, dynamic> toJson() => _$SubcategoryToJson(this);
}
