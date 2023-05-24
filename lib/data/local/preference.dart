// import 'package:app/counting/timer_helper.dart';
import 'package:easy_localization/easy_localization.dart';
// import 'package:package_info_plus/package_info_plus.dart';

import 'base_preference.dart';

class Preference {
  final _pref = BasePreference.instance;

  static const String keyIsLogin = "isLogin";
  static const String keyAdmin = "isAdmin";
  static const String keyIsFirstOpen = "isFirstOpen";
  static const String keyVersionName = "versionName";
  static const String keyHaveCurrentSessionAbsence =
      "haveCurrentSessionAbsence";
  static const String keyStarDateTimeSessionAbsence =
      "starDateTimeSessionAbsence";
  static const String keyEndDateTimeSessionAbsence =
      "endDateTimeSessionAbsence";
  static const String keyCurrentDate = "keyCurrentDate";
  static const String keyCurrentDateSelected = "keyCurrentDateSelected";
  static const String keyCurrentDateSelectedFormated =
      "keyCurrentDateSelectedFormated";
  static const String keyRageDate = "keyRageDate";

  /**
   * Get Preference
   */
  Future<bool> isAdmin() async {
    return await _pref.getPref(keyAdmin) ?? false;
  }

  Future<bool> isFirstOpen() async {
    return await _pref.getPref(keyIsFirstOpen) ?? false;
  }

  Future<bool> isLogin() async {
    return await _pref.getPref(keyIsLogin) ?? false;
  }

  Future<int> starDateTimeSessionAbsence() async {
    return await _pref.getPref(keyStarDateTimeSessionAbsence) ?? 0;
  }

  Future<int> endDateTimeSessionAbsence() async {
    return await _pref.getPref(keyEndDateTimeSessionAbsence) ?? 0;
  }

  Future<bool> haveCurrentSessionAbsence() async {
    return await _pref.getPref(keyHaveCurrentSessionAbsence) ?? false;
  }

  // Future<String> versionApp() async {
  //   final info = await PackageInfo.fromPlatform();
  //   return "Versi ${info.version}.${info.buildNumber}";
  // }

  Future<String> currentDateSelectedFormatted() async {
    return await _pref.getPref(keyCurrentDateSelectedFormated);
  }

  Future<int> currentDateSelected() async {
    return await _pref.getPref(keyCurrentDateSelected);
  }

  Future<bool> currentDate() async {
    return await _pref.getPref(keyCurrentDate);
  }

  Future<int> getRangeDate() async {
    return await _pref.getPref(keyRageDate);
  }

  /**
   * Set Preference
   */
  void setIsAdmin(bool value) {
    _pref.setPref(keyAdmin, value);
  }

  void setIsFirstOpen(bool value) {
    _pref.setPref(keyIsFirstOpen, value);
  }

  void setStarDateTimeSessionAbsence(int value) {
    _pref.setPref(keyHaveCurrentSessionAbsence, true);
    _pref.setPref(keyStarDateTimeSessionAbsence, value);
  }

  void setEndDateTimeSessionAbsence(int value) {
    _pref.setPref(keyHaveCurrentSessionAbsence, false);
    _pref.setPref(keyEndDateTimeSessionAbsence, value);
  }

  void setIsLogin(bool value) {
    _pref.setPref(keyIsLogin, value);
  }

  void setCurrentDateFormat(int value) {
    _pref.setPref(keyCurrentDateSelected, value);
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(value);
    _pref.setPref(keyCurrentDateSelectedFormated,
        DateFormat("dd MMM y").format(dateTime));
    // _pref.setPref(keyCurrentDate, TimerHelper.isCurrentDate(dateTime));
    // _pref.setPref(keyRageDate, TimerHelper.rangeDate(dateTime));
  }

  void setIsCurrentDate(bool value) {
    _pref.setPref(keyCurrentDate, value);
  }

  void setRangeDate(int value) {
    _pref.setPref(keyRageDate, value);
  }

  void logout() {
    _pref.setPref(keyIsLogin, false);
  }

  // void clear() {
  //   _pref.clearEncrypted();
  //   _pref.clearPref();
  // }
}
