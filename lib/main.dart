import 'package:flutter/material.dart';
import 'package:todo/repository/todo_repository.dart';

import 'repository/todo_adapter_dummy.dart';
import 'view/page_main.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // create _todoRepository instance (singleton)
  final TodoRepository _todoRepository =
      TodoRepository.getInstance(TodoDummyAdapter());

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MainPage(_todoRepository),
    );
  }
}
