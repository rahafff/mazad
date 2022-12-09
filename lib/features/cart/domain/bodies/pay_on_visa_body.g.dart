// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pay_on_visa_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PayOnVisaBody _$PayOnVisaBodyFromJson(Map<String, dynamic> json) =>
    PayOnVisaBody(
      paymentId: json['payment_id'] as int?,
      paymentUrl: json['payment_url'] as String?,
    );

Map<String, dynamic> _$PayOnVisaBodyToJson(PayOnVisaBody instance) =>
    <String, dynamic>{
      'payment_id': instance.paymentId,
      'payment_url': instance.paymentUrl,
    };
