import 'package:freezed_annotation/freezed_annotation.dart';

part 'currencies_entity.g.dart';

@JsonSerializable()
class CurrenciesEntity {
  List<Currency> currencies;

  CurrenciesEntity({required this.currencies});
  factory CurrenciesEntity.fromJson(Map<String, dynamic> json) =>
      _$CurrenciesEntityFromJson(json);
  Map<String, dynamic> toJson() => _$CurrenciesEntityToJson(this);
}

@JsonSerializable()
class Currency {
  int id;
  @JsonKey(name: 'currency_rate')
  double currencyRate;
  @JsonKey(name: 'is_default')
  bool isDefault;
  @JsonKey(name: 'currency_name')
  String currencyName;
  @JsonKey(name: 'currency_code')
  String currencyCode;

  Currency(
      {required this.id,
      required this.currencyRate,
      required this.isDefault,
      required this.currencyName,
      required this.currencyCode});
  factory Currency.fromJson(Map<String, dynamic> json) =>
      _$CurrencyFromJson(json);
  Map<String, dynamic> toJson() => _$CurrencyToJson(this);
}
