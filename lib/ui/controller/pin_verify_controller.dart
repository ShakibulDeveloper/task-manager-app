import 'package:get/get.dart';
import 'package:task_manager_app/data/network_caller/network_caller.dart';
import 'package:task_manager_app/data/network_caller/network_response.dart';
import 'package:task_manager_app/data/utility/urls.dart';
import 'package:task_manager_app/ui/screens/set_password_screen.dart';

class PinVerifyController extends GetxController {
  bool _pinVerifyInProgress = false;
  String _errorMessage = '';

  bool get pinVerifyInProgress => _pinVerifyInProgress;
  String get errorMessage => _errorMessage;

  Future<bool> verifyPinCode(String email, String otp) async {
    _pinVerifyInProgress = true;
    update();

    final NetworkResponse response =
        await NetworkCaller.getRequest(Urls.verifyPinCode(email, otp));

    _pinVerifyInProgress = false;
    update();

    if (response.isSuccess && response.jsonResponse['status'] != 'fail') {
      Get.offAll(SetPasswordScreen(
        email: email,
        pin: otp,
      ));
      return true;
    } else {
      _errorMessage = "Invalid OTP Code.";
      update();
    }
    return false;
  }
}
