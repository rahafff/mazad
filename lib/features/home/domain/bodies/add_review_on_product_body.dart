import 'package:freezed_annotation/freezed_annotation.dart';

part 'add_review_on_product_body.g.dart';

@JsonSerializable()
class AddReviewOnProductBody {
  @JsonKey(name: 'product_id')
  final int productId;
  @JsonKey(name: 'review_stars')
  final int reviewStarsCount;
  @JsonKey(name: 'review_description')
  final String? reviewComment;

  AddReviewOnProductBody({
    required this.productId,
    required this.reviewStarsCount,
    this.reviewComment,
  });
  factory AddReviewOnProductBody.fromJson(Map<String, dynamic> json) =>
      _$AddReviewOnProductBodyFromJson(json);

  Map<String, dynamic> toJson() => _$AddReviewOnProductBodyToJson(this);
}
