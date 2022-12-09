import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:elite_auction/core/resources/strings_manager.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/SharedPreferences/SharedPreferencesHelper.dart';
import '../../../../core/utils/global.dart';

part 'language_state.dart';

class LanguageCubit extends Cubit<LanguageState> {
  LanguageCubit() : super(LanguageState());

  Future<void> changeLanguage(bool newValue, BuildContext context) async {
    await changeLocal(newValue, context);
    lang = !lang;
    print(lang);
    if (lang) {
      emit(EnglishLanguage());
    } else {
      emit(ArabicLanguage());
    }
  }

  Future<bool> changeLocal(bool newValue, BuildContext context) async {
    if (newValue) {
      await context.setLocale(
        const Locale(AppStrings.englishCode),
      );
      AppSharedPreferences.lang = AppStrings.englishCode;
      return true;
    } else {
      await context.setLocale(
        const Locale(AppStrings.arabicCode),
      );
      AppSharedPreferences.lang = AppStrings.arabicCode;
      return false;
    }
  }
}
