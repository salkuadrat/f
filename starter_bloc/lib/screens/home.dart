import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import 'package:starter_bloc/config/config.dart';
import 'package:starter_bloc/modules/auth/auth.dart';
import 'package:starter_bloc/modules/home/home.dart';
import 'package:starter_bloc/routes/routes.dart';
import 'package:starter_bloc/utils/utils.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeBloc(),
      child: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final auth = context.read<AuthBloc>();
    final home = context.read<HomeBloc>();

    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, authState) {
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
                BlocBuilder<HomeBloc, HomeState>(
                  builder: (context, homeState) => Text(
                    '${homeState.counter}',
                    style: Theme.of(context).textTheme.headline4,
                  ),
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
                          auth.logout();
                          context.snackbar('You have signed out');
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
}
