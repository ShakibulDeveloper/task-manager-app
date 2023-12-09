import 'package:get/get.dart';
import 'package:task_manager_app/data/models/user_model.dart';
import 'package:task_manager_app/data/network_caller/network_caller.dart';
import 'package:task_manager_app/data/network_caller/network_response.dart';
import 'package:task_manager_app/data/utility/urls.dart';
import 'package:task_manager_app/ui/controller/auth_controller.dart';

class LoginController extends GetxController {
  bool _loginInProgress = false;
  String _errorMessage = '';

  bool get loginInProgress => _loginInProgress;
  String get errorMessage => _errorMessage;

  Future<bool> login(String email, String password) async {
    _loginInProgress = true;
    update();

    final NetworkResponse response = await NetworkCaller.postRequest(
      Urls.login,
      body: {
        "email": email,
        "password": password,
      },
      isLogin: true,
    );

    _loginInProgress = false;
    update();

    if (response.isSuccess) {
      await Auth.saveUserInformation(
        response.jsonResponse["token"],
        UserModel.fromJson(response.jsonResponse['data']),
      );
      return true;
    } else {
      if (response.statusCode == 401) {
        _errorMessage = "Email or Password is incorrect.";
        update();
      } else {
        _errorMessage = "Login failed! Please try again.";
        update();
      }
    }
    return false;
  }
}
