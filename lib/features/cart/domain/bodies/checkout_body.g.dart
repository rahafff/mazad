// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'checkout_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckOutBody _$CheckOutBodyFromJson(Map<String, dynamic> json) => CheckOutBody(
      paymentId: json['payment_id'] as int?,
      appartement: json['appartement'] as String?,
      locationName: json['customer_address_name'] as String,
      floorNumber: json['floor_number'] as String?,
      zoneNumber: json['zone_number'] as String,
      street: json['street'] as String,
      buildingNumber: json['building_number'] as String,
      paymentMethod: json['payment_method'] as String,
      latitude: json['lat'] as String,
      longitude: json['long'] as String,
    );

Map<String, dynamic> _$CheckOutBodyToJson(CheckOutBody instance) =>
    <String, dynamic>{
      'payment_id': instance.paymentId,
      'zone_number': instance.zoneNumber,
      'street': instance.street,
      'building_number': instance.buildingNumber,
      'appartement': instance.appartement,
      'customer_address_name': instance.locationName,
      'floor_number': instance.floorNumber,
      'payment_method': instance.paymentMethod,
      'lat': instance.latitude,
      'long': instance.longitude,
    };
