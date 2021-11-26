import 'package:get/get.dart';

import 'package:starter_getx/modules/home/home.dart';
import 'package:starter_getx/modules/users/users.dart';
import 'package:starter_getx/screens/home.dart';
import 'package:starter_getx/screens/login.dart';
import 'package:starter_getx/screens/splash.dart';
import 'package:starter_getx/screens/users.dart';

class Routes {
  static const String root = '/';
  static const String home = '/home';
  static const String login = '/login';
  static const String users = '/users';
}

final List<GetPage> routes = [
  GetPage(name: Routes.root, page: () => const Splash()),
  GetPage(
      name: Routes.home, page: () => Home(Get.find()), binding: HomeBindings()),
  GetPage(name: Routes.login, page: () => Login(Get.find())),
  GetPage(
      name: Routes.users,
      page: () => Users(Get.find()),
      binding: UsersBindings()),
];
