import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/model/todo_item.dart';
import 'package:todo/repository/todo_state.dart';

import 'todo_list_view.dart';

class MainNotifierPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer<TodoState>(
          builder: (_, state, __) {
            List<TodoItem> itemList = state.todoList;
            if (itemList?.isNotEmpty != true) {
              return Center(child: CircularProgressIndicator());
            }
            // view
            return TodoListView(
              itemList,
              onTap: (TodoItem item) async {
                Navigator.of(context).pushNamed('/edit', arguments: item);
              },
              onLongPress: (TodoItem item) async {
                state.delete(item.id);
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed('/edit', arguments: null);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
