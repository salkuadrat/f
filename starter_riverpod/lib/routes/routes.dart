import 'package:flutter/material.dart';

import 'package:starter_riverpod/screens/home.dart';
import 'package:starter_riverpod/screens/login.dart';
import 'package:starter_riverpod/screens/splash.dart';
import 'package:starter_riverpod/screens/users.dart';

class Routes {
  static const String root = '/';
  static const String home = '/home';
  static const String login = '/login';
  static const String users = '/users';
}

Route routes(RouteSettings settings) {
  switch (settings.name) {
    case Routes.home:
      return _page(const Home(), settings);
    case Routes.login:
      return _page(Login(), settings);
    case Routes.users:
      return _page(const Users(), settings);
    case Routes.root:
    default:
      return _page(const Splash(), settings);
  }
}

MaterialPageRoute _page(page, RouteSettings settings) {
  return MaterialPageRoute(builder: (_) => page, settings: settings);
}
