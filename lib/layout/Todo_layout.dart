import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo/component/component.dart';
import 'package:todo/component/cubit/cubit.dart';
import 'package:todo/component/cubit/states.dart';
class TodoLayout extends StatelessWidget {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();
  var titleController = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => TodoCubit()..CreateDatabase(),
      child: BlocConsumer<TodoCubit, TodoStates>(
        listener: (context, state) {
          if(state is TodoInsertDatabaseState)
            {
              Navigator.pop(context);
            }
        },
        builder: (context, state) {
          TodoCubit cubit = TodoCubit.get(context);

          return Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
              title: Text(
                cubit.title[cubit.currentIndex],
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                if (cubit.isShowenBottwonSheet) {
                   if (formKey.currentState!.validate())
                  {
                    cubit.InsertDatabase(
                      title: titleController.text,
                      time: timeController.text,
                      date: dateController.text,
                    );
                  }
                }else
                  {
                    scaffoldKey.currentState!
                        .showBottomSheet(
                          (context) =>
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.08),
                                borderRadius: BorderRadius.circular(50.0)
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Form(
                                key: formKey,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    defualtFormText(

                                      type: TextInputType.text,
                                      controller: titleController,
                                      validate: (String value) {
                                        if (value.isEmpty) {
                                          return "type the title";
                                        }
                                      },
                                      onSubmit: (String? value) {
                                        if (formKey.currentState!.validate()) {}
                                      },
                                      label: "title",
                                      preffixIcon: Icons.title,
                                    ),
                                    SizedBox(
                                      height: 10.0,
                                    ),
                                    defualtFormText(
                                      type: TextInputType.datetime,
                                      controller: timeController,
                                      onTap: () {
                                        showTimePicker(
                                          context: context,
                                          initialTime: TimeOfDay.now(),
                                        ).then((value) {
                                          timeController.text =
                                              value!.format(context).toString();
                                          print(value.format(context));
                                        });
                                      },
                                      onSubmit: (String value) {
                                        if (formKey.currentState!.validate());
                                      },
                                      validate: (String value) {
                                        if (value.isEmpty) {
                                          return "type the time";
                                        }
                                      },
                                      label: "time",
                                      preffixIcon: Icons
                                          .access_time_filled_sharp,
                                    ), SizedBox(
                                      height: 10.0,
                                    ),
                                    defualtFormText(
                                      type: TextInputType.datetime,
                                      controller: dateController,
                                      onTap: () {
                                        showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime.now(),
                                          lastDate: DateTime.parse(
                                              "2230-12-12"),
                                        ).then((value) {
                                          dateController.text =
                                              DateFormat.yMMMMEEEEd().format(value!);
                                        });
                                      },
                                      onSubmit: (String value) {
                                        if (formKey.currentState!.validate());
                                      },
                                      validate: (String value) {
                                        if (value.isEmpty) {
                                          return "type the date";
                                        }
                                      },
                                      label: "date",
                                      preffixIcon: Icons.date_range,
                                    ),

                                  ],
                                ),
                              ),
                            ),
                          ),
                      elevation: 80.0,
                    )
                        .closed
                        .then((value) {
                      cubit.ChangeBottomSheet(isShwon: false, icon: Icons.edit);
                    });
                    cubit.ChangeBottomSheet(
                        isShwon: true, icon: Icons.add_circle);
                  }

              },
              backgroundColor: Colors.black,
              child: Icon(cubit.fabIcon,),
            ),
            bottomNavigationBar: CurvedNavigationBar(
              index: cubit.currentIndex,
              onTap: (index) {
                cubit.ChangeIndex(index);
                // TodoCubit.get(context).ChangeIndex(index);
              },
              color: Colors.blue,
              height: 60,
              animationDuration: const Duration(
                milliseconds: 300,
              ),
              buttonBackgroundColor: Colors.black.withOpacity(0.8),
              animationCurve: Curves.linearToEaseOut,
              backgroundColor: Colors.white.withOpacity(0.7),
              items: const [
                Icon(Icons.add_circle, color: Colors.white,),
                Icon(Icons.check_circle_sharp, color: Colors.white,),
                Icon(Icons.archive, color: Colors.white,),
              ],
            ),
            body: ConditionalBuilder(
              condition: state is! TodoGetDatabaseLoadingState,
              builder: (context) => cubit.screen[cubit.currentIndex],
              fallback: (context) => const Center(child: CircularProgressIndicator()),
            ),
          );
        },

      ),
    );
  }
}
