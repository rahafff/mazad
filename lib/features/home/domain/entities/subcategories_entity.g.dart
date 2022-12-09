// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subcategories_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubCategoriesEntity _$SubCategoriesEntityFromJson(Map<String, dynamic> json) =>
    SubCategoriesEntity(
      subcategories:
          Subcategories.fromJson(json['subcategories'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SubCategoriesEntityToJson(
        SubCategoriesEntity instance) =>
    <String, dynamic>{
      'subcategories': instance.subcategories,
    };

Subcategories _$SubcategoriesFromJson(Map<String, dynamic> json) =>
    Subcategories(
      id: json['id'] as int,
      categoryImage: json['category_image'] as String,
      categoryName: json['category_name'] as String,
      subcategories: (json['subcategories'] as List<dynamic>)
          .map((e) => Subcategory.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SubcategoriesToJson(Subcategories instance) =>
    <String, dynamic>{
      'id': instance.id,
      'category_image': instance.categoryImage,
      'category_name': instance.categoryName,
      'subcategories': instance.subcategories,
    };

Subcategory _$SubcategoryFromJson(Map<String, dynamic> json) => Subcategory(
      id: json['id'] as int,
      subcategoryImage: json['subcategory_image'] as String,
      subcategoryName: json['subcategory_name'] as String,
    );

Map<String, dynamic> _$SubcategoryToJson(Subcategory instance) =>
    <String, dynamic>{
      'id': instance.id,
      'subcategory_image': instance.subcategoryImage,
      'subcategory_name': instance.subcategoryName,
    };
