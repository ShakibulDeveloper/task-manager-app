import 'package:get/get.dart';
import 'package:task_manager_app/data/network_caller/network_caller.dart';
import 'package:task_manager_app/data/network_caller/network_response.dart';
import 'package:task_manager_app/data/utility/urls.dart';

class SignUpController extends GetxController {
  bool _isSignUpInProgress = false;
  String _message = '';

  bool get isSignUpInProgress => _isSignUpInProgress;
  String get message => _message;

  Future<bool> signUp(String email, String firstName, String lastName,
      String mobile, String password) async {
    _isSignUpInProgress = true;
    update();
    final NetworkResponse response = await NetworkCaller.postRequest(
      Urls.registration,
      body: {
        "email": email,
        "firstName": firstName,
        "lastName": lastName,
        "mobile": mobile,
        "password": password,
      },
    );
    _isSignUpInProgress = false;
    update();

    if (response.isSuccess) {
      _message = "Account Created Successfully! Please login in";
      update();
      return true;
    } else {
      _message = "Account creation failed! Please try again.";
      update();
    }
    return false;
  }
}
