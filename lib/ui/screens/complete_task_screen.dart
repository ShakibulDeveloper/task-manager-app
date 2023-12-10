import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_app/style/style.dart';
import 'package:task_manager_app/ui/controller/get_complete_task_list_controller.dart';
import 'package:task_manager_app/ui/widgets/task_list_card.dart';
import 'package:task_manager_app/ui/widgets/top_profile_summary_card.dart';

class CompleteTaskScreen extends StatefulWidget {
  const CompleteTaskScreen({super.key});

  @override
  State<CompleteTaskScreen> createState() => _CompleteTaskScreenState();
}

class _CompleteTaskScreenState extends State<CompleteTaskScreen> {
  final GetCompleteTaskListController _getCompleteTaskListController =
      Get.find<GetCompleteTaskListController>();

  @override
  void initState() {
    super.initState();
    _getCompleteTaskListController.getTaskList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const TopProfileSummeryCard(),
            Expanded(
              child: GetBuilder<GetCompleteTaskListController>(
                  builder: (getCompleteTaskListController) {
                return Visibility(
                  visible:
                      getCompleteTaskListController.getTaskListInProgress ==
                          false,
                  replacement: Center(
                    child: CircularProgressIndicator(color: PrimaryColor.color),
                  ),
                  child: RefreshIndicator(
                    color: PrimaryColor.color,
                    onRefresh: getCompleteTaskListController.getTaskList,
                    child: ListView.builder(
                      itemCount: getCompleteTaskListController
                              .taskListModel.taskList?.length ??
                          0,
                      itemBuilder: (context, index) {
                        return TaskListCard(
                          statusColor: PrimaryColor.color,
                          task: getCompleteTaskListController
                              .taskListModel.taskList![index],
                          onStatusChangeRefresh: () {
                            getCompleteTaskListController.getTaskList();
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
