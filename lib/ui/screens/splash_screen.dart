import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:task_manager_app/ui/controller/splash_screen_time_out_controller.dart';
import 'package:task_manager_app/ui/widgets/background_image.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Get.find<SplashScreenTimeOutController>().splashScreenTimeOut();
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
