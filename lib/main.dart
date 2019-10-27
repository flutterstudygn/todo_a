import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/repository/todo_adapter.dart';
import 'package:todo/repository/todo_adapter_db.dart';
import 'package:todo/repository/todo_repository.dart';
import 'package:todo/view/stateful/page_main_stateful.dart';

import 'model/todo_item.dart';
import 'repository/todo_state.dart';
import 'view/page_edit.dart';
import 'view/page_main.dart';
import 'view/stateful/page_edit_stateful.dart';

void main() async {
  // create _todoRepository instance (singleton)
  TodoAdapter adapter = await TodoDbAdapter().init();
  TodoRepository repo = TodoRepository.getInstance(adapter);

  runApp(MyApp(repo));
}

class MyApp extends StatelessWidget {
  final int _key = 1;

  final TodoRepository _todoRepository;
  MyApp(this._todoRepository);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TodoState>(
      builder: (_) {
        TodoState _state = TodoState(_todoRepository);
        _state.getList();
        return _state;
      },
      child: MaterialApp(
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
        initialRoute: '/',
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case '/':
              return MaterialPageRoute(builder: (context) {
                return _mainPage();
              });
            case '/edit':
              return MaterialPageRoute(builder: (context) {
                return _editPage(settings.arguments as TodoItem);
              });
          }
          return null;
        },
      ),
    );
  }

  Widget _mainPage() {
    switch (_key) {
      case 1:
        return MainNotifierPage();
    }
    return MainStatefulPage(_todoRepository);
  }

  Widget _editPage(TodoItem item) {
    switch (_key) {
      case 1:
        return EditNotifierPage(item: item);
    }
    return EditStatefulPage(_todoRepository, item: item);
  }
}
