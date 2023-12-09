import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:task_manager_app/style/style.dart';
import 'package:task_manager_app/ui/controller/pin_verify_controller.dart';
import 'package:task_manager_app/ui/screens/login_screen.dart';
import 'package:task_manager_app/ui/screens/set_password_screen.dart';
import 'package:task_manager_app/ui/widgets/background_image.dart';
import 'package:task_manager_app/ui/widgets/snack_bar.dart';

class PinVerifyScreen extends StatefulWidget {
  final String email;
  const PinVerifyScreen({super.key, required this.email});

  @override
  State<PinVerifyScreen> createState() => _PinVerifyScreenState();
}

class _PinVerifyScreenState extends State<PinVerifyScreen> {
  Map<String, String> pinCode = {'otp': ''};

  final PinVerifyController _pinVerifyController =
      Get.find<PinVerifyController>();

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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("PIN Verification",
                      style: Theme.of(context).textTheme.bodyLarge),
                  const SizedBox(height: 8),
                  Text(
                    "A 6 digit verification pin will be send to your email address",
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(height: 16),
                  PinCodeTextField(
                    appContext: context,
                    length: 6,
                    obscureText: false,
                    keyboardType: TextInputType.number,
                    animationType: AnimationType.fade,
                    pinTheme: customPinTheme(),
                    animationDuration: const Duration(milliseconds: 300),
                    backgroundColor: Colors.transparent,
                    enableActiveFill: true,
                    onCompleted: (v) {},
                    onChanged: (value) {
                      pinCode['otp'] = value;
                    },
                  ),
                  const SizedBox(height: 8),
                  GetBuilder<PinVerifyController>(
                      builder: (pinVerifyController) {
                    return Visibility(
                      visible: pinVerifyController.pinVerifyInProgress == false,
                      replacement: Center(
                          child: CircularProgressIndicator(
                        color: PrimaryColor.color,
                      )),
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: verifyPinCode,
                          child: const Text("Verify"),
                        ),
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
                          Get.off(const LoginScreen());
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
    );
  }

  Future<void> verifyPinCode() async {
    if (pinCode['otp'] != null && pinCode['otp']?.length == 6) {
      final response = await _pinVerifyController.verifyPinCode(
          widget.email, pinCode['otp']!);

      if (response) {
        Get.offAll(SetPasswordScreen(
          email: widget.email,
          pin: pinCode['otp']!,
        ));
      } else {
        if (mounted) {
          showSnackBar(context, _pinVerifyController.errorMessage, true);
        }
      }
    } else {
      showSnackBar(context, "Invalid OTP Code.", true);
    }
  }
}
