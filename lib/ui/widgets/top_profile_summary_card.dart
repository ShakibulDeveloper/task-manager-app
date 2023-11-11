import 'package:flutter/material.dart';
import 'package:task_manager_app/style/style.dart';

class TopProfileSummeryCard extends StatelessWidget {
  const TopProfileSummeryCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const CircleAvatar(
        backgroundColor: Colors.lightGreen,
      ),
      title: Text(
        "User",
        style: Theme.of(context).textTheme.titleLarge,
      ),
      subtitle: Text(
        "user@gmail.com",
        style: Theme.of(context).textTheme.titleSmall,
      ),
      trailing: const Icon(Icons.arrow_right),
      tileColor: PrimaryColor.color,
    );
  }
}
