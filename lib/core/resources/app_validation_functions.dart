import 'package:easy_localization/easy_localization.dart';
import 'package:elite_auction/core/resources/strings_manager.dart';

class AppValidation {
  static String? validateOldPassword(String? value) {
    if (value == null || value.isEmpty) {
      return AppStrings.plzEnterOld.tr();
    } else if (value.length < 8) {
      return AppStrings.passMustBeGreaterThan7.tr();
    } else {
      return null;
    }
  }

  static String? validateSearch(String? value) {
    if (value == null || value.isEmpty) {
      return AppStrings.plzEnterSearch.tr();
    } else if (value.length < 3) {
      return AppStrings.searchTextMustBeGreaterThan3.tr();
    } else {
      return null;
    }
  }

  static String? validateConfirmPasswordInUpdatePasswordScreen(
      String? passwordConfirmation, String? newPassword) {
    if (passwordConfirmation == null || passwordConfirmation.isEmpty) {
      return AppStrings.plzConfirmPassword.tr();
    } else if (passwordConfirmation != newPassword) {
      return AppStrings.confirmDontMatch.tr();
    } else {
      return null;
    }
  }

  static String? validateNewPassword(String? value) {
    if (value == null || value.isEmpty) {
      return AppStrings.plzEnterNewPassword.tr();
    } else if (value.length < 8) {
      return AppStrings.passMustBeGreaterThan7.tr();
    } else {
      return null;
    }
  }

  static String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return AppStrings.plsEnterPhoneNum.tr();
    } else if (value.length < 12) {
      return AppStrings.phoneNumMustBeGreaterThan8.tr();
    } else {
      return null;
    }
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return AppStrings.plzEnterPass.tr();
    } else if (value.length < 8) {
      return AppStrings.passMustBeGreaterThan7.tr();
    } else {
      return null;
    }
  }

  static String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return AppStrings.plzEnterName.tr();
    } else if (value.length < 5) {
      return AppStrings.userNameLengthValidation.tr();
    } else {
      return null;
    }
  }


  static String? validateOnArabicCharacters(String value) {
    RegExp  validArabicCharacters = RegExp(r'^[\u0600-\u065F\u066A-\u06EF\u06FA-\u06FFa-]*$');
    if (value.isEmpty || value==null) {
      return 'this field is required';
    }
    else if ( !validArabicCharacters.hasMatch(value)){
      return "Enter valid arabic characters";
    }
    else {
      return null;
    }
  }

  static String? validateOnEnglishCharacters(String value) {
    RegExp validEnglishCharacters =
    RegExp(r'^[a-zA-Z0-9_\-=@,\.;]+$');
    if (value.isEmpty || value==null) {
      return 'this field is required';
    }
    else if ( !validEnglishCharacters.hasMatch(value)){
      return "Enter valid english characters";
    }
    else {
      return null;
    }
  }

  static String? validateOnNumbers(String value) {
        RegExp validNumbers =
        RegExp(r'[0-9]');
        // RegExp validNumbers2 =
        // RegExp(r'^[_\-=@,\.;]+$');
        if (value.isEmpty || value==null)
        {
      return 'this field is required';
       }
        else if ( value.contains('-')){
          return "Number mustn't be negative";
        }
        else if ( !validNumbers.hasMatch(value)){
      return "Enter valid numbers";
       }
        else {
      return null;
    }
  }

  static String? validateZone(String? value) {
    if (value == null || value.isEmpty) {
      return AppStrings.plzEnterZone.tr();
    }
    return null;
  }

  static String? validateStreet(String? value) {
    if (value == null || value.isEmpty) {
      return AppStrings.plzEnterStreet.tr();
    }
    return null;
  }

  static String? validateBuildingNumber(String? value) {
    if (value == null || value.isEmpty) {
      return AppStrings.plzEnterBuildingNumber.tr();
    }
    return null;
  }

  static String? validatePasswordConfirmationInRegisterScreen(
      String? passwordConfirmation, String? password) {
    if (passwordConfirmation == null || passwordConfirmation.isEmpty) {
      return AppStrings.plzConfirmPassword.tr();
    } else if (passwordConfirmation != password) {
      return AppStrings.confirmPasswordValidation.tr();
    } else {
      return null;
    }
  }

  static String? validateVerificationCode(String? value) {
    if (value == null || value.isEmpty) return AppStrings.plzEnterVerCode.tr();
    return null;
  }
}
