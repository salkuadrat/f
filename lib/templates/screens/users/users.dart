import 'users_bloc.dart';
import 'users_cubit.dart';
import 'users_getx.dart';
import 'users_mobx.dart';
import 'users_provider.dart';
import 'users_riverpod.dart';

/// generate template for users screen
void users(String project, String dir, String template) {
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
}
