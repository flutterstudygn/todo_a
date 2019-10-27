import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:todo/model/todo_item.dart';
import 'package:todo/repository/todo_state.dart';

class _TodoEditor {
  final TodoItem _item;
  _TodoEditor(this._item);

  TodoItem get item => _item;

  final BehaviorSubject<bool> _validStream = BehaviorSubject<bool>();

  void dispose() {
    _validStream.close();
  }

  String get title => _item?.title ?? '';
  set title(String value) {
    _item?.title = value;
    _validStream.sink.add(value.isNotEmpty);
  }

  bool get isComplete => _item?.isComplete ?? false;
  set isComplete(bool value) {
    _item?.isComplete = value;
  }

  Future submit(BuildContext context) async {
    final state = Provider.of<TodoState>(context);
    if (_item.id == null) {
      await state.create(_item);
    } else {
      await state.update(_item);
    }
  }
}

class EditNotifierPage extends StatelessWidget {
  final _TodoEditor _editor;

  EditNotifierPage({TodoItem item})
      : _editor = _TodoEditor(item?.clone() ?? TodoItem());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('편집'),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    TextFormField(
                      initialValue: _editor.title,
                      onChanged: (v) => _editor.title = v,
                      decoration: InputDecoration(
                        labelText: 'Title',
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        Text('완료'),
                        Switch(
                          value: _editor.isComplete ?? false,
                          onChanged: (v) => _editor.isComplete = v,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                child: StreamBuilder<bool>(
                    stream: _editor._validStream.stream,
                    builder: (context, snapshot) {
                      return RaisedButton(
                        child: Text('저장'),
                        onPressed: snapshot.data != false
                            ? () async {
                                await _editor.submit(context);
                                Navigator.of(context).pop();
                              }
                            : null,
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
