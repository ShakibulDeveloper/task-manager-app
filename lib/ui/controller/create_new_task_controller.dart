import 'package:get/get.dart';
import 'package:task_manager_app/data/network_caller/network_caller.dart';
import 'package:task_manager_app/data/network_caller/network_response.dart';
import 'package:task_manager_app/data/utility/urls.dart';
import 'package:task_manager_app/ui/controller/get_task_list_controller.dart';
import 'package:task_manager_app/ui/controller/get_task_status_count_controller.dart';

class CreateNewTaskController extends GetxController {
  bool _taskInProgress = false;
  String _message = '';

  bool get taskInProgress => _taskInProgress;
  String get message => _message;

  Future<bool> createNewTask(String title, String description) async {
    _taskInProgress = true;
    update();

    final NetworkResponse response =
        await NetworkCaller.postRequest(Urls.createNewTask, body: {
      "title": title,
      "description": description,
      "status": "New",
    });

    _taskInProgress = false;
    update();

    if (response.isSuccess) {
      Get.find<GetTaskListController>().getTaskList();
      Get.find<GetTaskStatusCountController>().getTaskStatusCount();
      _message = "New Task Added Successfully!";
      update();
      return true;
    } else {
      _message = "Failed! Please Try Again.";
      update();
    }
    return false;
  }
}
