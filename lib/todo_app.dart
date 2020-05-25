import 'package:shared_preferences/shared_preferences.dart';
import 'package:FlutterNote/list_item.dart';
import 'package:flutter/material.dart';

class TodoApp extends StatefulWidget {
  @override
  _TodoAppState createState() => _TodoAppState();
}

class _TodoAppState extends State<TodoApp> {
  Future<SharedPreferences> _sprefs = SharedPreferences.getInstance();
  List<String> _notes;
  TextEditingController controller = TextEditingController();

  void handleSubmit(String text) {
    Navigator.of(context).pop();
    if(text.length != 0) {
      setState(() {
        _notes = [..._notes, text];
      });
      controller.clear();
    }
  }

  Future<Null> getSharedPrefs() async {
    final SharedPreferences prefs = await _sprefs;
    List<String> notes = prefs.getStringList('notes');
    setState(() {
      this._notes = notes;
    });
  }

  Future<Null> updateList()  async  {
    final SharedPreferences prefs = await _sprefs;
    setState(() {
      _notes = [..._notes, controller.value.text];
      prefs.setStringList('notes', _notes);
    });
  }


  @override
  void initState() async {
    super.initState();
    this._notes = [];
    getSharedPrefs();
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
                child: Text("SUBMIT"),
                onPressed: () {
                  Navigator.of(context).pop();
                  updateList();
                  controller.clear();
                },
              ),
              FlatButton(
                child: Text('CANCEL'),
                onPressed: () {
                  Navigator.of(context).pop();
                  controller.clear();
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
              .map((text) => ListItem(name: text))
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
