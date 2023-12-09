import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_app/style/style.dart';
import 'package:task_manager_app/ui/controller/input_validations.dart';
import 'package:task_manager_app/ui/controller/login_controller.dart';
import 'package:task_manager_app/ui/screens/forget_password_screen.dart';
import 'package:task_manager_app/ui/screens/main_bottom_nav_screen.dart';
import 'package:task_manager_app/ui/screens/signup_screen.dart';
import 'package:task_manager_app/ui/widgets/background_image.dart';
import 'package:task_manager_app/ui/widgets/snack_bar.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailInputTEController = TextEditingController();
  final TextEditingController _passwordInputTEController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final LoginController _loginController = Get.find<LoginController>();

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
                    Text("Get Started With",
                        style: Theme.of(context).textTheme.bodyLarge),
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
                    TextFormField(
                      controller: _passwordInputTEController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        hintText: "Password",
                      ),
                      validator: FormValidation.inputValidation,
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      width: double.infinity,
                      child: GetBuilder<LoginController>(
                          builder: (loginController) {
                        return Visibility(
                          visible: loginController.loginInProgress == false,
                          replacement: Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Center(
                                child: CircularProgressIndicator(
                              color: PrimaryColor.color,
                            )),
                          ),
                          child: ElevatedButton(
                              onPressed: _login,
                              child: const Icon(
                                  Icons.arrow_circle_right_outlined)),
                        );
                      }),
                    ),
                    const SizedBox(height: 48),
                    Center(
                      child: TextButton(
                        onPressed: () {
                          Get.to(const ForgetPasswordScreen());
                        },
                        child: const Text(
                          "Forget Password ?",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Don't have account?",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 13),
                        ),
                        TextButton(
                          onPressed: () {
                            Get.to(const SignUpScreen());
                          },
                          child: Text(
                            "Sign up",
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

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final response = await _loginController.login(
      _emailInputTEController.text.trim(),
      _passwordInputTEController.text,
    );

    if (response) {
      Get.offAll(const MainBottomNavScreen());
    } else {
      if (mounted) {
        showSnackBar(context, _loginController.errorMessage, true);
      }
    }
  }

  @override
  void dispose() {
    _emailInputTEController.dispose();
    _passwordInputTEController.dispose();
    super.dispose();
  }
}
