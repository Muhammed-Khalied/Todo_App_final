// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:todo_app/providers/main_provider.dart';
import 'package:todo_app/providers/task_provider.dart';

import '../../providers/bottom_sheet_provider.dart';
import '../../shared/styles/app_colors.dart';

class TaskForm extends StatelessWidget {
  final TaskModel? task;
  bool initialDateFlag = true;

  TaskForm({super.key, this.task});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => BottomSheetProvider(),
      builder: (context, child) {
        var mainProvider = Provider.of<MainProvider>(context);
        var sheetProvider = Provider.of<BottomSheetProvider>(context);
        var taskProvider = Provider.of<TaskProvider>(context);

        if (task != null) {
          if (initialDateFlag) {
            sheetProvider.setInitialDate(
                DateTime.fromMillisecondsSinceEpoch(task!.date));
            initialDateFlag = false;
          }
        }

        return Form(
          key: sheetProvider.formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  task == null
                      ? AppLocalizations.of(context)!.add_new_task
                      : AppLocalizations.of(context)!.edit_the_task,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: mainProvider.themeMode == ThemeMode.light
                          ? AppColors.black
                          : AppColors.white),
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  style: const TextStyle(color: Colors.black),
                  initialValue: task?.title,
                  validator: (text) {
                    if (text == null || text.isEmpty) {
                      return AppLocalizations.of(context)!.add_new_task;
                    }
                    sheetProvider.title = text;
                    return null;
                  },
                  decoration: InputDecoration(
                    label: Text(AppLocalizations.of(context)!.task_title),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                        borderSide:
                            const BorderSide(color: AppColors.primaryColor)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                        borderSide:
                            const BorderSide(color: AppColors.primaryColor)),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    AppLocalizations.of(context)!.select_date,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: mainProvider.themeMode == ThemeMode.light
                            ? AppColors.black
                            : AppColors.white),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    sheetProvider.selectDate(context);
                  },
                  child: Text(
                    sheetProvider.selectedDate.toString().substring(0, 10),
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                SizedBox(
                    width: MediaQuery.of(context).size.width * .5,
                    child: GestureDetector(
                      onTap: () {
                        if (sheetProvider.formKey.currentState!.validate()) {
                          if (task != null) {
                            TaskModel task = TaskModel(
                                userId: this.task!.userId,
                                id: this.task!.id,
                                date: sheetProvider
                                    .selectedDate.millisecondsSinceEpoch,
                                title: sheetProvider.title,
                                status: false);
                            taskProvider
                                .editTask(task)
                                .then((value) => Navigator.pop(context));
                          } else {
                            sheetProvider.getCurrentUserId();
                            TaskModel task = TaskModel(
                                userId: sheetProvider.currentUserId!,
                                date: sheetProvider
                                    .selectedDate.millisecondsSinceEpoch,
                                title: sheetProvider.title,
                                status: false);
                            taskProvider.addTask(task);
                          }
                        }
                      },
                      child: Container(
                        margin: const EdgeInsets.all(5),
                        padding: const EdgeInsets.all(5),
                        // height: 20,
                        // width: 40,
                        decoration: BoxDecoration(
                            // color: color,
                            borderRadius: BorderRadius.circular(50),
                            border: Border.all(color: Colors.black
                                //  Colors.white60
                                )),
                        child: Center(
                          child: Text(
                            task == null
                                ? AppLocalizations.of(context)!.add
                                : AppLocalizations.of(context)!.edit,
                            style: const TextStyle(
                                fontSize: 16,
                                // color: Colors.white,
                                fontFamily: 'cairo'),
                          ),
                        ),
                      ),
                    )
                    // ElevatedButton(
                    //     onPressed: () {
                    //       if (sheetProvider.formKey.currentState!
                    //           .validate()) {
                    //         if (task != null) {
                    //           TaskModel task = TaskModel(
                    //               userId: this.task!.userId,
                    //               id: this.task!.id,
                    //               date: sheetProvider
                    //                   .selectedDate.millisecondsSinceEpoch,
                    //               title: sheetProvider.title,
                    //               status: false);
                    //           taskProvider
                    //               .editTask(task)
                    //               .then((value) => Navigator.pop(context));
                    //         } else {
                    //           sheetProvider.getCurrentUserId();
                    //           TaskModel task = TaskModel(
                    //               userId: sheetProvider.currentUserId!,
                    //               date: sheetProvider
                    //                   .selectedDate.millisecondsSinceEpoch,
                    //               title: sheetProvider.title,
                    //               status: false);
                    //           taskProvider.addTask(task);
                    //         }
                    //       }
                    //     },
                    //     child: Text(task == null
                    //         ? AppLocalizations.of(context)!.add
                    //         : AppLocalizations.of(context)!.edit)
                    )
              ],
            ),
          ),
        );
      },
    );
  }

  String? convertDate(int? milliseconds) {
    if (milliseconds != null) {
      return DateTime.fromMillisecondsSinceEpoch(milliseconds)
          .toString()
          .substring(0, 10);
    }
    return null;
  }
}
//hjdtgUAdyVZ3indP1lFPEHrQr432