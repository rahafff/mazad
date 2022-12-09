// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pay_on_delivery_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PayOnDeliveryBody _$PayOnDeliveryBodyFromJson(Map<String, dynamic> json) =>
    PayOnDeliveryBody(
      zoneNumber: json['zone_number'] as int?,
      street: json['street'] as String?,
      buildingNumber: json['building_number'] as String?,
    );

Map<String, dynamic> _$PayOnDeliveryBodyToJson(PayOnDeliveryBody instance) =>
    <String, dynamic>{
      'zone_number': instance.zoneNumber,
      'street': instance.street,
      'building_number': instance.buildingNumber,
    };
