import 'package:first_flutter_app/presentation/main_view_model.dart';
import 'package:first_flutter_app/widgets/item_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainView extends StatefulWidget {
  @override
  State createState() {
    return _MainViewState();
  }
}

class _MainViewState extends State<MainView> {
  final _controller = TextEditingController();
  final TextStyle largeItalicSize = const TextStyle(
    fontSize: 16.0, fontFamily: 'Muli', color: Colors.black
  );
  final textStyle = TextStyle(color: Colors.white, fontSize: 16.0);
  final String hint = "print text here";
  final bool obscureText = false;

  List<ToDoItem> _items = [];
  MainViewModel viewModel = MainViewModel();

  @override
  void initState() {
    _controller.addListener(() {
      var text = _controller.text;
      viewModel.setText(text);
      _controller.value = _controller.value.copyWith(
        text: text,
        selection:
            TextSelection(baseOffset: text.length, extentOffset: text.length),
      );
    });
    viewModel.toDoItems.listen(setToDoItems);
    super.initState();
  }

  void setToDoItems(List<ToDoItem> event) {
    this._items = event;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MainViewModel>.value(
      value: viewModel,
      child: Consumer<MainViewModel>(
        builder: (context, model, child) => getScaffold()
      ),
    );
  }

  Widget getScaffold() {
    _controller.text = "";
    return Scaffold(
      backgroundColor: Colors.grey[700],
      appBar: appBar('To-Do Flutter app'),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          getEditText(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              addItemButton(),
              deleteLastButton(),
            ],
          ),
          Divider(height: 10.0, color: Colors.yellow),
          itemsList(),
        ],
      ),
    );
  }

  Widget appBar(String title) {
    return AppBar(
      title: Text(title),
      backgroundColor: Colors.black,
      elevation: 2.0,
    );
  }

  Widget getEditText() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
          border: Border.all(width: 1, color: Colors.yellow[400]),
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0)),
      child: TextField(
          obscureText: obscureText,
          decoration: InputDecoration.collapsed(hintText: hint),
          controller: _controller),
    );
  }

  Widget addItemButton() {
    return Expanded(
      flex: 2,
      child: Padding(
        padding:
        EdgeInsets.symmetric(vertical: 2.0, horizontal: 10.0),
        child: MaterialButton(
          padding: EdgeInsets.symmetric(vertical: 12.0),
          onPressed: () => viewModel.addItem(),
          child: Text('Add', style: textStyle),
          color: Colors.green[500],
        ),
      ),
    );
  }

  Widget deleteLastButton() {
    return Expanded(
      flex: 2,
      child: Padding(
        padding:
        EdgeInsets.symmetric(vertical: 2.0, horizontal: 10.0),
        child: MaterialButton(
          padding: EdgeInsets.symmetric(vertical: 12.0),
          onPressed: () => viewModel.deleteLastItem(),
          child: Text('Delete last', style: textStyle),
          color: Colors.red[500],
        ),
      ),
    );
  }

  Widget itemsList() {
    return Expanded(
      child: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
        itemBuilder: (context, position) {
          return ItemCard(item: _items.elementAt(position), model: viewModel);
        },
        itemCount: _items.length,
        physics: ScrollPhysics(),
      ),
    );
  }
}
