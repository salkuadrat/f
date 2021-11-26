import 'dart:io';

/// generate template for home screen
void homeProvider(String project, String dir) {
  File('$dir/home.dart').writeAsStringSync('''
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

import 'package:$project/config/config.dart';
import 'package:$project/modules/auth/auth.dart';
import 'package:$project/modules/home/home.dart';
import 'package:$project/routes/routes.dart';
import 'package:$project/utils/navigation.dart';
import 'package:$project/utils/snackbar.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HomeState(),
      child: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer2<HomeState, AuthState>(
      builder: (context, home, auth, _) {
        return Scaffold(
          appBar: AppBar(
            title: Text(appTitle),
            actions: [
              if (auth.isAuthenticated)
                IconButton(
                  icon: const Icon(Icons.person_rounded),
                  onPressed: () => context.snackbar(
                    'Hello \${auth.user?.name}',
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
                  '\${home.counter}',
                  style: Theme.of(context).textTheme.headline4,
                ),
                const Gap(20),
                OutlinedButton.icon(
                  onPressed: () => context.push(Routes.users),
                  icon: const Icon(Icons.people_outline_rounded),
                  label: const Text('List Users'),
                  style: homeButtonStyle,
                ),
                const Gap(10),
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
                        onPressed: () => context.push(Routes.login),
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
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: FloatingActionButton(
            onPressed: home.incrementCounter,
            tooltip: 'Increment',
            child: const Icon(Icons.add, size: 24),
          ),
        );
      },
    );
  }
}''');
}
