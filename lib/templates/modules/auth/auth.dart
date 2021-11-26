import 'dart:io';

import 'auth_bloc.dart';
import 'auth_cubit.dart';
import 'auth_getx.dart';
import 'auth_mobx.dart';
import 'auth_provider.dart';
import 'auth_riverpod.dart';

/// generate template for module auth
void auth(String project, String template) {
  String dir = '$project/lib/modules/auth';

  switch (template) {
    case 'bloc':
      authBloc(project, dir);
      break;
    case 'cubit':
      authCubit(project, dir);
      break;
    case 'get':
    case 'getx':
      authGetx(project, dir);
      break;
    case 'mobx':
      authMobx(project, dir);
      break;
    case 'riverpod':
      authRiverpod(project, dir);
      break;
    case 'provider':
    default:
      authProvider(project, dir);
      break;
  }

  _service(project, dir);
}

void _service(String project, String dir) {
  File('$dir/auth_service.dart').writeAsStringSync('''
import 'package:$project/data/network/api.dart';

class AuthService {
  Future register(String username, String email, String password) async {
    return await Api.register(username, email, password);
  }

  Future login(String username, String password) async {
    return await Api.login(username, password);
  }

  Future user(int id) async {
    return await Api.user(id);
  }
}''');
}
