import 'package:first_flutter_app/presentation/main_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// ignore: must_be_immutable
class ItemCard extends StatelessWidget {
  ToDoItem item;

  ItemCard({Key key, this.item}) : super(key: key);

  final TextStyle largeItalicSize = const TextStyle(
    fontSize: 16.0,
    fontFamily: 'Muli',
    color: Colors.black,
  );

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: <Widget>[
          Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 10.0),
              child: Text(item.name, style: largeItalicSize)
          ),
        ],
      ),
    );
  }
}
