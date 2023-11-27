import 'package:flutter/material.dart';
import 'package:task_manager_app/data/models/task.dart';

class TaskListCard extends StatelessWidget {
  final Task task;

  const TaskListCard({
    super.key,
    required this.task,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: ListTile(
          title: Text(
            task.title ?? '',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                task.description ?? '',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              Text(
                'Date: ${task.createdDate}',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Chip(
                    label: Text(
                      task.status ?? 'New',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    backgroundColor: Colors.lightBlue,
                    labelPadding: const EdgeInsets.symmetric(
                      vertical: 0,
                      horizontal: 8,
                    ),
                  ),
                  Wrap(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.edit),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.delete),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
