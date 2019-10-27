import 'package:flutter/material.dart';
import 'package:todo/model/todo_item.dart';

class TodoListView extends StatelessWidget {
  final List<TodoItem> _itemList;

  final Function(TodoItem item) _onTap;
  final Function(TodoItem item) _onLongPress;

  TodoListView(this._itemList,
      {Function(TodoItem item) onTap, Function(TodoItem item) onLongPress})
      : _onTap = onTap,
        _onLongPress = onLongPress;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: List.generate(_itemList.length, (idx) {
        TodoItem item = _itemList[idx];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: Card(
            color: item.isComplete ? Colors.blue.shade200 : Colors.white,
            child: InkWell(
              onTap: () {
                if (_onTap != null) _onTap(item);
              },
              onLongPress: () {
                if (_onLongPress != null) _onLongPress(item);
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(item.display()),
              ),
            ),
          ),
        );
      }),
    );
  }
}
