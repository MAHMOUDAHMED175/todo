
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../component/component.dart';
import '../../component/cubit/cubit.dart';
import '../../component/cubit/states.dart';

class ArchiveTasks extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TodoCubit,TodoStates>(
      listener: (context,state){},
      builder: (context,state){
        var archiveTask=TodoCubit.get(context).archiveTasks;
        return  tasksBuilder(tasks: archiveTask,
        color: Colors.grey,
        icon: Icons.archive_sharp,
            text: 'No Archived Tasks');
      },
    );
  }
}
