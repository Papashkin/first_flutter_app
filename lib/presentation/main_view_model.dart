import 'package:first_flutter_app/data/local/to_do_item_provider.dart';
import 'package:first_flutter_app/models/to_do_item.dart';
import 'package:flutter/widgets.dart';


class MainViewState {
  List<ToDoItem> items;

  MainViewState({this.items});
}


class MainViewModel extends ChangeNotifier {
  List<ToDoItem> _items = [];
  MainViewState _state = MainViewState(items: []);
  ToDoItemProvider itemsProvider = ToDoItemProvider();

  MainViewState get state => _state;

  // open the To-Do database during init view
  void init() async {
    await itemsProvider.open('to_do.db');
    _items = await itemsProvider.getAll();
    if (_items == null) _items = [];
    _setState(MainViewState(items: _items));
  }

  void addItem(String text) async {
    if (text.isNotEmpty) {
      var newItem = await itemsProvider.insert(ToDoItem(name: text, isSelected: false, id: _items.length + 1));
      _items.add(newItem);
      _setState(MainViewState(items: _items));
    }
  }

  void deleteLastItem() async {
    if (_items.isNotEmpty) {
      await itemsProvider.delete(_items.last.id);
      _items.removeLast();
      _setState(MainViewState(items: _items));
    }
  }

  void setSelected(bool isSelected, int id) async {
    var updatedItem = _items.firstWhere((test) => test.id == id);
    updatedItem.isSelected = isSelected;
    await itemsProvider.update(updatedItem);
    _setState(MainViewState(items: _items));
  }

  void dispose() {
    itemsProvider.close();
    super.dispose();
  }

  _setState(MainViewState newState) {
    _state = newState;
    notifyListeners();
  }

}