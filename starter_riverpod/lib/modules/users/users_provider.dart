import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:starter_riverpod/modules/users/users.dart';

final usersProvider = StateNotifierProvider<UsersNotifier, UsersState>(
  (ref) => UsersNotifier(UsersService()),
);
