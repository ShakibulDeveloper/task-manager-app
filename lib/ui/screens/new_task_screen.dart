import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_app/data/models/task_count.dart';
import 'package:task_manager_app/style/style.dart';
import 'package:task_manager_app/ui/controller/get_task_list_controller.dart';
import 'package:task_manager_app/ui/controller/get_task_status_count_controller.dart';
import 'package:task_manager_app/ui/screens/add_new_task_screen.dart';
import 'package:task_manager_app/ui/widgets/summary_card.dart';
import 'package:task_manager_app/ui/widgets/task_list_card.dart';
import 'package:task_manager_app/ui/widgets/top_profile_summary_card.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  final GetTaskListController _getTaskListController =
      Get.find<GetTaskListController>();
  final GetTaskStatusCountController _getTaskStatusCountController =
      Get.find<GetTaskStatusCountController>();

  @override
  void initState() {
    super.initState();
    _getTaskStatusCountController.getTaskStatusCount();
    _getTaskListController.getTaskList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const TopProfileSummeryCard(),
            GetBuilder<GetTaskStatusCountController>(
                builder: (getTaskStatusCountController) {
              return Visibility(
                visible:
                    getTaskStatusCountController.getTaskStatusCountInProgress ==
                            false &&
                        (getTaskStatusCountController.taskListStatusCountModel
                                .taskCountList?.isNotEmpty ??
                            false),
                replacement: LinearProgressIndicator(
                  color: PrimaryColor.color,
                  backgroundColor: Colors.grey,
                ),
                child: SizedBox(
                  height: 100,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: getTaskStatusCountController
                            .taskListStatusCountModel.taskCountList?.length ??
                        0,
                    itemBuilder: (context, index) {
                      TaskCount taskCount = getTaskStatusCountController
                          .taskListStatusCountModel.taskCountList![index];
                      return FittedBox(
                        child: SummaryCard(
                          summaryCount: taskCount.sum.toString(),
                          summaryTitle: taskCount.sId ?? '',
                        ),
                      );
                    },
                  ),
                ),
              );
            }),
            Expanded(
              child: GetBuilder<GetTaskListController>(
                  builder: (getTaskListController) {
                return Visibility(
                  visible: getTaskListController.getTaskListInProgress == false,
                  replacement: Center(
                    child: CircularProgressIndicator(color: PrimaryColor.color),
                  ),
                  child: RefreshIndicator(
                    color: PrimaryColor.color,
                    onRefresh: getTaskListController.getTaskList,
                    child: ListView.builder(
                      itemCount: getTaskListController
                              .taskListModel.taskList?.length ??
                          0,
                      itemBuilder: (context, index) {
                        return TaskListCard(
                          task: getTaskListController
                              .taskListModel.taskList![index],
                          onStatusChangeRefresh: () {
                            getTaskListController.getTaskList();
                            _getTaskStatusCountController.getTaskStatusCount();
                          },
                          taskUpdateStatusInProgress: (inProgress) {},
                        );
                      },
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(const AddNewTaskScreen());
        },
        backgroundColor: PrimaryColor.color,
        child: const Icon(Icons.add),
      ),
    );
  }
}
