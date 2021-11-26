import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:starter_cubit/app.dart';
import 'package:starter_cubit/modules/auth/auth.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(BlocProvider(
    create: (_) => AuthCubit(AuthService()),
    child: const App(),
  ));
}
