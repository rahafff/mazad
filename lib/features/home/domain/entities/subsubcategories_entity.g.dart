// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subsubcategories_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubsubcategoriesEntity _$SubsubcategoriesEntityFromJson(
        Map<String, dynamic> json) =>
    SubsubcategoriesEntity(
      subsubcategories: json['subsubcategories'] == null
          ? null
          : Subsubcategories.fromJson(
              json['subsubcategories'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SubsubcategoriesEntityToJson(
        SubsubcategoriesEntity instance) =>
    <String, dynamic>{
      'subsubcategories': instance.subsubcategories,
    };

Subsubcategories _$SubsubcategoriesFromJson(Map<String, dynamic> json) =>
    Subsubcategories(
      id: json['id'] as num?,
      subcategoryImage: json['subcategory_image'] as String?,
      subcategoryName: json['subcategory_name'] as String?,
      subsubcategories: (json['subsubcategories'] as List<dynamic>)
          .map((e) => e == null
              ? null
              : Subsubcategory.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SubsubcategoriesToJson(Subsubcategories instance) =>
    <String, dynamic>{
      'id': instance.id,
      'subcategory_image': instance.subcategoryImage,
      'subcategory_name': instance.subcategoryName,
      'subsubcategories': instance.subsubcategories,
    };

Subsubcategory _$SubsubcategoryFromJson(Map<String, dynamic> json) =>
    Subsubcategory(
      id: json['id'] as num?,
      subsubcategoryImage: json['subsubcategory_image'] as String?,
      subsubcategoryName: json['subsubcategory_name'] as String?,
    );

Map<String, dynamic> _$SubsubcategoryToJson(Subsubcategory instance) =>
    <String, dynamic>{
      'id': instance.id,
      'subsubcategory_image': instance.subsubcategoryImage,
      'subsubcategory_name': instance.subsubcategoryName,
    };
