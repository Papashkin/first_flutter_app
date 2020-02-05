import 'package:flutter/material.dart';

final String columnId = '_id';
final String columnName = 'name';
final String columnSelected = 'isSelected';

class ToDoItem {
  ToDoItem({@required this.id, this.name, this.isSelected});

  String name;
  int id;
  bool isSelected = false;

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      columnName: name,
      columnSelected: isSelected == true ? 1 : 0
    };
    if (id != null) {
      map[columnId] = id;
    }
    return map;
  }

  ToDoItem.fromMap(Map<String, dynamic> map) {
    id = map[columnId];
    name = map[columnName];
    isSelected = map[columnSelected] == 1;
  }

}