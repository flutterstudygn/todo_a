import 'package:flutter/material.dart';
import 'package:todo/repository/todo_adapter.dart';
import 'package:todo/repository/todo_adapter_db.dart';
import 'package:todo/repository/todo_repository.dart';

import 'view/page_main.dart';

void main() async {
  // create _todoRepository instance (singleton)
  TodoAdapter adapter = await TodoDbAdapter().init();
  TodoRepository repo = TodoRepository.getInstance(adapter);

  runApp(MyApp(repo));
}

class MyApp extends StatelessWidget {
  final TodoRepository _todoRepository;
  MyApp(this._todoRepository);

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
