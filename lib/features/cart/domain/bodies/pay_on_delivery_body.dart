import 'package:json_annotation/json_annotation.dart';

part 'pay_on_delivery_body.g.dart';

@JsonSerializable()
class PayOnDeliveryBody {
  @JsonKey(name: 'zone_number')
  int? zoneNumber;
  String? street;
  @JsonKey(name: 'building_number')
  String? buildingNumber;
  PayOnDeliveryBody({
    this.zoneNumber,
    this.street,
    this.buildingNumber,
  });
  factory PayOnDeliveryBody.fromJson(Map<String, dynamic> json) =>
      _$PayOnDeliveryBodyFromJson(json);
  Map<String, dynamic> toJson() => _$PayOnDeliveryBodyToJson(this);
}
