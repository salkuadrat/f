import 'dart:io';

/// generate template for main
void main_(String project, String template) {
  switch (template) {
    case 'bloc':
      _mainBloc(project);
      break;
    case 'cubit':
      _mainCubit(project);
      break;
    case 'get':
    case 'getx':
      _mainGetx(project);
      break;
    case 'mobx':
      _mainMobx(project);
      break;
    case 'riverpod':
      _mainRiverpod(project);
      break;
    case 'provider':
    default:
      _mainProvider(project);
      break;
  }
}

void _mainBloc(String project) {
  File('$project/lib/main.dart').writeAsStringSync('''
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:$project/app.dart';
import 'package:$project/modules/auth/auth.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(BlocProvider(
    create: (_) => AuthBloc(AuthService()),
    child: const App(),
  ));
}''');
}

void _mainCubit(String project) {
  File('$project/lib/main.dart').writeAsStringSync('''
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:$project/app.dart';
import 'package:$project/modules/auth/auth.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(BlocProvider(
    create: (_) => AuthCubit(AuthService()),
    child: const App(),
  ));
}''');
}

void _mainGetx(String project) {
  File('$project/lib/main.dart').writeAsStringSync('''
import 'package:flutter/material.dart';

import 'package:$project/app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const App());
}''');
}

void _mainMobx(String project) {
  File('$project/lib/main.dart').writeAsStringSync('''
import 'package:flutter/material.dart';

import 'package:$project/app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const App());
}''');
}

void _mainRiverpod(String project) {
  File('$project/lib/main.dart').writeAsStringSync('''
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:$project/app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    const ProviderScope(
      child: App(),
    ),
  );
}''');
}

void _mainProvider(String project) {
  File('$project/lib/main.dart').writeAsStringSync('''
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:$project/app.dart';
import 'package:$project/modules/auth/auth.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  
  runApp(ChangeNotifierProvider(
    create: (_) => AuthState(AuthService()),
    child: const App(),
  ));
}''');
}
