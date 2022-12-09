import 'package:freezed_annotation/freezed_annotation.dart';

part 'my_order_details_params.g.dart';

@JsonSerializable()
class MyProductDetailsParams {
  MyProductDetailsParams({
    required this.productId,
  });
  @JsonKey(name: 'product_id')
  final int productId;

  factory MyProductDetailsParams.fromJson(Map<String, dynamic> json) =>
      _$MyProductDetailsParamsFromJson(json);

  Map<String, dynamic> toJson() => _$MyProductDetailsParamsToJson(this);
}
