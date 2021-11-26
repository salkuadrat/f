import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:example/app.dart';
import 'package:example/modules/auth/auth.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(ChangeNotifierProvider(
    create: (_) => AuthState(AuthService()),
    child: const App(),
  ));
}
