import 'package:flutter/material.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:todo_app/tabs/widgets/task_form.dart';


class EditLayout extends StatelessWidget {
  static const String routeName = "EditLayout";

  const EditLayout({super.key});

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)!.settings.arguments as TaskModel;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "ToDo App",
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ),
      body: TaskForm(task: args),
    );
  }
}
