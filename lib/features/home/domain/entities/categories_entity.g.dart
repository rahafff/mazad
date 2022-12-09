// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'categories_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoriesEntity _$CategoriesEntityFromJson(Map<String, dynamic> json) =>
    CategoriesEntity(
      categories: (json['categories'] as List<dynamic>)
          .map((e) => Category.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CategoriesEntityToJson(CategoriesEntity instance) =>
    <String, dynamic>{
      'categories': instance.categories,
    };

Category _$CategoryFromJson(Map<String, dynamic> json) => Category(
      id: json['id'] as int?,
      categoryImage: json['category_image'] as String?,
      categoryName: json['category_name'] as String?,
    );

Map<String, dynamic> _$CategoryToJson(Category instance) => <String, dynamic>{
      'id': instance.id,
      'category_image': instance.categoryImage,
      'category_name': instance.categoryName,
    };
