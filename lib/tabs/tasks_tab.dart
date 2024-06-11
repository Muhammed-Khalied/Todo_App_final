import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/providers/main_provider.dart';
import 'package:todo_app/tabs/widgets/task_item.dart';
import 'package:todo_app/shared/styles/app_colors.dart';
import 'package:todo_app/providers/task_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TasksTab extends StatelessWidget {
  const TasksTab({super.key});

  @override
  Widget build(BuildContext context) {
    var mainProvider = Provider.of<MainProvider>(context);
    var taskProvider = Provider.of<TaskProvider>(context);
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Column(
        children: [
          CalendarTimeline(
            initialDate: taskProvider.selectedDate,
            firstDate: DateTime(2024, 1, 1),
            lastDate: DateTime(2024, 12, 30),
            onDateSelected: (date) {
              taskProvider.selectDate(date);
            },
            leftMargin: 20,
            monthColor: AppColors.primaryColor,
            dayColor: AppColors.primaryColor,
            activeDayColor: Colors.white,
            activeBackgroundDayColor: AppColors.primaryColor,
            selectableDayPredicate: (date) {
              return !taskProvider.holidays.contains(date);
            },
            locale: mainProvider.locale.countryCode,
          ),
          StreamBuilder(
            stream: taskProvider.getTasksSnapShot(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Expanded(
                    child: Center(child: CircularProgressIndicator()));
              }
              if (snapshot.hasError) {
                return Expanded(
                    child: Center(
                        child: Text(
                  AppLocalizations.of(context)!.wrong,
                  style: Theme.of(context).textTheme.bodyMedium,
                )));
              }
              taskProvider.getTasks(snapshot);
              if (taskProvider.tasks.isEmpty) {
                return Expanded(
                    child: Center(
                        child: Text(
                  AppLocalizations.of(context)!.no_data,
                  style: Theme.of(context).textTheme.bodyMedium,
                )));
              }
              return Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return TaskItem(taskProvider.tasks[index]);
                  },
                  itemCount: taskProvider.tasks.length,
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
