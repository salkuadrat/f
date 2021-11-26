import 'dart:io';

/// generate template for routes
void routes(String project, String template) {
  String dir = '$project/lib/routes';

  switch (template) {
    case 'get':
    case 'getx':
      _routesGetx(project, dir);
      break;
    default:
      _routesDefault(project, dir);
      break;
  }
}

void _routesDefault(String project, String dir) {
  File('$dir/routes.dart').writeAsStringSync('''
import 'package:flutter/material.dart';

import 'package:$project/screens/home.dart';
import 'package:$project/screens/login.dart';
import 'package:$project/screens/splash.dart';
import 'package:$project/screens/users.dart';

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
}''');
}

void _routesGetx(String project, String dir) {
  File('$dir/routes.dart').writeAsStringSync('''
import 'package:get/get.dart';

import 'package:$project/modules/home/home.dart';
import 'package:$project/modules/users/users.dart';
import 'package:$project/screens/home.dart';
import 'package:$project/screens/login.dart';
import 'package:$project/screens/splash.dart';
import 'package:$project/screens/users.dart';

class Routes {
  static const String root = '/';
  static const String home = '/home';
  static const String login = '/login';
  static const String users = '/users';
}

final List<GetPage> routes = [
  GetPage(name: Routes.root, page: () => const Splash()),
  GetPage(name: Routes.home, page: () => Home(Get.find()), binding: HomeBindings()),
  GetPage(name: Routes.login, page: () => Login(Get.find())),
  GetPage(name: Routes.users, page: () => Users(Get.find()), binding: UsersBindings()),
];''');
}
