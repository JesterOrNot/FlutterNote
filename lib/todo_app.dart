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
    if (text.length != 0) {
      setState(() {
        _notes = [..._notes, text];
      });
    }
    print(_notes);
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
        body: ListView.builder(
          itemCount: _notes.length,
          itemBuilder: (context, index) {
            final item = _notes[index];
            return Dismissible(
              key: Key(item),
              confirmDismiss: (DismissDirection direction) async {
                return await showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text("Confirm"),
                      content: const Text(
                          "Are you sure you wish to delete this item?"),
                      actions: <Widget>[
                        FlatButton(
                            onPressed: () => Navigator.of(context).pop(true),
                            child: const Text("DELETE")),
                        FlatButton(
                          onPressed: () => Navigator.of(context).pop(false),
                          child: const Text("CANCEL"),
                        ),
                      ],
                    );
                  },
                );
              },
              child: ListItem(text: _notes[index]),
              onDismissed: (direction) => {
                setState(() {
                  _notes.removeAt(index);
                })
              },
            );
          },
          shrinkWrap: true,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _addNote,
          tooltip: 'Add Note',
          child: Icon(Icons.add),
        ));
  }
}
