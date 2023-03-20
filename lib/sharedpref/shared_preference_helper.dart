import 'package:shared_preferences/shared_preferences.dart';

import 'constants/preferences.dart';

class SharedPreferenceHelper {
  // shared pref instance
  final SharedPreferences _sharedPreference;

  // constructor
  SharedPreferenceHelper(this._sharedPreference);

  // Login: ----------------------------------------------------------
  bool get getLogged {
    return _sharedPreference.getBool(Preferences.isLogin) ?? false;
  }

  // Token Device
  String get getTokenDevice {
    return _sharedPreference.getString(Preferences.tokenDevice) ?? '';
  }

  void setTokenDevice(String tokenDevice) {
    _sharedPreference.setString(Preferences.tokenDevice, tokenDevice);
  }

  void setLogged({required bool status}) {
    _sharedPreference.setBool(Preferences.isLogin, status);
  }

  // splash: ----------------------------------------------------------
  bool get getSplash {
    return _sharedPreference.getBool(Preferences.isSplash) ?? false;
  }

  void setSplash({required bool status}) {
    _sharedPreference.setBool(Preferences.isSplash, status);
  }

  // General Methods: Access token
  String get getJwtToken {
    return _sharedPreference.getString(Preferences.jwtToken) ?? '';
  }

  void setJwtToken(String authToken) {
    _sharedPreference.setString(Preferences.jwtToken, authToken);
  }

  // General Methods: Access token
  String get refreshToken {
    return _sharedPreference.getString(Preferences.refreshToken) ?? '';
  }

  void setRefreshToken(String refreshToken) {
    _sharedPreference.setString(Preferences.refreshToken, refreshToken);
  }

  // fcm token
  String get getFcmToken {
    return _sharedPreference.getString(Preferences.fcmToken) ?? '';
  }

  void setFcmToken(String fcmToken) {
    _sharedPreference.setString(Preferences.fcmToken, fcmToken);
  }

  // Language:---------------------------------------------------
  String get getLanguage {
    return _sharedPreference.getString(Preferences.currentLanguage) ?? 'vi-VN';
  }

  void setLanguage(String language) {
    _sharedPreference.setString(Preferences.currentLanguage, language);
  }

  //locale
  void setLocale(String locale) {
    _sharedPreference.setString(Preferences.locale, locale);
  }

  // locale
  String get getLocale {
    return _sharedPreference.getString(Preferences.locale) ?? 'en';
  }

  ///
  /// Time zone.
  ///
  String get getTimeZoneName {
    return _sharedPreference.getString(Preferences.idTimeZoneName) ?? '';
  }

  void setTimeZoneName({required String idTimeZoneName}) {
    _sharedPreference.setString(Preferences.idTimeZoneName, idTimeZoneName);
  }

  void removeRefreshToken() {
    _sharedPreference.remove(Preferences.refreshToken);
  }

  void removeJwtToken() {
    _sharedPreference.remove(Preferences.jwtToken);
  }

  /// Save id user.
  String get getIdUser {
    return _sharedPreference.getString(Preferences.idUser) ?? '';
  }

  void setIdUser(String idUser) {
    _sharedPreference.setString(Preferences.idUser, idUser);
  }

  void removeIdUser() {
    _sharedPreference.remove(Preferences.idUser);
  }

  void removeLogin() {
    _sharedPreference.remove(Preferences.isLogin);
  }
}
