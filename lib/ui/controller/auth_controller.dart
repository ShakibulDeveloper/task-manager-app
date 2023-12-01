import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager_app/app.dart';
import 'package:task_manager_app/data/models/user_model.dart';
import 'package:task_manager_app/ui/screens/login_screen.dart';

class Auth {
  static String? token;
  static UserModel? user;

  static Future<void> saveUserInformation(String t, UserModel model) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    await sharedPreferences.setString("token", t);
    await sharedPreferences.setString("user", jsonEncode(model.toJson()));
    token = t;
    user = model;
  }

  static Future<void> updateUserInformation(UserModel model) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    await sharedPreferences.setString("user", jsonEncode(model.toJson()));
    user = model;
  }

  static Future<void> getUserInformation() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    token = sharedPreferences.getString("token");
    user = UserModel.fromJson(
        jsonDecode(sharedPreferences.getString("user") ?? '{}'));
  }

  static Future<bool> checkUserAuthState() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString("token");
    if (token != null) {
      await getUserInformation();
      return true;
    }
    return false;
  }

  static Future<void> clearUserAuthState() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.clear();
    token = null;
  }

  static Future<void> backToLogin() async {
    await Auth.clearUserAuthState();
    Navigator.pushAndRemoveUntil(
        TaskManagerApp.navigatorKey.currentContext!,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
        (route) => false);
  }
}
