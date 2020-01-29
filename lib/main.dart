import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'List demo app',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MyHomePage(title: 'List demo app'),
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
  bool isClicked = false;
  TextStyle largeItalicSize = const TextStyle(fontSize: 20.0, fontStyle: FontStyle.italic);
  int position = 0;
  List<Widget> widgets = [];

  void _addWidget() {
    setState(() {
      widgets.add(getRaw(widgets.length + 1));
    });
  }

  void _deleteWidget() {
    setState(() {
      widgets.removeLast();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView.builder(
        padding: EdgeInsets.fromLTRB(10.0, 4.0, 10.0, 4.0),
            itemBuilder: (context, position) {
              return ListTile(
                title: Text('Row $position', style: largeItalicSize),
              );
            },
            itemCount: widgets.length,
          ),
        persistentFooterButtons: <Widget>[
          FloatingActionButton(
              onPressed: _addWidget,
              tooltip: 'Increment',
              child: Icon(Icons.add)
          ),
          FloatingActionButton(
              onPressed: _deleteWidget,
              tooltip: 'Dicrement',
              child: Icon(Icons.remove)
          ),
        ],
    );
  }

  Widget getRaw(int i) {
    return ListTile(
        title: Text("Row $i", style: largeItalicSize)
    );
  }
}