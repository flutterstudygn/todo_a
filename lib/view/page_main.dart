import 'package:flutter/material.dart';
import 'package:todo/model/todo_item.dart';
import 'package:todo/repository/todo_repository.dart';

import 'todo_list_view.dart';

class MainPage extends StatefulWidget {
  final TodoRepository _repo;
  MainPage(this._repo);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.grey.shade300,
        child: FutureBuilder<List<TodoItem>>(
          future: widget._repo.getList(), // getList 호출
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text('Error'));
            }
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }

            // 수신된 item list
            List<TodoItem> itemList = snapshot.data;
            // view
            return TodoListView(
              itemList,
              onTap: (TodoItem item) async {
                await widget._repo.update(item..isComplete = true);
                setState(() {});
              },
              onLongPress: (TodoItem item) async {
                await widget._repo.delete(item.id);
                setState(() {});
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          String randomTodo = _randomTodo[
              DateTime.now().millisecondsSinceEpoch % _randomTodo.length];
          await widget._repo.create(TodoItem.create(randomTodo));
          setState(() {});
        },
        child: Icon(Icons.add),
      ),
    );
  }

  List<String> _randomTodo = ['대청소', '빨래', '설거지', '생일 선물 사기', '택배 보내기'];
}
