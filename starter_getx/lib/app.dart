import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:starter_getx/config/config.dart';
import 'package:starter_getx/modules/auth/auth.dart';
import 'package:starter_getx/routes/routes.dart';

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
