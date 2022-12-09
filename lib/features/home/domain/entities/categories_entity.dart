import 'package:freezed_annotation/freezed_annotation.dart';

part 'categories_entity.g.dart';

@JsonSerializable()
class CategoriesEntity {
  CategoriesEntity({
    required this.categories,
  });

  List<Category> categories;

  factory CategoriesEntity.fromJson(Map<String, dynamic> json) =>
      _$CategoriesEntityFromJson(json);

  Map<String, dynamic> toJson() => _$CategoriesEntityToJson(this);
}

@JsonSerializable()
class Category {
  Category({
    this.id,
    this.categoryImage,
    this.categoryName,
  });

  int? id;
  @JsonKey(name: 'category_image')
  String? categoryImage;
  @JsonKey(name: 'category_name')
  String? categoryName;

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryToJson(this);
}
