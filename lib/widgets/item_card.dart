import 'package:first_flutter_app/presentation/main_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// ignore: must_be_immutable
class ItemCard extends StatelessWidget {
  ToDoItem item;
  MainViewModel model;

  ItemCard({Key key, @required this.item, @required this.model})
      : super(key: key);

  final TextStyle largeItalicSize = const TextStyle(
    fontSize: 18.0,
    letterSpacing: 1.1,
    fontWeight: FontWeight.bold,
    fontFamily: 'Muli',
    color: Colors.yellow,
  );

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[500],
      child: Row(
        children: <Widget>[
          Expanded(
              flex: 4,
              child: Padding(
                  padding:
                      EdgeInsets.all(8.0),
                  child: Text(item.name, style: largeItalicSize))),
          Expanded(
              flex: 1,
              child: Padding(
                  padding:
                      EdgeInsets.all(8.0),
                  child: Checkbox(
                    activeColor: Colors.yellow,
                    checkColor: Colors.grey[500],
                    value: item.isSelected,
                    onChanged: (bool newValue) => model.setSelected(newValue, item.id),
                  ))),
        ],
      ),
    );
  }
}