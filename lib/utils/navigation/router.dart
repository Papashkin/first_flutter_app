import 'package:first_flutter_app/ui/main_view.dart';
import 'package:flutter/material.dart';

class Routes {
  static Route<dynamic> generateRoutes(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case RoutePath.Main:
        return MaterialPageRoute<MainView>(
            builder: (BuildContext context) => MainView());
      default:
        throw "Unknown route. Route \"${routeSettings.name}\" doesn't exists";
    }
  }
}


class RoutePath {
  static const String Main = 'main';
}