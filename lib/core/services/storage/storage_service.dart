import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../constant/constants.dart';
import '../../models/entities.dart';

class StorageService {
  late final SharedPreferences _prefs;

  Future<StorageService> init() async {
    _prefs = await SharedPreferences.getInstance();
    return this;
  }

  Future<bool> setBool(String key, bool value) async {
    return await _prefs.setBool(key, value);
  }

  Future<bool> setString(String key, String value) async {
    return await _prefs.setString(key, value);
  }

  bool getDeviceFirstOpen() {
    return _prefs.getBool(AppConstants.STORAGE_DEVICE_OPEN_FIRST_TIME) ?? false;
  }

  bool getIsLoggedIn() {
    return _prefs.getString(AppConstants.STORAGE_USER_TOKEN_KEY) == null
        ? false
        : true;
  }

  bool getIsPackage() {
    return _prefs.getString(AppConstants.STORAGE_PACKAGE_ID) == null
        ? false
        : true;
  }

  Future<bool> remove(String key) async {
    return await _prefs.remove(key);
  }

  //Get user access token// user access token used for autorization between backend and frontend
  String getUserToken() {
    return _prefs.getString(AppConstants.STORAGE_USER_TOKEN_KEY) ?? "";
  }

  //Get user token // used for foreign key
  String getToken() {
    return _prefs.getString(AppConstants.STORAGE_USER_TOKEN) ?? "";
  }

  //Get user email
  String getUserEmail() {
    return _prefs.getString(AppConstants.STORAGE_USER_EMAIL) ?? "";
  }

  //Get package id
  String getPackageId() {
    return _prefs.getString(AppConstants.STORAGE_PACKAGE_ID) ?? "";
  }

  //Get student id
  String getStudentId() {
    return _prefs.getString(AppConstants.STORAGE_STUDENT_ID) ?? "";
  }

  //Get topic item
  TopicItem? getTopicItem() {
    var topicOffline = _prefs.getString(AppConstants.STORAGE_TOPIC_KEY) ?? "";
    if (topicOffline.isNotEmpty) {
      return TopicItem.fromJson(jsonDecode(topicOffline));
    }
    return null;
  }

  StudentItem getStudentProfile() {
    var profileOffline =
        _prefs.getString(AppConstants.STORAGE_STUDENT_PROFILE_KEY) ?? "";
    if (profileOffline.isNotEmpty) {
      return StudentItem.fromJson(jsonDecode(profileOffline));
    }
    return StudentItem();
    // return null;
  }

  //Get user item
  UserItem getUserProfile() {
    var profileOffline =
        _prefs.getString(AppConstants.STORAGE_USER_PROFILE_KEY) ?? "";
    if (profileOffline.isNotEmpty) {
      return UserItem.fromJson(jsonDecode(profileOffline));
    }
    return UserItem();
    // return null;
  }
}
