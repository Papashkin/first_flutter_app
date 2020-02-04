import 'dart:async';
import 'package:flutter/widgets.dart';


class MainViewModel extends ChangeNotifier {
  List<ToDoItem> _items = [];
  String _text = "";
  StreamController _itemsController = StreamController<List<ToDoItem>>();

  void addItem() {
    if (_text.isNotEmpty) {
      _items.add(ToDoItem(name: _text, isSelected: false, id: _items.length + 1));
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

  void setSelected(bool isSelected, int id) {
    _items.firstWhere((test) => test.id == id).isSelected = isSelected;
    notifyListeners();
  }

  Stream<List<ToDoItem>> get toDoItems => _itemsController.stream;

}

class ToDoItem {
  ToDoItem({@required this.id, this.name, this.isSelected});

  String name;
  int id;
  bool isSelected = false;
}