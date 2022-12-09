// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginBody _$LoginBodyFromJson(Map<String, dynamic> json) => LoginBody(
      password: json['password'] as String?,
      phoneNumber: json['phone'] as String?,
      fcmToken: json['fcm_token'] as String?,
    );

Map<String, dynamic> _$LoginBodyToJson(LoginBody instance) => <String, dynamic>{
      'phone': instance.phoneNumber,
      'password': instance.password,
      'fcm_token': instance.fcmToken,
    };
