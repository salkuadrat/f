import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

import 'package:starter_riverpod/modules/auth/auth.dart';
import 'package:starter_riverpod/utils/utils.dart';
import 'package:starter_riverpod/widgets/buttons.dart';
import 'package:starter_riverpod/widgets/logo.dart';

class Login extends ConsumerWidget {
  Login({Key? key}) : super(key: key);

  final TextEditingController _ucontroller = TextEditingController();
  final TextEditingController _pcontroller = TextEditingController();

  void _onLogin(BuildContext context, WidgetRef ref) async {
    FocusScope.of(context).unfocus();

    final auth = ref.read(authProvider.notifier);
    final username = _ucontroller.text;
    final password = _pcontroller.text;
    final empty = username.isEmpty || password.isEmpty;

    if (empty) {
      context.snackbar('Wrong username or password.');
      return;
    }

    await auth.login(username, password);

    final authState = ref.watch(authProvider);

    if (authState is Authenticated) {
      context.pop();
      context.snackbar('Signed in as ${authState.user.name}');
    } else {
      _pcontroller.clear();
      context.snackbar('Sign in failed. Please try again.');
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Logo(size: 125),
            TextFormField(
              controller: _ucontroller,
              decoration: const InputDecoration(
                labelText: 'Username',
                prefixIcon: Icon(Icons.person),
              ),
              textInputAction: TextInputAction.next,
              enableSuggestions: false,
              autocorrect: false,
            ),
            TextFormField(
              controller: _pcontroller,
              decoration: const InputDecoration(
                labelText: 'Password',
                prefixIcon: Icon(Icons.lock),
              ),
              textInputAction: TextInputAction.done,
              obscureText: true,
              enableSuggestions: false,
              autocorrect: false,
            ),
            const Gap(20),
            LoginButton('Sign In', onLogin: (_) => _onLogin(context, ref)),
            const Gap(15),
            Opacity(
              opacity: authState is AuthLoading ? 1.0 : 0.0,
              child: const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.lightGreen,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
