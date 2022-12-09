import 'package:freezed_annotation/freezed_annotation.dart';

part 'order_details_params.g.dart';

@JsonSerializable()
class OrderDetailsParams {
  OrderDetailsParams({
    required this.orderId,
  });
  @JsonKey(name: 'order_id')
  final int orderId;

  factory OrderDetailsParams.fromJson(Map<String, dynamic> json) =>
      _$OrderDetailsParamsFromJson(json);

  Map<String, dynamic> toJson() => _$OrderDetailsParamsToJson(this);
}
