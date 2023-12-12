import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_app/style/style.dart';
import 'package:task_manager_app/ui/controller/create_new_task_controller.dart';
import 'package:task_manager_app/ui/controller/input_validations.dart';
import 'package:task_manager_app/ui/widgets/background_image.dart';
import 'package:task_manager_app/ui/widgets/snack_bar.dart';
import 'package:task_manager_app/ui/widgets/top_profile_summary_card.dart';

class AddNewTaskScreen extends StatefulWidget {
  const AddNewTaskScreen({super.key});

  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {
  final TextEditingController _subjectInputTEController =
      TextEditingController();
  final TextEditingController _descriptionInputTEController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final CreateNewTaskController _createNewTaskController =
      Get.find<CreateNewTaskController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const TopProfileSummeryCard(),
            Expanded(
              child: WithBackGroundImage(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 40,
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Add New Task",
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          const SizedBox(height: 8),
                          TextFormField(
                            controller: _subjectInputTEController,
                            decoration: const InputDecoration(
                              hintText: "Subject",
                            ),
                            style: Theme.of(context).textTheme.bodyMedium,
                            validator: FormValidation.inputValidation,
                          ),
                          const SizedBox(height: 8),
                          TextFormField(
                            controller: _descriptionInputTEController,
                            maxLines: 5,
                            decoration:
                                const InputDecoration(hintText: "Description"),
                            style: Theme.of(context).textTheme.bodyMedium,
                            validator: FormValidation.inputValidation,
                          ),
                          const SizedBox(height: 8),
                          SizedBox(
                            width: double.infinity,
                            child: GetBuilder<CreateNewTaskController>(
                                builder: (createNewTaskController) {
                              return Visibility(
                                visible:
                                    createNewTaskController.taskInProgress ==
                                        false,
                                replacement: Center(
                                  child: CircularProgressIndicator(
                                      color: PrimaryColor.color),
                                ),
                                child: ElevatedButton(
                                  onPressed: _createNewTask,
                                  child: const Icon(
                                      Icons.arrow_circle_right_outlined),
                                ),
                              );
                            }),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _createNewTask() async {
    if (_formKey.currentState!.validate()) {
      final response = await _createNewTaskController.createNewTask(
        _subjectInputTEController.text.trim(),
        _descriptionInputTEController.text.trim(),
      );

      if (response) {
        _subjectInputTEController.clear();
        _descriptionInputTEController.clear();
        if (mounted) {
          showSnackBar(context, _createNewTaskController.message);
        }
      } else {
        if (mounted) {
          showSnackBar(context, _createNewTaskController.message, true);
        }
      }
    }
  }

  @override
  void dispose() {
    _subjectInputTEController.dispose();
    _descriptionInputTEController.dispose();
    super.dispose();
  }
}
