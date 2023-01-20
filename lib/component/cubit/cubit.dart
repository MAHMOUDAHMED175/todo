

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo/component/cubit/states.dart';

import '../../screen/modules/archived_tasks.dart';
import '../../screen/modules/done_tasks.dart';
import '../../screen/modules/new_tasks.dart';
class TodoCubit extends Cubit<TodoStates>{
  TodoCubit():super(TodoInitialState());
  static TodoCubit get(context)=> BlocProvider.of(context);

  int currentIndex=0;

  List<String> title=[
    'New Tasks',
    'Done Tasks',
    'Archived Tasks',
  ];
  List<Widget> screen=[
    NewTasks(),
    DoneTasks(),
    ArchiveTasks(),
  ];

  void ChangeIndex(index){
    currentIndex=index;
    emit(TodoChangeCurvedNavBarState());

  }

  bool isShowenBottwonSheet=false;
  IconData fabIcon=Icons.edit;

  void ChangeBottomSheet(
      {
        required bool isShwon,
        required IconData icon,
      }){
    isShowenBottwonSheet=isShwon;
    fabIcon=icon;
    emit(TodoChangeBottomSheetState());
  }

  late Database database;
  List<Map> newTasks=[];
  List<Map> doneTasks=[];
  List<Map> archiveTasks=[];



  void CreateDatabase() {
    openDatabase(
      'someTasks.db',
      version: 1,
      onCreate: (database, version) {
        print("congratulation database is created");
        database.execute(
            'CREATE TABLE newTasks(id INTEGER PRIMARY KEY,title TEXT,date TEXT,time TEXT,status TEXT)'
        ).then((value) {
          print('table is created');
        }).catchError((error) {
          print('errror when create table');
        });
      },
      onOpen: (database) {
        getDatabase(database);
        print("congratulation database is opend");
      },
    ).then((value) {
      database = value;
      emit(TodoCreateDatabaseState());
    });
  }

  Future InsertDatabase({
    required String title,
    required String time,
    required String date,
  }) async {
    return await database.transaction((txn) {
      return txn.rawInsert(
          'INSERT INTO newTasks(title,time,date,status)VALUES("$title","$time","$date","new")'
      ).then((value) {
        emit(TodoInsertDatabaseState());
        print("values inserted successfully");
        getDatabase(database);

      }).catchError((error) {
        print("error when inserted database");
      });
    });
  }

  void   getDatabase(database){
    newTasks=[];
        doneTasks=[];
        archiveTasks=[];
    emit(TodoGetDatabaseLoadingState());

    database.rawQuery('SELECT * FROM newTasks').then((value) {
      value.forEach((element){
        if(element['status'] == 'new') {
          newTasks.add(element);
        } else if(element['status'] == 'done') {
          doneTasks.add(element);
        } else {
          archiveTasks.add(element);
        }
        print(element['status']);
      });
      emit(TodoGetDatabaseState());
    });
  }
  void updateData(
      String status,
      int id,
      )async{
    database.rawUpdate('UPDATE newTasks SET status=? WHERE id=?',
      [status,id],
    ).then((value) {
      getDatabase(database);
      emit(TodoUpdateDatabaseState());
    });
  }



  void DeleteData(
      int id,
      )async{
    database.rawDelete('DELETE  FROM newTasks WHERE id=?', [id],).then((value) {
      getDatabase(database);
      emit(TodoDeleteDatabaseState());
    });
  }





}
