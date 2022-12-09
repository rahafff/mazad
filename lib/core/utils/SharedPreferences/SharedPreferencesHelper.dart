import 'dart:io';

import 'SharedPreferencesProvider.dart';
import 'app_shared_preference_keys.dart';

class AppSharedPreferences {
  static bool? initialized;
  static SharedPreferencesProvider? _pref;
  static init() async {
    _pref = await SharedPreferencesProvider.getInstance();
  }

  static clear() {
    _pref?.clear();
  }

  static clearForLogOut() {
    removeAccessToken();
    removeFcmToken();
    removeAccessPhone();
    removeAccessPassword();
  }

  //accessToken
  static String? get accessToken => _pref?.read(KEY_ACCESS_TOKEN);
  static set accessToken(String? accessToken) =>
      _pref?.save(KEY_ACCESS_TOKEN, accessToken);
  static bool get hasAccessToken => _pref?.contains(KEY_ACCESS_TOKEN);
  static removeAccessToken() => _pref?.remove(KEY_ACCESS_TOKEN);

  //accessTokenFirebase
  static String? get accessTokenFirebase =>
      _pref?.read(KEY_ACCESS_TOKEN_Firebase);
  static set accessTokenFirebase(String? accessTokenFirebase) =>
      _pref?.save(KEY_ACCESS_TOKEN_Firebase, accessTokenFirebase);
  static bool get hasAccessTokenFirebase =>
      _pref?.contains(KEY_ACCESS_TOKEN_Firebase);
  static removeAccessTokenFirebase() =>
      _pref?.remove(KEY_ACCESS_TOKEN_Firebase);
  //FCM Token
  static String? get fcmToken => _pref?.read(KEY_FCM_TOKEN);
  static set fcmToken(String? accessTokenFirebase) =>
      _pref?.save(KEY_FCM_TOKEN, accessTokenFirebase);
  static removeFcmToken() => _pref?.remove(KEY_FCM_TOKEN);

  //language
  static String? get lang => _pref?.read(KEY_LANG);
  static set lang(String? lang) => _pref?.save(KEY_LANG, lang);

  //FIRST_TIME
  static bool? get firstTime {
    if (_pref?.readBoolean(KEY_FIRST_TIME) == null) firstTime = true;

    return _pref?.readBoolean(KEY_FIRST_TIME);
  }

  static set firstTime(bool? first) =>
      _pref?.saveBoolean(KEY_FIRST_TIME, first!);

  //Verification
  static String get accessVerification => _pref?.read(KEY_VERIFICATION);
  static set accessVerification(String? verification) =>
      _pref?.save(KEY_VERIFICATION, verification);
  static bool get hasAccessVerification => _pref?.contains(KEY_VERIFICATION);
  static removeAccessVerification() => _pref?.remove(KEY_VERIFICATION);


  //file
  static File? get accessVideo => _pref?.read(KEY_FILE);
  static set accessVideo(File? video) => _pref?.save(KEY_FILE,video );


  //phone
  static String? get accessPhone => _pref?.read(KEY_PHONE);
  static set accessPhone(String? phone) => _pref?.save(KEY_PHONE, phone);
  static bool get hasAccessPhone => _pref?.contains(KEY_PHONE);
  static removeAccessPhone() => _pref?.remove(KEY_PHONE);
  //password
  static String? get accessPassword => _pref?.read(KEY_PASSWORD);
  static set accessPassword(String? password) => _pref?.save(KEY_PASSWORD, password);
  static removeAccessPassword() => _pref?.remove(KEY_PASSWORD);

  //email
  static String get accessEmail => _pref?.read(KEY_EMAIL);

  static set accessEmail(String email) => _pref?.save(KEY_EMAIL, email);

  static bool get hasAccessEmail => _pref?.contains(KEY_EMAIL);

  static removeAccessEmail() => _pref?.remove(KEY_EMAIL);

  //name
  static String get accessName => _pref?.read(KEY_NAME);

  static set accessName(String? name) => _pref?.save(KEY_NAME, name);

  static bool get hasAccessName => _pref?.contains(KEY_NAME);

  static removeAccessName() => _pref?.remove(KEY_NAME);

  //currency name
  static String? get currencyCode => _pref?.read(KEY_CURRENCY_NAME);

  static set currencyCode(String? name) => _pref?.save(KEY_CURRENCY_NAME, name);
  //currency id
  static int? get currencyId => _pref?.read(KEY_CURRENCY_ID);

  static set currencyId(int? id) => _pref?.save(KEY_CURRENCY_ID, id);

  //user id
  static int get accessUserId => _pref?.read(KEY_USER_ID);

  static set accessUserId(int? id) => _pref?.save(KEY_USER_ID, id);
  //uuid
  static String? get accessUuid => _pref?.read(KEY_UUID);

  static set accessUuid(String? uuid) => _pref?.save(KEY_UUID, uuid);

  //payment id
  static String get paymentID => _pref?.read(KEY_PAYMENT);

  static set paymentID(String id) => _pref?.save(KEY_PAYMENT, id);

  // building number
  static String? get buildingNumber => _pref?.read(KEY_BUILDING_NUMBER);

  static set buildingNumber(String? buildingNumber) =>
      _pref?.save(KEY_BUILDING_NUMBER, buildingNumber);

  static removeBuildingNumber() => _pref?.remove(KEY_BUILDING_NUMBER);

  // street
  static String? get street => _pref?.read(KEY_STREET);

  static set street(String? street) => _pref?.save(KEY_STREET, street);
  static removeStreet() => _pref?.remove(KEY_STREET);
  // floor
  static String? get floor => _pref?.read(KEY_FLOOR);

  static set floor(String? floor) => _pref?.save(KEY_FLOOR, floor);
  // appartment
  static String? get appartment => _pref?.read(KEY_APPARTMENT);

  static set appartment(String? appartment) => _pref?.save(KEY_APPARTMENT, appartment);
  // locationName
  static String? get locationName => _pref?.read(KEY_LOCATION);

  static set locationName(String? locationName) => _pref?.save(KEY_LOCATION, locationName);
  // additionalInfo
  static String? get additionalInfo => _pref?.read(KEY_ADDITIONAL_INFO);

  static set additionalInfo(String? additionalInfo) =>
      _pref?.save(KEY_ADDITIONAL_INFO, additionalInfo);
  static removeAdditionalInfo() => _pref?.remove(KEY_ADDITIONAL_INFO);

  // country
  static String? get zoneNumber => _pref?.read(KEY_ZONE);

  static set zoneNumber(String? zoneNumber) =>
      _pref?.save(KEY_ZONE, zoneNumber);
  static removeCountry() => _pref?.remove(KEY_ZONE);

  // city
  static String? get city => _pref?.read(KEY_CITY);

  static set city(String? city) => _pref?.save(KEY_CITY, city);
  static removeCity() => _pref?.remove(KEY_CITY);

  // Latitude
  static String? get latitude => _pref?.read(KEY_LAT);
  static set latitude(String? latitude) => _pref?.save(KEY_LAT, latitude);
  static removeLatitude() => _pref?.remove(KEY_LAT);

  // Longitude
  static String? get longitude => _pref?.read(KEY_LONG);
  static set longitude(String? longitude) => _pref?.save(KEY_LONG, longitude);
  static removeLongitude() => _pref?.remove(KEY_LONG);
}
