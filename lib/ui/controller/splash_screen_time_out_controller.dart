import 'package:get/get.dart';
import 'package:task_manager_app/ui/controller/auth_controller.dart';
import 'package:task_manager_app/ui/screens/login_screen.dart';
import 'package:task_manager_app/ui/screens/main_bottom_nav_screen.dart';

class SplashScreenTimeOutController extends GetxController {
  void splashScreenTimeOut() async {
    bool isLoggedIn = await Auth.checkUserAuthState();

    Future.delayed(const Duration(seconds: 2)).then(
      (value) => Get.offAll(
        isLoggedIn ? const MainBottomNavScreen() : const LoginScreen(),
      ),
    );
  }
}
