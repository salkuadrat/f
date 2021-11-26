import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import 'package:starter_bloc/modules/auth/auth.dart';
import 'package:starter_bloc/utils/navigation.dart';
import 'package:starter_bloc/utils/snackbar.dart';
import 'package:starter_bloc/widgets/buttons.dart';
import 'package:starter_bloc/widgets/logo.dart';

class Login extends StatelessWidget {
  Login({Key? key}) : super(key: key);

  final TextEditingController _ucontroller = TextEditingController();
  final TextEditingController _pcontroller = TextEditingController();

  void _onLogin(BuildContext context) {
    FocusScope.of(context).unfocus();

    final auth = context.read<AuthBloc>();
    final username = _ucontroller.text;
    final password = _pcontroller.text;

    auth.login(username, password);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, authState) {
        if (authState is Authenticated) {
          context.pop();
          context.snackbar('Signed in as ${authState.user.name}');
        }

        if (authState is NotAuthenticated || authState is AuthFailed) {
          _pcontroller.clear();
          context.snackbar('Sign in failed. Please try again.');
        }
      },
      child: Scaffold(
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
              BlocBuilder<AuthBloc, AuthState>(
                builder: (_, authState) => Opacity(
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}