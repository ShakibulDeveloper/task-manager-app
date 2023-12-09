import 'package:get/get.dart';
import 'package:task_manager_app/data/models/task_list_model.dart';
import 'package:task_manager_app/data/network_caller/network_caller.dart';
import 'package:task_manager_app/data/network_caller/network_response.dart';
import 'package:task_manager_app/data/utility/urls.dart';

class GetTaskListController extends GetxController {
  bool _getTaskListInProgress = false;
  TaskListModel _taskListModel = TaskListModel();

  bool get getTaskListInProgress => _getTaskListInProgress;
  TaskListModel get taskListModel => _taskListModel;

  Future<bool> getTaskList() async {
    bool isSuccess = false;
    _getTaskListInProgress = true;
    update();

    NetworkResponse response = await NetworkCaller.getRequest(Urls.getTaskList);
    _getTaskListInProgress = false;
    if (response.isSuccess) {
      _taskListModel = TaskListModel.fromJson(response.jsonResponse);
      isSuccess = true;
    }
    update();
    return isSuccess;
  }
}
