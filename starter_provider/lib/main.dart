import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:starter_provider/app.dart';
import 'package:starter_provider/modules/auth/auth.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(ChangeNotifierProvider(
    create: (_) => AuthState(AuthService()),
    child: const App(),
  ));
}
