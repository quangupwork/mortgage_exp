import 'package:shared_preferences/shared_preferences.dart';

import '../utilities/converter.dart';

abstract class BasePreference {
  Future getLocal(String key, {bool isDateTime = false}) async {
    final _prefs = await SharedPreferences.getInstance();
    if (isDateTime) {
      return ConvertUtility.convertPreferenceDate(_prefs.getString(key) ?? "");
    }
    return _prefs.getString(key);
  }

  Future setLocal(String key, String? value) async {
    final _prefs = await SharedPreferences.getInstance();
    if (value == null) {
      await _prefs.remove(key);
    } else {
      await _prefs.setString(key, value);
    }
  }

  Future getBool(String key, {bool isDateTime = false}) async {
    final _prefs = await SharedPreferences.getInstance();
    if (isDateTime) {
      return ConvertUtility.convertPreferenceDate(_prefs.getString(key) ?? "");
    }
    return _prefs.getBool(key);
  }

  Future setBool(String key, bool? value) async {
    final _prefs = await SharedPreferences.getInstance();
    if (value == null) {
      await _prefs.remove(key);
    } else {
      await _prefs.setBool(key, value);
    }
  }

  Future getListString(String key) async {
    final _prefs = await SharedPreferences.getInstance();
    return _prefs.getStringList(key);
  }

  Future setListString(String key, List<String>? value) async {
    final _prefs = await SharedPreferences.getInstance();
    if (value == null) {
      await _prefs.remove(key);
    } else {
      await _prefs.setStringList(key, value);
    }
  }

  Future clearLocal() async {
    final _prefs = await SharedPreferences.getInstance();
    await _prefs.clear();
  }
}
