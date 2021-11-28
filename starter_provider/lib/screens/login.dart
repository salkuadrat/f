import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

import 'package:starter_provider/modules/auth/auth.dart';
import 'package:starter_provider/utils/utils.dart';
import 'package:starter_provider/widgets/buttons.dart';
import 'package:starter_provider/widgets/logo.dart';

class Login extends StatelessWidget {
  Login({Key? key}) : super(key: key);

  final TextEditingController _ucontroller = TextEditingController();
  final TextEditingController _pcontroller = TextEditingController();

  void _onLogin(BuildContext context) async {
    FocusScope.of(context).unfocus();

    final auth = context.read<AuthState>();
    final username = _ucontroller.text;
    final password = _pcontroller.text;
    final empty = username.isEmpty || password.isEmpty;

    if (empty) {
      context.snackbar('Wrong username or password.');
      return;
    }

    await auth.login(username, password);

    if (auth.isAuthenticated) {
      context.pop();
      context.snackbar('Signed in as ${auth.user?.name}');
    } else {
      _pcontroller.clear();
      context.snackbar('Sign in failed. Please try again.');
    }
  }

  @override
  Widget build(BuildContext context) {
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
            LoginButton('Sign In', onLogin: _onLogin),
            const Gap(15),
            Consumer<AuthState>(
              builder: (_, auth, __) => Opacity(
                opacity: auth.isLoading ? 1.0 : 0.0,
                child: const SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.lightGreen,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
