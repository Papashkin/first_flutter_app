import 'package:first_flutter_app/providers.dart';
import 'package:first_flutter_app/utils/navigation/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

void main() => runApp(ToDoApplication());

class ToDoApplication extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      child: Application(),
    );
  }
}

class Application extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: RoutePath.Main,
      onGenerateRoute: Routes.generateRoutes,
    );
  }
}
