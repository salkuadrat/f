import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import 'package:starter_getx/config/config.dart';
import 'package:starter_getx/modules/auth/auth.dart';
import 'package:starter_getx/modules/home/home.dart';
import 'package:starter_getx/routes/routes.dart';
import 'package:starter_getx/utils/snackbar.dart';

class Home extends StatelessWidget {
  final HomeController home;

  const Home(this.home, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final auth = Get.find<AuthController>();

    return Obx(() {
      return Scaffold(
        appBar: AppBar(
          title: Text(appTitle),
          actions: [
            if (auth.isAuthenticated)
              IconButton(
                icon: const Icon(Icons.person_rounded),
                onPressed: () => context.snackbar(
                  'Hello ${auth.user?.name}',
                ),
              ),
          ],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Gap(50),
              const Text(
                'You have pushed the plus button this many times:',
              ),
              const Gap(12),
              Text(
                '${home.counter}',
                style: Theme.of(context).textTheme.headline4,
              ),
              const Gap(20),
              OutlinedButton.icon(
                onPressed: () => Get.toNamed(Routes.users),
                icon: const Icon(Icons.people_outline_rounded),
                label: const Text('List Users'),
                style: homeButtonStyle,
              ),
              const Gap(8),
              auth.isAuthenticated
                  ? OutlinedButton(
                      onPressed: () async {
                        await auth.logout();
                        context.snackbar('You have signed out.');
                      },
                      child: const Text('Sign Out'),
                      style: homeButtonStyle,
                    )
                  : OutlinedButton(
                      onPressed: () => Get.toNamed(Routes.login),
                      child: const Text('Sign In'),
                      style: homeButtonStyle,
                    ),
              const Gap(10),
              Opacity(
                opacity: auth.isLoading ? 1.0 : 0.0,
                child: const SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.pinkAccent,
                  ),
                ),
              ),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          onPressed: home.incrementCounter,
          tooltip: 'Increment',
          child: const Icon(Icons.add, size: 24),
        ),
      );
    });
  }
}
