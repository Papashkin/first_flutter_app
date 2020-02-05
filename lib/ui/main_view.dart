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
    return ChangeNotifierProvider<MainViewModel>.value(
      value: MainViewModel(),
      child: Consumer<MainViewModel>(
        builder: (context, model, child) => getScaffold(model)
      ),
    );
  }

  Widget getScaffold(MainViewModel viewModel) {
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
              addItemButton(viewModel),
              deleteLastButton(viewModel),
            ],
          ),
          Divider(height: 10.0, color: Colors.yellow),
          itemsList(viewModel),
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
        padding:
        EdgeInsets.symmetric(vertical: 2.0, horizontal: 8.0),
        child: MaterialButton(
          padding: EdgeInsets.symmetric(vertical: 8.0),
          onPressed: () => viewModel.addItem(_text),
          child: Text('Add', style: textStyle),
          color: Colors.green[500]),
      ),
    );
  }

  Widget deleteLastButton(MainViewModel viewModel) {
    return Expanded(
      flex: 2,
      child: Padding(
        padding:
        EdgeInsets.symmetric(vertical: 2.0, horizontal: 8.0),
        child: MaterialButton(
          padding: EdgeInsets.symmetric(vertical: 8.0),
          onPressed: () => viewModel.deleteLastItem(),
          child: Text('Delete last', style: textStyle),
          color: Colors.red[500]),
      ),
    );
  }

  Widget itemsList(MainViewModel viewModel) {
    return Expanded(
      child: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
        itemBuilder: (context, position) {
          return ItemCard(item: viewModel.state.items.elementAt(position), model: viewModel);
        },
        itemCount: viewModel.state.items.length,
        physics: ScrollPhysics(),
      ),
    );
  }
}