import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:task_manager_app/data/network_caller/network_caller.dart';
import 'package:task_manager_app/data/network_caller/network_response.dart';
import 'package:task_manager_app/data/utility/urls.dart';
import 'package:task_manager_app/style/style.dart';
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
  bool pinVerifyInProgress = false;

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
                  Visibility(
                    visible: pinVerifyInProgress == false,
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
                  ),
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
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginScreen(),
                            ),
                            (route) => false,
                          );
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
      pinVerifyInProgress = true;
      if (mounted) {
        setState(() {});
      }

      final NetworkResponse response = await NetworkCaller.getRequest(
          Urls.verifyPinCode(widget.email, pinCode['otp']!));

      pinVerifyInProgress = false;
      if (mounted) {
        setState(() {});
      }
      if (response.isSuccess && response.jsonResponse['status'] != 'fail') {
        if (mounted) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => SetPasswordScreen(
                email: widget.email,
                pin: pinCode['otp']!,
              ),
            ),
            (route) => false,
          );
        }
      } else {
        if (mounted) {
          showSnackBar(context, "Invalid OTP Code.", true);
        }
      }
    } else {
      showSnackBar(context, "Invalid OTP Code.", true);
    }
  }
}
