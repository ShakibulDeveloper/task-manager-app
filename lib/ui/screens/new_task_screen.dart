import 'package:flutter/material.dart';
import 'package:task_manager_app/style/style.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const TopProfileSummeryCard(),
            const SizedBox(height: 4),
            const SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  SummaryCard(
                    summaryCount: 92,
                    summaryTitle: 'New Task',
                  ),
                  SummaryCard(
                    summaryCount: 92,
                    summaryTitle: 'New Task',
                  ),
                  SummaryCard(
                    summaryCount: 92,
                    summaryTitle: 'New Task',
                  ),
                  SummaryCard(
                    summaryCount: 92,
                    summaryTitle: 'New Task',
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 6,
                itemBuilder: (context, index) {
                  return const TaskListCard();
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddNewTaskScreen(),
            ),
          );
        },
        backgroundColor: PrimaryColor.color,
        child: const Icon(Icons.add),
      ),
    );
  }
}
