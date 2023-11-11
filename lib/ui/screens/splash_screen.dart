import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task_manager_app/ui/screens/login_screen.dart';
import 'package:task_manager_app/ui/widgets/background_image.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void splashScreenTimeOut() {
    Future.delayed(const Duration(seconds: 2)).then(
      (value) => Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
          (route) => false),
    );
  }

  @override
  void initState() {
    super.initState();
    splashScreenTimeOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WithBackGroundImage(
        showBottomCircularLoading: true,
        child: Center(
          child: SvgPicture.asset(
            'assets/images/logo.svg',
            width: 120,
          ),
        ),
      ),
    );
  }
}
