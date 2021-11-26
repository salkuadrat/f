import 'dart:io';

import 'users_bloc.dart';
import 'users_cubit.dart';
import 'users_getx.dart';
import 'users_mobx.dart';
import 'users_provider.dart';
import 'users_riverpod.dart';

/// generate template for module users
void users(String project, String template) {
  String dir = '$project/lib/modules/users';

  switch (template) {
    case 'bloc':
      usersBloc(project, dir);
      break;
    case 'cubit':
      usersCubit(project, dir);
      break;
    case 'get':
    case 'getx':
      usersGetx(project, dir);
      break;
    case 'mobx':
      usersMobx(project, dir);
      break;
    case 'riverpod':
      usersRiverpod(project, dir);
      break;
    case 'provider':
    default:
      usersProvider(project, dir);
      break;
  }

  _service(project, dir);
}

void _service(String project, String dir) {
  File('$dir/users_service.dart').writeAsStringSync('''
import 'package:$project/data/network/api.dart';
import 'package:$project/models/user.dart';

class UsersService {
  Future<List<User>?> fetch([String? query, int? page]) async {
    try {
      final res = await Api.users(query, page);

      if (res is Map && res.containsKey('data')) {
        final data = res['data'];

        if (data is List) {
          return data.map<User>((u) => User.fromJson(u)).toList();
        }
      }
    } catch (e) {
      return null;
    }
    
    return null;
  }
}''');
}
