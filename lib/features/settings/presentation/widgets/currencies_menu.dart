import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/global_states/standard_state.dart';
import '../../../../core/resources/color_manager.dart';
import '../../../../core/resources/strings_manager.dart';
import '../../../../core/utils/SharedPreferences/SharedPreferencesHelper.dart';
import '../../../../core/utils/global.dart';
import '../../domain/entities/currencies_entity.dart';
import '../manager/currency_cubit.dart';

class CurrenciesMenu extends StatefulWidget {
  const CurrenciesMenu({Key? key}) : super(key: key);

  @override
  State<CurrenciesMenu> createState() => _CurrenciesMenuState();
}

class _CurrenciesMenuState extends State<CurrenciesMenu> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrencyCubit, StandardState<List<Currency>>>(
      builder: (context, state) {
        return state.maybeWhen(
          orElse: () => const SizedBox.shrink(),
          loading: () => const SizedBox.shrink(),
          success: (currencies) => Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.5.w),
            child: DropdownButtonHideUnderline(
                child: DropdownButton(
                    itemHeight: 8.h,
                    icon: Icon(
                      FontAwesomeIcons.r,
                      color: ColorManager.kMove,
                      size: 6.0.w,
                    ),
                    items: _mapCurrenciesToList(currencies),
                    style: Theme.of(context).textTheme.bodyText1,
                    hint: Text(
                      AppStrings.selectCurr.tr(),
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(color: ColorManager.black),
                    ),
                    isExpanded: false,
                    onChanged:
                    // null,
                    (selectedValue) {
                      _onCurrencyChange(currencies, selectedValue);
                      setState(() {});
                    },
                    // value: AppSharedPreferences.currencyCode = currencies
                    //     .firstWhere((element) => element.id == 2)
                    //     .currencyName)
                    value:  context
                    .read<CurrencyCubit>()
                    .currencies[AppSharedPreferences.currencyId]
                    ?.currencyName),
                ),
          ),
        );
      },
    );
  }

  void _onCurrencyChange(List<Currency> currencies, Object? selectedValue) {
    AppSharedPreferences.currencyId = currencies
        .firstWhere((element) => element.currencyName == selectedValue)
        .id;
    appCurrency = AppSharedPreferences.currencyCode = currencies
        .firstWhere((element) => element.currencyName == selectedValue)
        .currencyCode;
  }

  List<DropdownMenuItem<String>> _mapCurrenciesToList(
      List<Currency> currencies) {
    return currencies
        .map(
          (currency) => DropdownMenuItem(
            value: currency.currencyName,
            child: Text(currency.currencyName),
          ),
        )
        .toList();
  }
}
