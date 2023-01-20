import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:todo/layout/Todo_layout.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'component/observer.dart';

void main() {
  Bloc.observer = MyBlocObserver();

  runApp(Todo());
}
class Todo extends StatefulWidget {

  @override
  State<Todo> createState() => _TodoState();
}

class _TodoState extends State<Todo> {


  @override
  void initState() {
    super.initState();
    initialization();
    // Enable virtual display.
  }
  void initialization() async {
    // This is where you can initialize the resources needed by your app while
    // the splash screen is displayed.  Remove the following example because
    // delaying the user experience is a bad design practice!
    // ignore_for_file: avoid_print
    print('ready in 3...');
    await Future.delayed(const Duration(seconds: 1));
    print('ready in 2...');
    await Future.delayed(const Duration(seconds: 8));
    print('ready in 1...');
    await Future.delayed(const Duration(seconds: 5));
    print('go!');
    FlutterNativeSplash.remove();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:TodoLayout() ,
    );
  }
}
