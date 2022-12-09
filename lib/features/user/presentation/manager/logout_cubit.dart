import 'package:easy_localization/easy_localization.dart';
import 'package:elite_auction/core/utils/SharedPreferences/SharedPreferencesHelper.dart';
import 'package:elite_auction/core/utils/global.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../../core/resources/strings_manager.dart';

part 'logout_state.dart';

class LogoutCubit extends Cubit<LogoutState> {
  LogoutCubit() : super(LogoutInitial());
  Future<void> logout() async {
    try {
      AppSharedPreferences.clearForLogOut();
      isTokenExist = false;
      emit(
        LogoutSuccess(
          message: AppStrings.logoutSuccess.tr(),
        ),
      );
    } catch (error) {
      emit(
        LogoutError(
          message: error.toString(),
        ),
      );
    }
  }
}
