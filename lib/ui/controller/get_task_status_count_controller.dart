import 'package:get/get.dart';
import 'package:task_manager_app/data/models/task_list_status_count_model.dart';
import 'package:task_manager_app/data/network_caller/network_caller.dart';
import 'package:task_manager_app/data/network_caller/network_response.dart';
import 'package:task_manager_app/data/utility/urls.dart';

class GetTaskStatusCountController extends GetxController {
  bool _getTaskStatusCountInProgress = false;
  TaskListStatusCountModel _taskListStatusCountModel =
      TaskListStatusCountModel();

  bool get getTaskStatusCountInProgress => _getTaskStatusCountInProgress;
  TaskListStatusCountModel get taskListStatusCountModel =>
      _taskListStatusCountModel;

  Future<bool> getTaskStatusCount() async {
    bool isSuccess = false;
    _getTaskStatusCountInProgress = true;
    update();

    NetworkResponse response = await NetworkCaller.getRequest(
      Urls.getTaskStatusCount,
    );
    _getTaskStatusCountInProgress = false;
    if (response.isSuccess) {
      _taskListStatusCountModel = TaskListStatusCountModel.fromJson(
        response.jsonResponse,
      );
      isSuccess = true;
    }
    update();
    return isSuccess;
  }
}
