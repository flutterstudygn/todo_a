import 'package:flutter/material.dart';
import 'package:todo/model/todo_item.dart';
import 'package:todo/repository/todo_repository.dart';

class MainPage extends StatelessWidget {
  final TodoRepository _repo;
  MainPage(this._repo);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<TodoItem>>(
        future: _repo.getList(), // getList 호출
        builder: (context, snapshot) {
          // 수신된 item list
          List<TodoItem> itemList = snapshot.data;

          // view
          return Container();
        },
      ),
    );
  }
}
