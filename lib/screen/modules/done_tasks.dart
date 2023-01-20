
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../component/component.dart';
import '../../component/cubit/cubit.dart';
import '../../component/cubit/states.dart';

class DoneTasks extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TodoCubit,TodoStates>(
      listener: (context,state){},
      builder: (context,state){
        var doneTask=TodoCubit.get(context).doneTasks;

        return tasksBuilder(tasks: doneTask,
            color: Colors.green,
            icon: Icons.check_circle,
            text: 'No Completed Tasks');
      },
    ) ;
  }
}
