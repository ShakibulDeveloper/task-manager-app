import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_app/style/style.dart';
import 'package:task_manager_app/ui/controller/get_cancel_task_list_controller.dart';
import 'package:task_manager_app/ui/widgets/task_list_card.dart';
import 'package:task_manager_app/ui/widgets/top_profile_summary_card.dart';

class CancelTaskScreen extends StatefulWidget {
  const CancelTaskScreen({super.key});

  @override
  State<CancelTaskScreen> createState() => _CancelTaskScreenState();
}

class _CancelTaskScreenState extends State<CancelTaskScreen> {
  final GetCancelTaskListController _getCancelTaskListController =
      Get.find<GetCancelTaskListController>();

  @override
  void initState() {
    super.initState();
    _getCancelTaskListController.getTaskList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const TopProfileSummeryCard(),
            Expanded(
              child: GetBuilder<GetCancelTaskListController>(
                  builder: (getCancelTaskListController) {
                return Visibility(
                  visible: getCancelTaskListController.getTaskListInProgress ==
                      false,
                  replacement: Center(
                    child: CircularProgressIndicator(color: PrimaryColor.color),
                  ),
                  child: RefreshIndicator(
                    color: PrimaryColor.color,
                    onRefresh: getCancelTaskListController.getTaskList,
                    child: ListView.builder(
                      itemCount: getCancelTaskListController
                              .taskListModel.taskList?.length ??
                          0,
                      itemBuilder: (context, index) {
                        return TaskListCard(
                          statusColor: Colors.redAccent,
                          task: getCancelTaskListController
                              .taskListModel.taskList![index],
                          onStatusChangeRefresh: () {
                            getCancelTaskListController.getTaskList();
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
