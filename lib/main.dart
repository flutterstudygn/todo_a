import 'package:bloc_provider/bloc_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/repository/todo_adapter.dart';
import 'package:todo/repository/todo_adapter_db.dart';
import 'package:todo/repository/todo_repository.dart';
import 'package:todo/view/stateful/page_main_stateful.dart';

import 'model/todo_bloc.dart';
import 'model/todo_item.dart';
import 'repository/todo_state.dart';
import 'view/bloc/page_edit_bloc.dart';
import 'view/bloc/page_main_bloc.dart';
import 'view/change_notifier/page_edit_notifier.dart';
import 'view/change_notifier/page_main_notifier.dart';
import 'view/stateful/page_edit_stateful.dart';

void main() async {
  // create _todoRepository instance (singleton)
  TodoAdapter adapter = await TodoDbAdapter().init();
  TodoRepository repo = TodoRepository.getInstance(adapter);

  runApp(MyAppBloc(repo));
}

class MyAppBloc extends StatelessWidget {
  final TodoRepository _todoRepository;
  MyAppBloc(this._todoRepository);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TodoBloc>(
      creator: (_, __) => TodoBloc(_todoRepository),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/',
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case '/':
              return MaterialPageRoute(builder: (context) {
                return MainBlocPage();
              });
            case '/edit':
              return MaterialPageRoute(builder: (context) {
                return EditBlocPage(item: settings.arguments as TodoItem);
              });
          }
          return null;
        },
      ),
    );
  }
}

class MyAppProvider extends StatelessWidget {
  final TodoRepository _todoRepository;
  MyAppProvider(this._todoRepository);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TodoState>(
      builder: (_) => TodoState(_todoRepository),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/',
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case '/':
              return MaterialPageRoute(builder: (context) {
                return MainNotifierPage();
              });
            case '/edit':
              return MaterialPageRoute(builder: (context) {
                return EditNotifierPage(item: settings.arguments as TodoItem);
              });
          }
          return null;
        },
      ),
    );
  }
}

class MyAppStateful extends StatelessWidget {
  final TodoRepository _todoRepository;
  MyAppStateful(this._todoRepository);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/':
            return MaterialPageRoute(builder: (context) {
              return MainStatefulPage(_todoRepository);
            });
          case '/edit':
            return MaterialPageRoute(builder: (context) {
              return EditStatefulPage(_todoRepository,
                  item: settings.arguments as TodoItem);
            });
        }
        return null;
      },
    );
  }
}
