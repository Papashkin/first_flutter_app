import 'package:first_flutter_app/main_view_model.dart';
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
    fontSize: 16.0,
    fontFamily: 'Muli',
    color: Colors.black,
  );
  final textStyle = TextStyle(color: Colors.white, fontSize: 16.0);
  final String hint = "print text here";
  final bool obscureText = false;

  final int position = 0;
  final List<String> items = [];
  String text = "";

  @override
  void initState() {
    _controller.addListener(() {
      this.text = _controller.text.toLowerCase();
      _controller.value = _controller.value.copyWith(
        text: text,
        selection:
            TextSelection(baseOffset: text.length, extentOffset: text.length),
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
      value: MainViewModel(context: context),
      child: Consumer<MainViewModel>(
        builder: (context, model, child) => getScaffold(model),
      ),
    );
  }

  Widget getScaffold(MainViewModel model) {
    _controller.text = "";
    return Scaffold(
      appBar: appBar('First MVVM app'),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          getEditText(obscureText, hint, _controller),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 2.0, horizontal: 10.0),
                  child: MaterialButton(
                    padding: EdgeInsets.symmetric(vertical: 12.0),
                    onPressed: () => model.addItem(text),
                    child: Text('Add', style: textStyle),
                    color: Colors.green[500],
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 2.0, horizontal: 10.0),
                  child: MaterialButton(
                    padding: EdgeInsets.symmetric(vertical: 12.0),
                    onPressed: () => model.deleteLastItem(),
                    child: Text('Delete last', style: textStyle),
                    color: Colors.red[500],
                  ),
                ),
              ),
            ],
          ),
          Container(child: Divider(height: 10.0, color: Colors.blue[300])),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
              itemBuilder: (context, position) {
                return ItemCard(item: model.items.elementAt(position));
              },
              itemCount: model.items.length,
              physics: ScrollPhysics(),
            ),
          )
        ],
      ),
    );
  }

  Widget appBar(String title) {
    return AppBar(
      title: Text(title),
      backgroundColor: Colors.blue[700],
      elevation: 1.0,
    );
  }

  Widget getEditText(
      bool obscureText, String hint, TextEditingController controller) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
          border: Border.all(width: 1, color: Colors.blue[300]),
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0)),
      child: TextField(
          obscureText: obscureText,
          decoration: InputDecoration.collapsed(hintText: hint),
          controller: controller),
    );
  }
}
