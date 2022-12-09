// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'currencies_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CurrenciesEntity _$CurrenciesEntityFromJson(Map<String, dynamic> json) =>
    CurrenciesEntity(
      currencies: (json['currencies'] as List<dynamic>)
          .map((e) => Currency.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CurrenciesEntityToJson(CurrenciesEntity instance) =>
    <String, dynamic>{
      'currencies': instance.currencies,
    };

Currency _$CurrencyFromJson(Map<String, dynamic> json) => Currency(
      id: json['id'] as int,
      currencyRate: (json['currency_rate'] as num).toDouble(),
      isDefault: json['is_default'] as bool,
      currencyName: json['currency_name'] as String,
      currencyCode: json['currency_code'] as String,
    );

Map<String, dynamic> _$CurrencyToJson(Currency instance) => <String, dynamic>{
      'id': instance.id,
      'currency_rate': instance.currencyRate,
      'is_default': instance.isDefault,
      'currency_name': instance.currencyName,
      'currency_code': instance.currencyCode,
    };
