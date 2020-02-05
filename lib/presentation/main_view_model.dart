import 'package:flutter/widgets.dart';


class MainViewState {
  List<ToDoItem> items;

  MainViewState({this.items});
}


class MainViewModel extends ChangeNotifier {
  List<ToDoItem> _items = [];
  MainViewState _state = MainViewState(items: []);

  MainViewState get state => _state;

  void addItem(String text) {
    if (text.isNotEmpty) {
      _items.add(ToDoItem(name: text, isSelected: false, id: _items.length + 1));
      _setState(MainViewState(items: _items));
    }
  }

  void deleteLastItem() {
    if (_items.isNotEmpty) {
      _items.removeLast();
      _setState(MainViewState(items: _items));
    }
  }

  void setSelected(bool isSelected, int id) {
    _items.firstWhere((test) => test.id == id).isSelected = isSelected;
    _setState(MainViewState(items: _items));
  }

  _setState(MainViewState newState) {
    _state = newState;
    notifyListeners();
  }

}

class ToDoItem {
  ToDoItem({@required this.id, this.name, this.isSelected});

  String name;
  int id;
  bool isSelected = false;
}