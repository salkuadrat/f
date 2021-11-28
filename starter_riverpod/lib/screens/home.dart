import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

import 'package:starter_riverpod/config/config.dart';
import 'package:starter_riverpod/modules/auth/auth.dart';
import 'package:starter_riverpod/modules/home/home.dart';
import 'package:starter_riverpod/routes/routes.dart';
import 'package:starter_riverpod/utils/utils.dart';

class Home extends ConsumerWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.read(authProvider.notifier);
    final authState = ref.watch(authProvider);

    final home = ref.read(homeProvider.notifier);
    final homeState = ref.watch(homeProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(appTitle),
        actions: [
          if (authState is Authenticated)
            IconButton(
              icon: const Icon(Icons.person_rounded),
              onPressed: () => context.snackbar(
                'Hello ${authState.user.name}',
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
              '${homeState.counter}',
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
            authState is Authenticated
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
              opacity: authState is AuthLoading ? 1.0 : 0.0,
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
  }
}
