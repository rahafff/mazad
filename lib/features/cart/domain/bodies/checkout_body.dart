import 'package:freezed_annotation/freezed_annotation.dart';

part 'checkout_body.g.dart';

@JsonSerializable()
class CheckOutBody {
  @JsonKey(name: 'payment_id')
  final int? paymentId;
  @JsonKey(name: 'zone_number')
  final String zoneNumber;
  @JsonKey(name: 'street')
  final String street;
  @JsonKey(name: 'building_number')
  final String buildingNumber;
  @JsonKey(name: 'appartement')
  final String? appartement;
  @JsonKey(name: 'customer_address_name')
  final String locationName;
  @JsonKey(name: 'floor_number')
  final String? floorNumber;
  @JsonKey(name: 'payment_method')
  final String paymentMethod;

  @JsonKey(name: 'lat')
  final String latitude;
  @JsonKey(name: 'long')
  final String longitude;

  CheckOutBody(
      {this.paymentId,
      required this.appartement,
      required this.locationName,
      required this.floorNumber,
      required this.zoneNumber,
      required this.street,
      required this.buildingNumber,
      required this.paymentMethod ,
      required this.latitude,
      required this.longitude});

  factory CheckOutBody.fromJson(Map<String, dynamic> json) =>
      _$CheckOutBodyFromJson(json);

  Map<String, dynamic> toJson() => _$CheckOutBodyToJson(this);
}
