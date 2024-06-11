import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/providers/home_provider.dart';
import 'package:todo_app/providers/main_provider.dart';
import 'package:todo_app/shared/styles/app_colors.dart';
import 'package:todo_app/tabs/widgets/task_form.dart';

class HomeLayout extends StatelessWidget {
  static const String routeName = "HomeLayout";

  const HomeLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeProvider(),
      builder: (context, child) {
        var mediaQuery = MediaQuery.of(context).size;
        var width = mediaQuery.width;
        var height = mediaQuery.height;
        var mainProvider = Provider.of<MainProvider>(context);
        var homeProvider = Provider.of<HomeProvider>(context);
        return Scaffold(
          extendBody: true,
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              "ToDo",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
          bottomNavigationBar: BottomAppBar(
            height: MediaQuery.of(context).size.height * .13,
            color: mainProvider.themeMode == ThemeMode.light
                ? AppColors.white
                : AppColors.black,
            notchMargin: 8,
            shape: const CircularNotchedRectangle(),
            child: BottomNavigationBar(
              elevation: 0,
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(Icons.list_outlined), label: "Tasks"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.settings), label: "Settings"),
              ],
              currentIndex: homeProvider.index,
              iconSize: 25,
              onTap: (selectedIndex) {
                homeProvider.selectTap(selectedIndex);
              },
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: FloatingActionButton(
            backgroundColor: AppColors.primaryColor,
            onPressed: () {
              showAddTaskBottomSheet(context);
            },
            shape: StadiumBorder(
              side: BorderSide(
                  color: mainProvider.themeMode == ThemeMode.light
                      ? AppColors.white
                      : AppColors.black,
                  width: 3),
            ),
            child: const Icon(
              Icons.add,
              color: AppColors.white,
            ),
          ),
          body: homeProvider.tabs[homeProvider.index],
        );
      },
    );
  }

  void showAddTaskBottomSheet(BuildContext context) {
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(10), topLeft: Radius.circular(10))),
        isScrollControlled: true,
        context: context,
        builder: (context) => Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: TaskForm(),
            ));
  }
}
