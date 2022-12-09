// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'about_us_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AboutUsEntity _$AboutUsEntityFromJson(Map<String, dynamic> json) =>
    AboutUsEntity(
      aboutUs: json['about_us'] == null
          ? null
          : AboutUs.fromJson(json['about_us'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AboutUsEntityToJson(AboutUsEntity instance) =>
    <String, dynamic>{
      'about_us': instance.aboutUs,
    };

AboutUs _$AboutUsFromJson(Map<String, dynamic> json) => AboutUs(
      aboutUsDescription: json['about_us_description'] as String?,
      aboutUsImage: json['about_us_image'] as String?,
    );

Map<String, dynamic> _$AboutUsToJson(AboutUs instance) => <String, dynamic>{
      'about_us_description': instance.aboutUsDescription,
      'about_us_image': instance.aboutUsImage,
    };
