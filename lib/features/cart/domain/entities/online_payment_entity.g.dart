// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'online_payment_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OnlinePaymentEntity _$OnlinePaymentEntityFromJson(Map<String, dynamic> json) =>
    OnlinePaymentEntity(
      payment: Payment.fromJson(json['payment'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$OnlinePaymentEntityToJson(
        OnlinePaymentEntity instance) =>
    <String, dynamic>{
      'payment': instance.payment,
    };

Payment _$PaymentFromJson(Map<String, dynamic> json) => Payment(
      paymentId: json['payment_id'] as int,
      paymentUrl: json['payment_url'] as String,
    );

Map<String, dynamic> _$PaymentToJson(Payment instance) => <String, dynamic>{
      'payment_id': instance.paymentId,
      'payment_url': instance.paymentUrl,
    };
