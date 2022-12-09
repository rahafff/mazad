
import 'dart:io';

import 'package:elite_auction/core/resources/strings_manager.dart';

import 'SharedPreferences/SharedPreferencesHelper.dart';

String appCurrency = AppSharedPreferences.currencyCode ?? "";
bool lang = AppSharedPreferences.lang == AppStrings.englishCode;
bool isTokenExist = AppSharedPreferences.accessToken != null;
bool isCustomerScreen = false;
late String? expireDate;
 File? trimmedVideo;



