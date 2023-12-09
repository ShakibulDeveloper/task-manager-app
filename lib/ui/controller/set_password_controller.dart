import 'package:get/get.dart';
import 'package:task_manager_app/data/network_caller/network_caller.dart';
import 'package:task_manager_app/data/network_caller/network_response.dart';
import 'package:task_manager_app/data/utility/urls.dart';

class SetPasswordController extends GetxController {
  bool _setPasswordInProgress = false;
  String _errorMessage = '';

  bool get setPasswordInProgress => _setPasswordInProgress;
  String get errorMessage => _errorMessage;

  Future<bool> setNewPassword(String email, String otp, String password) async {
    _setPasswordInProgress = true;
    update();
    final NetworkResponse response = await NetworkCaller.postRequest(
      Urls.setNewPassword,
      body: {
        "email": email,
        "OTP": otp,
        "password": password,
      },
    );
    _setPasswordInProgress = false;
    update();

    if (response.isSuccess) {
      return true;
    } else {
      _errorMessage = "Action Failed! Please try again.";
      update();
    }
    return false;
  }
}
