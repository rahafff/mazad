import 'dart:collection';

import 'package:elite_auction/core/error/network_exceptions.dart';
import 'package:elite_auction/core/models/base_entity.dart';
import 'package:elite_auction/core/utils/SharedPreferences/SharedPreferencesHelper.dart';
import 'package:elite_auction/features/settings/domain/entities/currencies_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/global_states/standard_state.dart';
import '../../../../core/utils/global.dart';
import '../../domain/repositories/settings_repository.dart';

class CurrencyCubit extends Cubit<StandardState<List<Currency>>> {
  final SettingsRepository _settingsRepository;
  HashMap<int, Currency> currencies = HashMap();
  CurrencyCubit(this._settingsRepository)
      : super(const StandardState.loading());
  Future<void> emitGetCurrencies() async {
    emit(const StandardState.loading());
    final response = await _settingsRepository.getCurrencies();
    response.when(
      success: (BaseEntity<CurrenciesEntity> entity) {
        assignCurrenciesHashMap(entity);
        AppSharedPreferences.currencyId= 2;
       // setDefaultCurrency(entity);

        /// storing the currencyCode in shared prefs and in the global currency variable
        appCurrency =
            AppSharedPreferences.currencyCode = currencies[2]!.currencyCode;

        if(!isClosed) {
          emit(
          StandardState.success(
            currencies.values.toList(),
          ),
        );
        }
      },
      failure: (NetworkExceptions failure) {
        emit(
          StandardState.error(failure),
        );
      },
    );
  }

  void assignCurrenciesHashMap(BaseEntity<CurrenciesEntity> entity) {
    for (var element in entity.data!.currencies) {
      currencies[element.id] = element;
    }
  }

  void setDefaultCurrency(BaseEntity<CurrenciesEntity> entity) {
    AppSharedPreferences.currencyId =
        entity.data!.currencies.firstWhere((element) => element.isDefault).id;
  }
}
