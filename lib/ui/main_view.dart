import 'package:first_flutter_app/change_notifier_widget.dart';
import 'package:first_flutter_app/data/local/to_do_item_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:first_flutter_app/presentation/main_view_model.dart';
import 'package:first_flutter_app/widgets/item_card.dart';
import 'package:provider/provider.dart';

class MainView extends StatefulWidget {
  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  final _controller = TextEditingController();
  final TextStyle largeItalicSize =
      const TextStyle(fontSize: 16.0, fontFamily: 'Muli', color: Colors.black);
  final mainTextStyle = TextStyle(color: Colors.white, fontSize: 16.0);
  final String hint = "print text here";
  final bool obscureText = false;

  String _text = "";

  @override
  void initState() {
    _controller.addListener(() {
      _text = _controller.text;
      _controller.value = _controller.value.copyWith(
        text: _text,
        selection:
            TextSelection(baseOffset: _text.length, extentOffset: _text.length),
      );
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierWidget<MainViewModel>(
      viewModel: MainViewModel(toDoItemProvider: Provider.of<ToDoItemProvider>(context)),
      builder:(BuildContext context, MainViewModel viewModel, Widget child) => getScaffold(viewModel),
      onInitWidget: (MainViewModel viewModel) => viewModel.init(),
    );
  }

  Widget getScaffold(MainViewModel viewModel) {
    _controller.text = "";
    return viewModel.state == null
    ? Center(child: CircularProgressIndicator())
    : Scaffold(
      backgroundColor: Colors.grey[700],
      appBar: appBar('To-Do list'),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          getEditText(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              addItemButton(viewModel),
              deleteLastButton(viewModel),
            ],
          ),
          Divider(height: 10.0, color: Colors.yellow),
          viewModel.state.items.length > 0
              ? itemsList(viewModel)
              : Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 80.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                              Icon(Icons.terrain, color: Colors.yellow),
                              Padding(padding: EdgeInsets.only(top: 20.0)),
                              Text('There are no items in the list :(',
                                  style: mainTextStyle)
                        ],
                      ),
                    ),
                ),
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

  Widget addItemButton(MainViewModel viewModel) {
    return Expanded(
      flex: 2,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 8.0),
        child: MaterialButton(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            onPressed: () => viewModel.addItem(_text),
            child: Text('Add', style: mainTextStyle),
            color: Colors.green[500]),
      ),
    );
  }

  Widget deleteLastButton(MainViewModel viewModel) {
    return Expanded(
      flex: 2,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 8.0),
        child: MaterialButton(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            onPressed: () => viewModel.deleteLastItem(),
            child: Text('Delete last', style: mainTextStyle),
            color: Colors.red[500]),
      ),
    );
  }

  Widget itemsList(MainViewModel viewModel) {
    return Expanded(
      child: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
        itemBuilder: (context, position) {
          return ItemCard(
              item: viewModel.state.items.elementAt(position),
              model: viewModel);
        },
        itemCount: viewModel.state.items.length,
        physics: ScrollPhysics(),
      ),
    );
  }
}
