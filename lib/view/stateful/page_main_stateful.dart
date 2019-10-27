import 'package:flutter/material.dart';
import 'package:todo/model/todo_item.dart';
import 'package:todo/repository/todo_repository.dart';

import '../todo_list_view.dart';

class MainStatefulPage extends StatefulWidget {
  final TodoRepository _repo;
  MainStatefulPage(this._repo);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainStatefulPage> {
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
                Navigator.of(context).pushNamed('/edit', arguments: item);
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
          Navigator.of(context).pushNamed('/edit');
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
