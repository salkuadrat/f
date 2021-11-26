import 'package:flutter/material.dart';

import 'package:starter_provider/config/config.dart';
import 'package:starter_provider/routes/routes.dart';

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
}
