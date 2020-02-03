import 'package:first_flutter_app/main_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  final String title = 'To-Do\'s';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(title: title),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _controller = TextEditingController();
  final TextStyle largeItalicSize = const TextStyle(
    fontSize: 16.0,
    fontFamily: 'Muli',
    color: Colors.black,
  );
  final String hint = "print text here";
  final bool obscureText = false;

  int position = 0;
//  List<String> items = [];
  List<ToDoItem> items = [];
  String text = "";

  void _addWidget() {
    setState(() {
      if (text.isNotEmpty) {
        var newItem = ToDoItem();
        newItem.name = text;
        newItem.isSelected = false;
        items.add(newItem);
        _controller.text = "";
      }
    });
  }

  void _deleteLast() {
    setState(() {
      if (items.length >= 1) {
        items.removeLast();
      }
    });
  }

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
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.blue[700],
        elevation: 1.0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.blue[300]),
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0)),
            child: TextField(
                obscureText: obscureText,
                decoration: InputDecoration.collapsed(hintText: hint),
                controller: _controller),
          ),
          Row(
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 10.0),
                  child: MaterialButton(
                    onPressed: _addWidget,
                    child: Text('Add', style: TextStyle(color: Colors.white)),
                    color: Colors.green[500],
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 10.0),
                  child: MaterialButton(
                    onPressed: _deleteLast,
                    child: Text('Delete last', style: TextStyle(color: Colors.white)),
                    color: Colors.red[500],
                  ),
                ),
              ),
            ],
          ),
          Divider(height: 10.0, color: Colors.blue[350]),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
              itemBuilder: (context, position) {
                return Card(
                    color: items.elementAt(position).isSelected ? Colors.grey : Colors.white,
                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding:
                          EdgeInsets.symmetric(vertical: 16.0, horizontal: 10.0),
                          child: Text(items.elementAt(position).name,
                            style: TextStyle(
                              fontFamily: 'Muli',
                              backgroundColor: items.elementAt(position).isSelected ? Colors.grey : Colors.white,
                              fontStyle: FontStyle.normal,
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                );
              },
              itemCount: items.length,
              physics: ScrollPhysics(),
            ),
          )
        ],
      ),
    );
  }
}

//class MainView extends StatelessWidget {
//
//  final _controller = TextEditingController();
//  final TextStyle largeItalicSize = const TextStyle(
//    fontSize: 16.0,
//    fontFamily: 'Muli',
//    color: Colors.black,
//  );
//  final String hint = "print text here";
//  final bool obscureText = false;
//
//  final int position = 0;
//  final List<String> items = [];
//  final String text = "";
//
//  @override
//  Widget build(BuildContext context) {
//    return ChangeNotifierProvider<MainViewModel>.value(
//      value: MainViewModel(context: context),
//      child: Consumer<MainViewModel>(
//        builder: (context, model, child) => getScaffold(),
//      ),
//    );
//  }
//
//  Scaffold getScaffold() {
//    return Scaffold(
//      appBar: AppBar(
//        title: Text("First MVVM app"),
//        backgroundColor: Colors.blue[500],
//      ),
//      body: Column(
//        mainAxisAlignment: MainAxisAlignment.start,
//        crossAxisAlignment: CrossAxisAlignment.stretch,
//        children: <Widget>[
//          Container(
//            padding: const EdgeInsets.symmetric(horizontal: 10),
//            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
//            decoration: BoxDecoration(
//                border: Border.all(width: 1, color: Colors.blue),
//                color: Colors.white,
//                borderRadius: BorderRadius.circular(8.0)),
//            child: TextField(
//                obscureText: obscureText,
//                decoration: InputDecoration.collapsed(hintText: hint),
//                controller: _controller),
//          ),
//          MaterialButton(
//            padding: const EdgeInsets.symmetric(horizontal: 16),
//            onPressed: () => {
//            },
//            child: Text('Add', style: TextStyle(color: Colors.white)),
//            color: Colors.green[500],
//          ),
//          MaterialButton(
//            padding: const EdgeInsets.symmetric(horizontal: 16),
//            onPressed:  _deleteWidget,
//            child: Text('Delete last', style: TextStyle(color: Colors.white)),
//            color: Colors.red[500],
//          ),
//          Container(child: Divider(height: 1.0, color: Colors.grey)),
//          Container(
//            height: 397,
//            child: ListView.builder(
//              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
//              itemBuilder: (context, position) {
//                return Card(
//                  child: Padding(
//                    padding:
//                        EdgeInsets.symmetric(vertical: 16.0, horizontal: 10.0),
//                    child: Text(items.elementAt(position),
//                        style: TextStyle(
//                          fontFamily: 'Muli',
//                          fontStyle: FontStyle.normal,
//                          fontSize: 16.0,
//                        )),
//                  ),
//                );
//              },
//              itemCount: items.length,
//              physics: ScrollPhysics(),
//            ),
//          )
//        ],
//      ),
//    );
//  }
//}


class ToDoItem {
  String name = "";
  bool isSelected = false;
}