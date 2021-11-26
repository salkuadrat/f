import 'dart:io';

/// generate template for splash screen
void splashRiverpod(String project, String dir) {
  File('$dir/splash.dart').writeAsStringSync('''
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:$project/config/config.dart';
import 'package:$project/routes/routes.dart';
import 'package:$project/utils/navigation.dart';
import 'package:$project/widgets/logo.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) async {
      await _init();
    });
  }

  Future _init() async {
    // Do some necessary things opening Home Screen, such as:
    //
    // Loading data from Shared Preferences
    // Loading initil data from backend
    // Initializes states
    // etc..

    // dummy delay to show splash screen
    // remove this in real application
    await Future.delayed(const Duration(seconds: 2));

    // Show Home Screen
    context.replace(Routes.home);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Logo(opacity: 0.96),
          const Gap(18),
          Text(
            appName,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 20),
          ),
        ],
      ),
    );
  }
}
  ''');
}
