import 'package:json_annotation/json_annotation.dart';

part 'update_user_address_body.g.dart';

@JsonSerializable()
class UpdateUserAddressBody {
  @JsonKey(name: 'zone_number')
  String? zoneNumber;
  String? street;
  @JsonKey(name: 'building_number')
  String? buildingNumber;
  UpdateUserAddressBody({
    this.zoneNumber,
    this.street,
    this.buildingNumber,
  });
  factory UpdateUserAddressBody.fromJson(Map<String, dynamic> json) =>
      _$UpdateUserAddressBodyFromJson(json);
  Map<String, dynamic> toJson() => _$UpdateUserAddressBodyToJson(this);
}
