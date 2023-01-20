
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:todo/component/cubit/cubit.dart';

Widget defualtFormText(
{
  required TextInputType type,
  required TextEditingController controller,
  Function? onTap,
  required Function validate,
  required String label,
  required IconData preffixIcon,
  Function? onSubmit,
}) =>TextFormField(


  onFieldSubmitted:(s){
    onSubmit!();
  } ,
  keyboardType: type,
  controller: controller,
  onTap:(){
    onTap!();
  } ,
  validator:(value){
    validate(value);
  } ,
  decoration:  InputDecoration(

      border: OutlineInputBorder(),

      labelText: label,
      prefixIcon: Icon(preffixIcon,)

  ),
  //textDirection:  TextDirection.rtl,
);

Widget buildItem(Map model, context)=>Dismissible(
  key:Key(model['id'].toString()),
  onDismissed:(directions){
    TodoCubit.get(context).DeleteData(model['id']);
  },
  child:Padding(
    padding: const EdgeInsets.all(10.0),
    child: Row(
      children: [
        CircleAvatar(

          radius: 40.5,

          child: Text("${model['time']}"),

        ),
        SizedBox(

          width:12.5,

        ),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,

            //crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Text("${model['title']}",
                  maxLines: 2,
                  textWidthBasis: TextWidthBasis.longestLine,
                  style:TextStyle(
                    fontSize: 18.0,
                    overflow: TextOverflow.ellipsis,
                    color: Colors.black,
                  )
              ),
              Text("${model['date']}",

                  style:TextStyle(

                    color: Colors.grey,

                  )

              ),

            ],

          ),
        ),
        SizedBox(

          width:5.5,

        ),
        IconButton(

          onPressed:(){

            TodoCubit.get(context).updateData('done',model['id']);

          },

          icon:Icon(Icons.check_box,
            size: 20.0,
            color:Colors.green,

          ),

        ),
        SizedBox(

          width:3.0,

        ),
        IconButton(

          onPressed:(){

            TodoCubit.get(context).updateData('archived',model['id']);

          },

          icon:Icon(
            Icons.archive_sharp,

            size: 20,
            color: Colors.black.withOpacity(0.8),),

        ),
      ],

    ),

  ),
);

Widget tasksBuilder(
{
  required String text,
  required IconData icon,
  required Color color,
 required List<Map> tasks,
})=>ConditionalBuilder(
  condition: tasks.length>0,
  builder: (context)=>ListView.separated(
    itemBuilder:(context,index)=>buildItem(tasks[index],context),
    separatorBuilder: (context,index)=>Padding(
      padding: const EdgeInsets.only(left: 20.0),
      child: Container(
        height: 1.0,
        color: Colors.grey,

      ),
    ),
    itemCount:tasks.length,
  ),
  fallback: (context)=>Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children:  [
        Icon(
          icon,
          color:color,
          size: 50.0,
        ),
        Text(
        text,
          style: TextStyle(
              fontSize: 20
          ),
        ),
      ],
    ),
  ),
);