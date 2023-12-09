import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_app/style/style.dart';
import 'package:task_manager_app/ui/controller/forget_password_controller.dart';
import 'package:task_manager_app/ui/controller/input_validations.dart';
import 'package:task_manager_app/ui/screens/pin_verify_screen.dart';
import 'package:task_manager_app/ui/widgets/background_image.dart';
import 'package:task_manager_app/ui/widgets/snack_bar.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final TextEditingController _emailInputTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final ForgetPasswordController _forgetPasswordController =
      Get.find<ForgetPasswordController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WithBackGroundImage(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 16.0,
            right: 16.0,
            top: 60,
          ),
          child: SafeArea(
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Your Email Address",
                        style: Theme.of(context).textTheme.bodyLarge),
                    const SizedBox(height: 8),
                    Text(
                      "A 6 digit verification pin will be send to your email address",
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _emailInputTEController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        hintText: "Email",
                      ),
                      validator: FormValidation.emailValidation,
                    ),
                    const SizedBox(height: 8),
                    GetBuilder<ForgetPasswordController>(
                        builder: (forgetPasswordController) {
                      return Visibility(
                        visible:
                            forgetPasswordController.emailVerifyInProgress ==
                                false,
                        replacement: Center(
                          child: CircularProgressIndicator(
                            color: PrimaryColor.color,
                          ),
                        ),
                        child: SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                              onPressed: verifyEmailAddress,
                              child: const Icon(
                                  Icons.arrow_circle_right_outlined)),
                        ),
                      );
                    }),
                    const SizedBox(height: 48),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Have account?",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            "Sign in",
                            style: TextStyle(color: PrimaryColor.color),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> verifyEmailAddress() async {
    if (_formKey.currentState!.validate()) {
      final response = await _forgetPasswordController
          .verifyEmailAddress(_emailInputTEController.text.trim());

      if (response) {
        Get.offAll(PinVerifyScreen(
          email: _emailInputTEController.text.trim(),
        ));
      } else {
        if (mounted) {
          showSnackBar(context, _forgetPasswordController.errorMessage, true);
        }
      }
    }
  }
}
