import 'package:flutter/widgets.dart';

class MainViewModel extends ChangeNotifier {
  List<ToDoItem> items = [];

  MainViewModel({@required BuildContext context});

//   ignore: missing_return
  void Function() addItem(String text) {
    if (text.isNotEmpty) {
      items.add(ToDoItem(name: text, isSelected: false));
      notifyListeners();
    }
  }

  // ignore: missing_return
  void Function() deleteLastItem() {
    if (items.length > 0) {
      items.removeLast();
      notifyListeners();
    }
  }
}

class ToDoItem {
  ToDoItem({this.name, this.isSelected});

  String name = "";
  bool isSelected = false;
}