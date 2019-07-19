import 'package:flutter/material.dart';

import '../ui/main_page.dart';
import '../ui/splash_page.dart';
import '../ui/guide_page.dart';

final onGenerateRoute = (RouteSettings settings) {
  final String pageName = settings.name;
  final Function pageContentBuilder = routers[pageName] as Function;
  if (pageContentBuilder != null) {
    var arguments = settings.arguments;
    if (arguments != null) {
      final Route route = MaterialPageRoute(
          builder: (contex) =>
              pageContentBuilder(contex, arguments: settings.arguments));
      return route;
    }
    final Route route =
        MaterialPageRoute(builder: (contex) => pageContentBuilder(contex));
    return route;
  }
};

final routers = {
  '/': (context) => SplashPage(),
  '/guide': (context) => GuidePage(),
  '/main': (context) => MainPage(title: "MainPage"),
};
