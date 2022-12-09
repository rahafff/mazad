import 'package:freezed_annotation/freezed_annotation.dart';

part 'subsubcategories_entity.g.dart';

@JsonSerializable()
class SubsubcategoriesEntity {
  SubsubcategoriesEntity({
    this.subsubcategories,
  });
  Subsubcategories? subsubcategories;
  factory SubsubcategoriesEntity.fromJson(Map<String, dynamic> json) =>
      _$SubsubcategoriesEntityFromJson(json);

  Map<String, dynamic> toJson() => _$SubsubcategoriesEntityToJson(this);
}

@JsonSerializable()
class Subsubcategories {
  Subsubcategories({
    this.id,
    this.subcategoryImage,
    this.subcategoryName,
    required this.subsubcategories,
  });
  factory Subsubcategories.fromJson(Map<String, dynamic> json) =>
      _$SubsubcategoriesFromJson(json);

  Map<String, dynamic> toJson() => _$SubsubcategoriesToJson(this);
  num? id;
  @JsonKey(name: "subcategory_image")
  String? subcategoryImage;
  @JsonKey(name: "subcategory_name")
  String? subcategoryName;
  List<Subsubcategory?> subsubcategories;
}

@JsonSerializable()
class Subsubcategory {
  Subsubcategory({
    this.id,
    this.subsubcategoryImage,
    this.subsubcategoryName,
  });
  factory Subsubcategory.fromJson(Map<String, dynamic> json) =>
      _$SubsubcategoryFromJson(json);

  Map<String, dynamic> toJson() => _$SubsubcategoryToJson(this);

  num? id;
  @JsonKey(name: "subsubcategory_image")
  String? subsubcategoryImage;
  @JsonKey(name: "subsubcategory_name")
  String? subsubcategoryName;
}
