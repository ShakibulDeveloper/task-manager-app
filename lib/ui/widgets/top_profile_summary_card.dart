import 'package:flutter/material.dart';
import 'package:task_manager_app/style/style.dart';
import 'package:task_manager_app/ui/screens/update_profile_screen.dart';

class TopProfileSummeryCard extends StatelessWidget {
  final bool onTapStatus;

  const TopProfileSummeryCard({
    super.key,
    this.onTapStatus = true,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        if (onTapStatus == true) {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const UpdateProfileScreen()),
          );
        }
      },
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
      trailing: onTapStatus ? const Icon(Icons.arrow_right) : null,
      tileColor: PrimaryColor.color,
    );
  }
}
