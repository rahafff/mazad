import 'package:json_annotation/json_annotation.dart';

part 'pay_on_visa_body.g.dart';

@JsonSerializable()
class PayOnVisaBody {
  @JsonKey(name: 'payment_id')
  int? paymentId;
  @JsonKey(name: 'payment_url')
  String? paymentUrl;
  PayOnVisaBody({
    this.paymentId,
    this.paymentUrl,
  });
  factory PayOnVisaBody.fromJson(Map<String, dynamic> json) =>
      _$PayOnVisaBodyFromJson(json);
  Map<String, dynamic> toJson() => _$PayOnVisaBodyToJson(this);
}
