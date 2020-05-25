import 'package:FlutterNote/list_item.dart';
import 'package:flutter/material.dart';

class TodoApp extends StatefulWidget {
  @override
  _TodoAppState createState() => _TodoAppState();
}

class _TodoAppState extends State<TodoApp> {
  List<String> _notes = [];
  TextEditingController controller = TextEditingController();

  void handleSubmit(String text) {
    controller.clear();
    if(text.length != 0) {
      setState(() {
        _notes = [..._notes, text];
      });
    }
    Navigator.of(context).pop();
  }

  void _addNote() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Add a Note!'),
            content: TextField(
              controller: controller,
              autofocus: true,
              onSubmitted: handleSubmit,
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('CANCEL'),
                onPressed: () {
                  controller.clear();
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
          children: _notes
              .map((text) => ListItem(text: text))
              .toList(growable: false),
          shrinkWrap: true,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _addNote,
          tooltip: 'Add Note',
          child: Icon(Icons.add),
        ));
  }
}
