import 'package:freezed_annotation/freezed_annotation.dart';

part 'about_us_entity.g.dart';

@JsonSerializable()
class AboutUsEntity {
  AboutUsEntity({
    this.aboutUs,
  });
  @JsonKey(name: 'about_us')
  AboutUs? aboutUs;
  factory AboutUsEntity.fromJson(Map<String, dynamic> json) =>
      _$AboutUsEntityFromJson(json);

  Map<String, dynamic> toJson() => _$AboutUsEntityToJson(this);
}

@JsonSerializable()
class AboutUs {
  AboutUs({
    this.aboutUsDescription,
    this.aboutUsImage,
  });
  @JsonKey(name: 'about_us_description')
  String? aboutUsDescription;
  @JsonKey(name: 'about_us_image')
  String? aboutUsImage;
  factory AboutUs.fromJson(Map<String, dynamic> json) =>
      _$AboutUsFromJson(json);

  Map<String, dynamic> toJson() => _$AboutUsToJson(this);
}
