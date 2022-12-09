import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_review_params.g.dart';

@JsonSerializable()
class UserReviewParams {
  @JsonKey(name: "product_id")
  int productId;

  UserReviewParams({
    required this.productId,
  });
  factory UserReviewParams.fromJson(Map<String, dynamic> json) =>
      _$UserReviewParamsFromJson(json);

  Map<String, dynamic> toJson() => _$UserReviewParamsToJson(this);
}
