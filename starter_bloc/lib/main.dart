import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:starter_bloc/app.dart';
import 'package:starter_bloc/modules/auth/auth.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(BlocProvider(
    create: (_) => AuthBloc(AuthService()),
    child: const App(),
  ));
}
