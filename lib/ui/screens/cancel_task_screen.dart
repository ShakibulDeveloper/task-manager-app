import 'package:flutter/material.dart';
import 'package:task_manager_app/ui/widgets/task_list_card.dart';
import 'package:task_manager_app/ui/widgets/top_profile_summary_card.dart';

class CancelTaskScreen extends StatefulWidget {
  const CancelTaskScreen({super.key});

  @override
  State<CancelTaskScreen> createState() => _CancelTaskScreenState();
}

class _CancelTaskScreenState extends State<CancelTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const TopProfileSummeryCard(),
            Expanded(
              child: ListView.builder(
                itemCount: 8,
                itemBuilder: (context, index) {
                  return const TaskListCard();
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
