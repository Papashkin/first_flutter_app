import 'package:flutter/widgets.dart';


class MainViewModel extends ChangeNotifier {
  List<ToDoItem> items = [];

  void addItem(String text) {
    if (text.isNotEmpty) {
      items.add(ToDoItem(name: text, isSelected: false, id: items.length + 1));
      notifyListeners();
    }
  }

  void deleteLastItem() {
    if (items.isNotEmpty) {
      items.removeLast();
      notifyListeners();
    }
  }

  void setSelected(bool isSelected, int id) {
    items.firstWhere((test) => test.id == id).isSelected = isSelected;
    notifyListeners();
  }

}

class ToDoItem {
  ToDoItem({@required this.id, this.name, this.isSelected});

  String name;
  int id;
  bool isSelected = false;
}