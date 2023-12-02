import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task_manager_app/data/models/user_model.dart';
import 'package:task_manager_app/data/network_caller/network_caller.dart';
import 'package:task_manager_app/data/network_caller/network_response.dart';
import 'package:task_manager_app/data/utility/urls.dart';
import 'package:task_manager_app/style/style.dart';
import 'package:task_manager_app/ui/controller/auth_controller.dart';
import 'package:task_manager_app/ui/controller/input_validations.dart';
import 'package:task_manager_app/ui/widgets/background_image.dart';
import 'package:task_manager_app/ui/widgets/snack_bar.dart';
import 'package:task_manager_app/ui/widgets/top_profile_summary_card.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final TextEditingController _emailInputTEController = TextEditingController();
  final TextEditingController _firstNameInputTEController =
      TextEditingController();
  final TextEditingController _lastNameInputTEController =
      TextEditingController();
  final TextEditingController _mobileInputTEController =
      TextEditingController();
  final TextEditingController _passwordInputTEController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool updateProfileInProgress = false;
  XFile? photo;

  @override
  void initState() {
    super.initState();
    _emailInputTEController.text = Auth.user?.email ?? '';
    _firstNameInputTEController.text = Auth.user?.firstName ?? '';
    _lastNameInputTEController.text = Auth.user?.lastName ?? '';
    _mobileInputTEController.text = Auth.user?.mobile ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const TopProfileSummeryCard(onTapStatus: false),
            Expanded(
              child: WithBackGroundImage(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 30),
                          const Text("Update Profile"),
                          const SizedBox(height: 8),
                          InkWell(
                            onTap: () {
                              showPhotoPickerBottomModal();
                            },
                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                      decoration: const BoxDecoration(
                                        color: Colors.black54,
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(8),
                                          bottomLeft: Radius.circular(8),
                                        ),
                                      ),
                                      alignment: Alignment.center,
                                      child: Center(
                                        child: Text(
                                          "Photo",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 6),
                                  Expanded(
                                    flex: 3,
                                    child: Visibility(
                                      visible: photo == null,
                                      replacement: Text(
                                        photo?.name ?? '',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall,
                                      ),
                                      child: Text(
                                        "Choose a Image",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          TextFormField(
                            controller: _emailInputTEController,
                            decoration:
                                const InputDecoration(hintText: "Email"),
                            validator: FormValidation.emailValidation,
                          ),
                          const SizedBox(height: 8),
                          TextFormField(
                            controller: _firstNameInputTEController,
                            decoration:
                                const InputDecoration(hintText: "First Name"),
                            validator: FormValidation.inputValidation,
                          ),
                          const SizedBox(height: 8),
                          TextFormField(
                            controller: _lastNameInputTEController,
                            decoration:
                                const InputDecoration(hintText: "Last Name"),
                            validator: FormValidation.inputValidation,
                          ),
                          const SizedBox(height: 8),
                          TextFormField(
                            controller: _mobileInputTEController,
                            decoration: const InputDecoration(
                                hintText: "Mobile Number"),
                            validator: FormValidation.phoneNumberValidation,
                          ),
                          const SizedBox(height: 8),
                          TextFormField(
                            controller: _passwordInputTEController,
                            decoration: const InputDecoration(
                                hintText: "Password (optional)"),
                          ),
                          const SizedBox(height: 8),
                          SizedBox(
                            width: double.infinity,
                            child: Visibility(
                              visible: updateProfileInProgress == false,
                              replacement: Center(
                                child: CircularProgressIndicator(
                                  color: PrimaryColor.color,
                                ),
                              ),
                              child: ElevatedButton(
                                onPressed: updateProfile,
                                child: const Icon(
                                    Icons.arrow_circle_right_outlined),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> updateProfile() async {
    String? imageInBase64;

    if (_formKey.currentState!.validate()) {
      updateProfileInProgress = true;
      if (mounted) {
        setState(() {});
      }

      Map<String, dynamic> inputData = {
        "email": _emailInputTEController.text.trim(),
        "firstName": _firstNameInputTEController.text.trim(),
        "lastName": _lastNameInputTEController.text.trim(),
        "mobile": _mobileInputTEController.text.trim(),
      };
      if (_passwordInputTEController.text.isNotEmpty) {
        inputData["password"] = _passwordInputTEController.text;
      }
      if (photo != null) {
        List<int> imageInBytes = await photo!.readAsBytes();
        imageInBase64 = base64Encode(imageInBytes);
        inputData["photo"] = imageInBase64;
      }
      final NetworkResponse response =
          await NetworkCaller.postRequest(Urls.profileUpdate, body: inputData);
      updateProfileInProgress = false;
      if (mounted) {
        setState(() {});
      }
      if (response.isSuccess) {
        Auth.updateUserInformation(UserModel(
          email: _emailInputTEController.text.trim(),
          firstName: _firstNameInputTEController.text.trim(),
          lastName: _lastNameInputTEController.text.trim(),
          mobile: _mobileInputTEController.text.trim(),
          photo: imageInBase64 ?? Auth.user?.photo,
        ));
        if (mounted) {
          showSnackBar(context, "Profile Updated Successfully!");
        }
      } else {
        if (mounted) {
          showSnackBar(context, "Action Failed! Please Try Again.", true);
        }
      }
    }
  }

  void showPhotoPickerBottomModal() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 18.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () async {
                      final XFile? image = await ImagePicker().pickImage(
                        source: ImageSource.gallery,
                        imageQuality: 50,
                      );
                      if (image != null) {
                        photo = image;
                        if (mounted) {
                          Navigator.pop(context);
                          setState(() {});
                        }
                      }
                    },
                    child: Column(
                      children: [
                        Icon(
                          Icons.image,
                          color: PrimaryColor.color,
                          size: 34,
                        ),
                        const Text(
                          "Gallery",
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  TextButton(
                    onPressed: () async {
                      final XFile? image = await ImagePicker().pickImage(
                        source: ImageSource.camera,
                        imageQuality: 50,
                      );
                      if (image != null) {
                        photo = image;
                        if (mounted) {
                          Navigator.pop(context);
                          setState(() {});
                        }
                      }
                    },
                    child: Column(
                      children: [
                        Icon(
                          Icons.camera,
                          color: PrimaryColor.color,
                          size: 34,
                        ),
                        const Text(
                          "Camera",
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
