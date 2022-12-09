import 'package:freezed_annotation/freezed_annotation.dart';

part 'online_payment_entity.g.dart';

@JsonSerializable()
class OnlinePaymentEntity {
  final Payment payment;

  OnlinePaymentEntity({required this.payment});

  factory OnlinePaymentEntity.fromJson(Map<String, dynamic> json) =>
      _$OnlinePaymentEntityFromJson(json);

  Map<String, dynamic> toJson() => _$OnlinePaymentEntityToJson(this);
}

@JsonSerializable()
class Payment {
  @JsonKey(name: 'payment_id')
  final int paymentId;
  @JsonKey(name: 'payment_url')
  final String paymentUrl;

  Payment({required this.paymentId, required this.paymentUrl});

  factory Payment.fromJson(Map<String, dynamic> json) =>
      _$PaymentFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentToJson(this);
}
