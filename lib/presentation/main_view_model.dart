import 'dart:async';
import 'package:flutter/widgets.dart';


class MainViewModel extends ChangeNotifier {
  List<ToDoItem> _items = [];
  String _text = "";
  StreamController _itemsController = StreamController<List<ToDoItem>>();

  void addItem() {
    if (_text.isNotEmpty) {
      _items.add(ToDoItem(name: _text, isSelected: false));
      _itemsController.add(_items);
      _text = "";
      notifyListeners();
    }
  }

  void deleteLastItem() {
    if (_items.isNotEmpty) {
      _items.removeLast();
      _itemsController.add(_items);
      notifyListeners();
    }
  }

  void setText(String text) {
    this._text = text;
  }

  Stream<List<ToDoItem>> get toDoItems => _itemsController.stream;

}

class ToDoItem {
  ToDoItem({this.name, this.isSelected});

  String name = "";
  bool isSelected = false;
}