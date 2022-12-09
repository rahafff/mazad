// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_review_on_product_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddReviewOnProductBody _$AddReviewOnProductBodyFromJson(
        Map<String, dynamic> json) =>
    AddReviewOnProductBody(
      productId: json['product_id'] as int,
      reviewStarsCount: json['review_stars'] as int,
      reviewComment: json['review_description'] as String?,
    );

Map<String, dynamic> _$AddReviewOnProductBodyToJson(
        AddReviewOnProductBody instance) =>
    <String, dynamic>{
      'product_id': instance.productId,
      'review_stars': instance.reviewStarsCount,
      'review_description': instance.reviewComment,
    };
