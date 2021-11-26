import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:starter_riverpod/modules/auth/auth.dart';

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>(
  (ref) => AuthNotifier(AuthService()),
);
