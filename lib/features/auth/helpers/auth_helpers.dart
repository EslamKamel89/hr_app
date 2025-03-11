import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hr/core/globals.dart';
import 'package:hr/core/router/app_routes_names.dart';
import 'package:hr/core/service_locator/service_locator.dart';
import 'package:hr/core/static_data/shared_prefrences_key.dart';
import 'package:hr/core/widgets/show_are_you_sure_dialog.dart';
import 'package:hr/features/auth/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthHelpers {
  static UserModel? _user;
  static String? _token;
  static SharedPreferences sh = serviceLocator<SharedPreferences>();

  static Future cacheUser(UserModel user) async {
    _user = user;
    _token = user.accessToken;
    await sh.setString(ShPrefKey.user, jsonEncode(user.toJson()));
    await sh.setString(ShPrefKey.token, user.accessToken ?? '');
  }

  static UserModel? getUser() {
    if (_user != null) return _user;
    String? userStr = sh.getString(ShPrefKey.user);
    if (userStr == null) return null;
    return UserModel.fromJson(jsonDecode(userStr));
  }

  static String? getToken() {
    if (_token != null) return _token;
    _token = sh.getString(ShPrefKey.token);
    return _token;
  }

  static bool isSignedIn() {
    if (_token != null) return true;
    _token = sh.getString(ShPrefKey.token);
    return _token != null;
  }

  static Future logout() async {
    BuildContext? context = navigatorKey.currentContext;
    if (context == null) return;
    bool? confirm = await showAreYouSureDialog();
    if (confirm != true) return;
    serviceLocator<SharedPreferences>().clear();
    _token = null;
    _user = null;
    Navigator.of(
      context,
    ).pushNamedAndRemoveUntil(AppRoutesNames.signInView, (_) => true);
  }
}
