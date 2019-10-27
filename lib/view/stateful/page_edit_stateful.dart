import 'package:flutter/material.dart';
import 'package:todo/model/todo_item.dart';
import 'package:todo/repository/todo_repository.dart';

class EditStatefulPage extends StatefulWidget {
  final TodoRepository _repo;
  final TodoItem _item;

  EditStatefulPage(this._repo, {TodoItem item})
      : _item = item?.clone() ?? TodoItem();

  @override
  _EditStatefulPageState createState() => _EditStatefulPageState();
}

class _EditStatefulPageState extends State<EditStatefulPage> {
  bool _isValid = false;
  final TextEditingController _textEditingController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _textEditingController.addListener(() {
      setState(() {
        _isValid = _textEditingController.text.isNotEmpty;
      });
    });
    _textEditingController.text = widget?._item?.title;
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

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
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Title',
                      ),
                      controller: _textEditingController,
                    ),
                    Row(
                      children: <Widget>[
                        Text('완료'),
                        Switch(
                          value: widget._item.isComplete ?? false,
                          onChanged: (v) => widget._item.isComplete = v,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                child: RaisedButton(
                  onPressed: _isValid
                      ? () async {
                          widget._item.title = _textEditingController.text;
                          TodoItem result;
                          if (widget._item.id == null) {
                            result = await widget._repo.create(widget._item);
                          } else {
                            result = await widget._repo.update(widget._item);
                          }
                          if (result != null) {
                            Navigator.of(context).pop();
                          }
                        }
                      : null,
                  child: Text('저장'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
