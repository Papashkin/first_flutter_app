import 'package:flutter/widgets.dart';

class MainViewModel extends ChangeNotifier {
  BuildContext _context;

  MainViewModel({@required BuildContext context})
  : _context = context;

  List<String> items = [];

  void addItem(String text) {
    items.add(text);
    notifyListeners();
  }
}