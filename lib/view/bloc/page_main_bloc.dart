import 'package:bloc_provider/bloc_provider.dart';
import 'package:flutter/material.dart';
import 'package:todo/model/todo_bloc.dart';
import 'package:todo/model/todo_item.dart';

import '../todo_list_view.dart';

class MainBlocPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<TodoBloc>(context);
    return Scaffold(
      body: SafeArea(
        child: StreamBuilder<List<TodoItem>>(
          stream: bloc.itemListStream,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }
            final List<TodoItem> itemList = snapshot.data;
            // view
            return TodoListView(
              itemList,
              onTap: (TodoItem item) async {
                Navigator.of(context).pushNamed('/edit', arguments: item);
              },
              onLongPress: (TodoItem item) async {
                bloc.delete(item.id);
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
