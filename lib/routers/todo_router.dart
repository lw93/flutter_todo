import 'package:flutter/material.dart';

import '../ui/guide_page.dart';
import '../ui/login_page.dart';
import '../ui/main_page.dart';
import '../ui/splash_page.dart';
import '../ui/register_page.dart';
import '../ui/list_page.dart';

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
  '/login': (context) => LoginPage(),
  '/register': (context) => RegisterPage(),
  '/main': (context) => MainPage(),
  '/todos': (context, {arguments}) => TodoListPage(project: arguments),
};
