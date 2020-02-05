import 'package:first_flutter_app/data/local/to_do_item_provider.dart';
import 'package:first_flutter_app/models/to_do_item.dart';
import 'package:flutter/widgets.dart';

class MainViewState {
  List<ToDoItem> items;

  MainViewState({this.items});
}

class MainViewModel extends ChangeNotifier {
  MainViewModel({@required ToDoItemProvider toDoItemProvider}):
      _toDoItemProvider = toDoItemProvider {
//    _state = MainViewState(items: _items);
  }

  final ToDoItemProvider _toDoItemProvider;

  MainViewState _state;
  MainViewState get state => _state;

  // open the To-Do database during init view
  List<ToDoItem> _items = [];
  void init() async {
    await _toDoItemProvider.open('to_do.db');
    _items = await _toDoItemProvider.getAll();
    if (_items == null) _items = [];
    _setState(MainViewState(items: _items));
  }

  void addItem(String text) async {
    if (text.isNotEmpty) {
      var newItem = await _toDoItemProvider.insert(
          ToDoItem(name: text, isSelected: false, id: _items.length + 1));
      _items.add(newItem);
      _setState(MainViewState(items: _items));
    }
  }

  void deleteLastItem() async {
    if (_items.isNotEmpty) {
      await _toDoItemProvider.delete(_items.last.id);
      _items.removeLast();
      _setState(MainViewState(items: _items));
    }
  }

  void setSelected(bool isSelected, int id) async {
    var updatedItem = _items.firstWhere((test) => test.id == id);
    updatedItem.isSelected = isSelected;
    await _toDoItemProvider.update(updatedItem);
    _setState(MainViewState(items: _items));
  }

  void dispose() {
    _toDoItemProvider.close();
    super.dispose();
  }

  _setState(MainViewState newState) {
    _state = newState;
    notifyListeners();
  }
}
