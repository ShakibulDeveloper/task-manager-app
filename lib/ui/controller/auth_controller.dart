import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager_app/data/models/user_model.dart';
import 'package:task_manager_app/ui/screens/login_screen.dart';

class AuthController extends GetxController {
  static String? token;
  UserModel? user;

  Future<void> saveUserInformation(String t, UserModel model) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    await sharedPreferences.setString("token", t);
    await sharedPreferences.setString("user", jsonEncode(model.toJson()));
    token = t;
    user = model;
    update();
  }

  Future<void> updateUserInformation(UserModel model) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    await sharedPreferences.setString("user", jsonEncode(model.toJson()));
    user = model;
    update();
  }

  Future<void> getUserInformation() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    token = sharedPreferences.getString("token");
    user = UserModel.fromJson(
        jsonDecode(sharedPreferences.getString("user") ?? '{}'));
    update();
  }

  Future<bool> checkUserAuthState() async {
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
    await AuthController.clearUserAuthState();
    // Navigator.pushAndRemoveUntil(
    //     TaskManagerApp.navigatorKey.currentContext!,
    //     MaterialPageRoute(builder: (context) => ),
    //     (route) => false);
    Get.offAll(const LoginScreen());
  }
}
