import 'login_bloc.dart';
import 'login_cubit.dart';
import 'login_getx.dart';
import 'login_mobx.dart';
import 'login_provider.dart';
import 'login_riverpod.dart';

/// generate template for login screen
void login(String project, String dir, String template) {
  switch (template) {
    case 'bloc':
      loginBloc(project, dir);
      break;
    case 'cubit':
      loginCubit(project, dir);
      break;
    case 'get':
    case 'getx':
      loginGetx(project, dir);
      break;
    case 'mobx':
      loginMobx(project, dir);
      break;
    case 'riverpod':
      loginRiverpod(project, dir);
      break;
    case 'provider':
    default:
      loginProvider(project, dir);
      break;
  }
}
