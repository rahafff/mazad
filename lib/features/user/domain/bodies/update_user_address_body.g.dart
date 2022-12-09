// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_user_address_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateUserAddressBody _$UpdateUserAddressBodyFromJson(
        Map<String, dynamic> json) =>
    UpdateUserAddressBody(
      zoneNumber: json['zone_number'] as String?,
      street: json['street'] as String?,
      buildingNumber: json['building_number'] as String?,
    );

Map<String, dynamic> _$UpdateUserAddressBodyToJson(
        UpdateUserAddressBody instance) =>
    <String, dynamic>{
      'zone_number': instance.zoneNumber,
      'street': instance.street,
      'building_number': instance.buildingNumber,
    };
