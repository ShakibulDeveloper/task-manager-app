import 'dart:convert';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task_manager_app/data/models/user_model.dart';
import 'package:task_manager_app/data/network_caller/network_caller.dart';
import 'package:task_manager_app/data/network_caller/network_response.dart';
import 'package:task_manager_app/data/utility/urls.dart';
import 'package:task_manager_app/ui/controller/auth_controller.dart';

class UpdateProfileController extends GetxController {
  bool _updateProfileInProgress = false;
  String _message = '';
  String? _imageInBase64;

  bool get updateProfileInProgress => _updateProfileInProgress;
  String get message => _message;

  Future<bool> updateProfile(String email, String firstName, String lastName,
      String mobile, String password, XFile? photo) async {
    _updateProfileInProgress = true;
    update();

    Map<String, dynamic> inputData = {
      "email": email,
      "firstName": firstName,
      "lastName": lastName,
      "mobile": mobile,
    };
    if (password.isNotEmpty) {
      inputData["password"] = password;
    }
    if (photo != null) {
      List<int> imageInBytes = await photo.readAsBytes();
      _imageInBase64 = base64Encode(imageInBytes);
      inputData["photo"] = _imageInBase64;
    }
    final NetworkResponse response =
        await NetworkCaller.postRequest(Urls.profileUpdate, body: inputData);
    _updateProfileInProgress = false;
    update();

    if (response.isSuccess) {
      Get.find<AuthController>().updateUserInformation(UserModel(
        email: email,
        firstName: firstName,
        lastName: lastName,
        mobile: mobile,
        photo: _imageInBase64 ?? Get.find<AuthController>().user?.photo,
      ));
      _message = "Profile Updated Successfully!";
      update();
      return true;
    } else {
      _message = "Action Failed! Please Try Again.";
      update();
    }
    return false;
  }
}
