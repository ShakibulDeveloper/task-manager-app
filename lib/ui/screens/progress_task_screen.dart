import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_app/style/style.dart';
import 'package:task_manager_app/ui/controller/get_in_progress_task_list_controller.dart';
import 'package:task_manager_app/ui/widgets/task_list_card.dart';
import 'package:task_manager_app/ui/widgets/top_profile_summary_card.dart';

class ProgressTaskScreen extends StatefulWidget {
  const ProgressTaskScreen({super.key});

  @override
  State<ProgressTaskScreen> createState() => _ProgressTaskScreenState();
}

class _ProgressTaskScreenState extends State<ProgressTaskScreen> {
  final GetInProgressTaskListController _getInProgressTaskListController =
      Get.find<GetInProgressTaskListController>();

  @override
  void initState() {
    super.initState();
    _getInProgressTaskListController.getTaskList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const TopProfileSummeryCard(),
            Expanded(
              child: GetBuilder<GetInProgressTaskListController>(
                  builder: (getInProgressTaskListController) {
                return Visibility(
                  visible:
                      getInProgressTaskListController.getTaskListInProgress ==
                          false,
                  replacement: Center(
                    child: CircularProgressIndicator(color: PrimaryColor.color),
                  ),
                  child: RefreshIndicator(
                    color: PrimaryColor.color,
                    onRefresh: getInProgressTaskListController.getTaskList,
                    child: ListView.builder(
                      itemCount: getInProgressTaskListController
                              .taskListModel.taskList?.length ??
                          0,
                      itemBuilder: (context, index) {
                        return TaskListCard(
                          statusColor: Colors.purple,
                          task: getInProgressTaskListController
                              .taskListModel.taskList![index],
                          onStatusChangeRefresh: () {
                            getInProgressTaskListController.getTaskList();
                          },
                          taskUpdateStatusInProgress: (inProgress) {},
                        );
                      },
                    ),
                  ),
                );
              }),
            )
          ],
        ),
      ),
    );
  }
}
