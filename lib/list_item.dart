import 'package:flutter/material.dart';

class ListItem extends StatelessWidget {

  final String name;

  ListItem({Key key, this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListTile(trailing: Icon(Icons.edit), title: Text(name))
    );
  }
}