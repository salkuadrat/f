import 'dart:io';

/// generate template for app
void app(String project, String template) {
  switch (template) {
    case 'get':
    case 'getx':
      _appGetx(project);
      break;
    default:
      _appDefault(project);
      break;
  }
}

void _appGetx(String project) {
  File('$project/lib/app.dart').writeAsStringSync('''
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:$project/config/config.dart';
import 'package:$project/modules/auth/auth.dart';
import 'package:$project/routes/routes.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    Get.put(AuthController(AuthService()));

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: appTitle,
      theme: appTheme,
      initialRoute: Routes.root,
      getPages: routes,
    );
  }
}
  ''');
}

void _appDefault(String project) {
  File('$project/lib/app.dart').writeAsStringSync('''
import 'package:flutter/material.dart';

import 'package:$project/config/config.dart';
import 'package:$project/routes/routes.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: appTitle,
      theme: appTheme,
      onGenerateRoute: routes,
    );
  }
}''');
}
