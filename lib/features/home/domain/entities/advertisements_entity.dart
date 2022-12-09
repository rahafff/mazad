import 'package:freezed_annotation/freezed_annotation.dart';

part 'advertisements_entity.g.dart';

@JsonSerializable()
class AdvertisementsEntity {
  AdvertisementsEntity({required this.sliders});

  List<Sliders> sliders;

  factory AdvertisementsEntity.fromJson(Map<String, dynamic> json) =>
      _$AdvertisementsEntityFromJson(json);

  Map<String, dynamic> toJson() => _$AdvertisementsEntityToJson(this);
}

@JsonSerializable()
class Sliders {
  @JsonKey(name: "slider_id")
  int? sliderId;
  @JsonKey(name: "slider_image")
  String? sliderMobileImage;
  @JsonKey(name: "slider_title")
  String? sliderTitle;
  @JsonKey(name: "slider_description")
  String? sliderDescription;
  @JsonKey(name: "slider_button_description")
  String? sliderButtonDescription;
  @JsonKey(name: "slider_link")
  String? sliderLink;

  factory Sliders.fromJson(Map<String, dynamic> json) =>
      _$SlidersFromJson(json);

  Map<String, dynamic> toJson() => _$SlidersToJson(this);

  Sliders({
    this.sliderId,
    this.sliderMobileImage,
    this.sliderTitle,
    this.sliderDescription,
    this.sliderButtonDescription,
    this.sliderLink,
  });
}
