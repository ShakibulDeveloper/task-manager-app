import 'package:flutter/material.dart';
import 'package:task_manager_app/data/network_caller/network_caller.dart';
import 'package:task_manager_app/data/network_caller/network_response.dart';
import 'package:task_manager_app/data/utility/urls.dart';
import 'package:task_manager_app/style/style.dart';
import 'package:task_manager_app/ui/controller/input_validations.dart';
import 'package:task_manager_app/ui/widgets/background_image.dart';
import 'package:task_manager_app/ui/widgets/snack_bar.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailInputTEController = TextEditingController();
  final TextEditingController _firstNameInputTEController =
      TextEditingController();
  final TextEditingController _lastNameInputTEController =
      TextEditingController();
  final TextEditingController _mobileNumberInputTEController =
      TextEditingController();
  final TextEditingController _passwordInputTEController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool isSignUpInProgress = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WithBackGroundImage(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 16.0,
            right: 16.0,
            top: 40,
          ),
          child: SafeArea(
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Join Us",
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
                      controller: _firstNameInputTEController,
                      decoration: const InputDecoration(
                        hintText: "First Name",
                      ),
                      validator: FormValidation.inputValidation,
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _lastNameInputTEController,
                      decoration: const InputDecoration(
                        hintText: "Last Name",
                      ),
                      validator: FormValidation.inputValidation,
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _mobileNumberInputTEController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        hintText: "Mobile Name",
                      ),
                      validator: FormValidation.phoneNumberValidation,
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      obscureText: true,
                      controller: _passwordInputTEController,
                      decoration: const InputDecoration(
                        hintText: "Password",
                      ),
                      validator: FormValidation.inputValidation,
                    ),
                    const SizedBox(height: 8),
                    Visibility(
                      visible: isSignUpInProgress == false,
                      replacement: Padding(
                        padding: const EdgeInsets.only(top: 12),
                        child: Center(
                          child: CircularProgressIndicator(
                            color: PrimaryColor.color,
                          ),
                        ),
                      ),
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _signUp,
                          child: const Icon(Icons.arrow_circle_right_outlined),
                        ),
                      ),
                    ),
                    const SizedBox(height: 35),
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

  Future<void> _signUp() async {
    if (_formKey.currentState!.validate()) {
      isSignUpInProgress = true;
      if (mounted) {
        setState(() {});
      }

      final NetworkResponse response = await NetworkCaller.postRequest(
        Urls.registration,
        body: {
          "email": _emailInputTEController.text.trim(),
          "firstName": _firstNameInputTEController.text.trim(),
          "lastName": _lastNameInputTEController.text.trim(),
          "mobile": _mobileNumberInputTEController.text.trim(),
          "password": _passwordInputTEController.text,
        },
      );
      isSignUpInProgress = false;
      if (mounted) {
        setState(() {});
      }
      if (mounted) {
        if (response.isSuccess) {
          _clearInputText();
          showSnackBar(
            context,
            "Account Created Successfully! Please login in",
          );
        }
      } else {
        if (mounted) {
          showSnackBar(
              context, "Account creation failed! Please try again.", true);
        }
      }
    }
  }

  void _clearInputText() {
    _emailInputTEController.clear();
    _firstNameInputTEController.clear();
    _lastNameInputTEController.clear();
    _mobileNumberInputTEController.clear();
    _passwordInputTEController.clear();
  }

  @override
  void dispose() {
    _emailInputTEController.dispose();
    _firstNameInputTEController.dispose();
    _lastNameInputTEController.dispose();
    _mobileNumberInputTEController.dispose();
    _passwordInputTEController.dispose();
    super.dispose();
  }
}
