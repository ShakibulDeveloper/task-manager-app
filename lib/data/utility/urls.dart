import 'package:task_manager_app/ui/widgets/task_list_card.dart';

class Urls {
  static const String _baseUrl = 'https://task.teamrabbil.com/api/v1';
  static const String registration = '$_baseUrl/registration';
  static const String login = '$_baseUrl/login';
  static const String createNewTask = '$_baseUrl/createTask';
  static const String getTaskList = '$_baseUrl/listTaskByStatus/New';
  static String deleteTask(String taskId) => '$_baseUrl/deleteTask/$taskId';

  static String getProgressTaskList =
      '$_baseUrl/listTaskByStatus/${TaskStatus.Progress.name}';
  static String getCompleteTaskList =
      '$_baseUrl/listTaskByStatus/${TaskStatus.Completed.name}';
  static String getCancelTaskList =
      '$_baseUrl/listTaskByStatus/${TaskStatus.Cancelled.name}';
  static const String getTaskStatusCount = '$_baseUrl/taskStatusCount';
  static String updateTaskStatus(String status, String taskId) =>
      '$_baseUrl/updateTaskStatus/$taskId/$status';

  static const String profileUpdate = '$_baseUrl/profileUpdate';

  static String verifyEmailAddress(String email) =>
      '$_baseUrl/RecoverVerifyEmail/$email';
  static String verifyPinCode(String email, String pin) =>
      '$_baseUrl/RecoverVerifyOTP/$email/$pin';
  static const String setNewPassword = '$_baseUrl/RecoverResetPass';
}
