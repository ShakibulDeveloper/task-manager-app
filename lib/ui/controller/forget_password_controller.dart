import 'package:get/get.dart';
import 'package:task_manager_app/data/network_caller/network_caller.dart';
import 'package:task_manager_app/data/network_caller/network_response.dart';
import 'package:task_manager_app/data/utility/urls.dart';
import 'package:task_manager_app/ui/screens/pin_verify_screen.dart';

class ForgetPasswordController extends GetxController {
  bool _emailVerifyInProgress = false;
  String _errorMessage = '';

  bool get emailVerifyInProgress => _emailVerifyInProgress;
  String get errorMessage => _errorMessage;

  Future<bool> verifyEmailAddress(String email) async {
    _emailVerifyInProgress = true;
    update();
    final NetworkResponse response =
        await NetworkCaller.getRequest(Urls.verifyEmailAddress(email));

    _emailVerifyInProgress = false;
    update();
    if (response.isSuccess && response.jsonResponse['status'] == 'success') {
      Get.offAll(PinVerifyScreen(
        email: email,
      ));
      return true;
    } else {
      _errorMessage = "Action Failed! Please try again.";
      update();
    }
    return false;
  }
}
