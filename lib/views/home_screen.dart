import 'package:ecommerce/consts/color_pallete.dart';
import 'package:ecommerce/consts/textfield.dart';
import 'package:ecommerce/controller/auth_controller.dart';
import 'package:ecommerce/controller/task_controller.dart';
import 'package:ecommerce/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GlobalKey<FormState> formKey = GlobalKey();

  @override
  void initState() {
    TaskController().fetchTask();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.add,
            size: 25.sp,
            color: AppColors.PurpuleColor,
          ),
          onPressed: () {
            TextEditingController titlefield = TextEditingController();
            TextEditingController subtitlefield = TextEditingController();

            showModalBottomSheet(
                isScrollControlled: true,
                context: appContext,
                builder: (context) => Container(
                      padding: EdgeInsets.symmetric(
                          vertical: 20.h, horizontal: 16.w),
                      width: double.infinity,
                      child: Form(
                        key: formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Add New Task",
                              style: Theme.of(context).textTheme.headlineLarge,
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            customTextFiled(
                              required: true,
                              controller: titlefield,
                              hinttext: "Title",
                            ),
                            SizedBox(
                              height: 15.h,
                            ),
                            customTextFiled(
                                required: true,
                                controller: subtitlefield,
                                hinttext: "Sub Title"),
                            SizedBox(
                              height: 25.h,
                            ),
                            SizedBox(
                              height: 45.h,
                              width: double.infinity,
                              child: FilledButton(
                                  onPressed: () {
                                    if (formKey.currentState!.validate()) {
                                      TaskController().addTask(
                                          title: titlefield.text,
                                          subtitle: subtitlefield.text);
                                      GoRouter.of(context).pop();
                                    }
                                  },
                                  child: Text("Add Task")),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  bottom:
                                      MediaQuery.of(context).viewInsets.bottom),
                            )
                          ],
                        ),
                      ),
                    ));
          }),
      appBar: AppBar(
        title: Text("TODO"),
        actions: [
          IconButton(
              onPressed: () {
                AuthController().signOut();
              },
              icon: Icon(Icons.logout))
        ],
      ),
      body: Container(
        width: double.infinity,
        child: Consumer<TaskController>(
          builder: (context, controller, _) {
            return ListView.builder(
              itemCount: controller.tasks.length,
              itemBuilder: (context, index) => ListTile(
                title: Text(TaskController().tasks[index]["title"]),
                subtitle: Text(TaskController().tasks[index]["subtitle"]),
                trailing: Checkbox(
                    value: controller.tasks[index]["completed"],
                    onChanged: (value) {}),
              ),
            );
          },
        ),
      ),
    );
  }
}
