import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/component/component.dart';
import 'package:todo/component/cubit/cubit.dart';
import 'package:todo/component/cubit/states.dart';

class NewTasks extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TodoCubit,TodoStates>(
      listener: (context,state){},
      builder: (context,state){
        var newTask=TodoCubit.get(context).newTasks;

        return  tasksBuilder(
            tasks: newTask,
            color: Colors.grey,
            icon: Icons.menu,
            text:'No Tasks,Type Some New Tasks');
      },
    ) ;
  }
}
