// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'advertisements_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AdvertisementsEntity _$AdvertisementsEntityFromJson(
        Map<String, dynamic> json) =>
    AdvertisementsEntity(
      sliders: (json['sliders'] as List<dynamic>)
          .map((e) => Sliders.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AdvertisementsEntityToJson(
        AdvertisementsEntity instance) =>
    <String, dynamic>{
      'sliders': instance.sliders,
    };

Sliders _$SlidersFromJson(Map<String, dynamic> json) => Sliders(
      sliderId: json['slider_id'] as int?,
      sliderMobileImage: json['slider_image'] as String?,
      sliderTitle: json['slider_title'] as String?,
      sliderDescription: json['slider_description'] as String?,
      sliderButtonDescription: json['slider_button_description'] as String?,
      sliderLink: json['slider_link'] as String?,
    );

Map<String, dynamic> _$SlidersToJson(Sliders instance) => <String, dynamic>{
      'slider_id': instance.sliderId,
      'slider_image': instance.sliderMobileImage,
      'slider_title': instance.sliderTitle,
      'slider_description': instance.sliderDescription,
      'slider_button_description': instance.sliderButtonDescription,
      'slider_link': instance.sliderLink,
    };
