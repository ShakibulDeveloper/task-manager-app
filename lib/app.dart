import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_app/ui/controller/auth_controller.dart';
import 'package:task_manager_app/ui/controller/create_new_task_controller.dart';
import 'package:task_manager_app/ui/controller/forget_password_controller.dart';
import 'package:task_manager_app/ui/controller/get_cancel_task_list_controller.dart';
import 'package:task_manager_app/ui/controller/get_complete_task_list_controller.dart';
import 'package:task_manager_app/ui/controller/get_in_progress_task_list_controller.dart';
import 'package:task_manager_app/ui/controller/get_task_list_controller.dart';
import 'package:task_manager_app/ui/controller/get_task_status_count_controller.dart';
import 'package:task_manager_app/ui/controller/login_controller.dart';
import 'package:task_manager_app/ui/controller/pin_verify_controller.dart';
import 'package:task_manager_app/ui/controller/set_password_controller.dart';
import 'package:task_manager_app/ui/controller/sign_up_controller.dart';
import 'package:task_manager_app/ui/controller/splash_screen_time_out_controller.dart';
import 'package:task_manager_app/ui/controller/update_profile_controller.dart';
import 'package:task_manager_app/ui/screens/splash_screen.dart';

class TaskManagerApp extends StatelessWidget {
  const TaskManagerApp({super.key});

  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      navigatorKey: navigatorKey,
      home: const SplashScreen(),
      title: "Task Manager",
      debugShowCheckedModeBanner: false,
      initialBinding: ControllerBinder(),
      theme: ThemeData(
          textTheme: const TextTheme(
              bodyLarge: TextStyle(
                fontFamily: 'poppins',
                fontWeight: FontWeight.w700,
                fontSize: 26,
              ),
              bodyMedium: TextStyle(
                fontFamily: 'poppins',
                fontWeight: FontWeight.w600,
                fontSize: 18,
              ),
              titleLarge: TextStyle(
                fontFamily: 'poppins',
                fontWeight: FontWeight.w700,
                fontSize: 15,
                color: Colors.white,
              ),
              titleSmall: TextStyle(
                fontFamily: 'poppins',
                fontWeight: FontWeight.normal,
                fontSize: 12,
                color: Colors.white,
              )),
          inputDecorationTheme: InputDecorationTheme(
            filled: true,
            fillColor: Colors.white,
            hintStyle: Theme.of(context).textTheme.bodySmall,
            border: const OutlineInputBorder(borderSide: BorderSide.none),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 14),
              backgroundColor: const Color(0xFF21bf73),
              foregroundColor: Colors.white,
            ),
          )),
    );
  }
}

class ControllerBinder extends Bindings {
  @override
  void dependencies() {
    Get.put(LoginController());
    Get.put(GetTaskListController());
    Get.put(GetTaskStatusCountController());
    Get.put(SplashScreenTimeOutController());
    Get.put(ForgetPasswordController());
    Get.put(PinVerifyController());
    Get.put(SetPasswordController());
    Get.put(SignUpController());
    Get.put(CreateNewTaskController());
    Get.put(GetInProgressTaskListController());
    Get.put(GetCompleteTaskListController());
    Get.put(GetCancelTaskListController());
    Get.put(AuthController());
    Get.put(UpdateProfileController());
  }
}
