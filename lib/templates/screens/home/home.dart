import 'home_bloc.dart';
import 'home_cubit.dart';
import 'home_getx.dart';
import 'home_mobx.dart';
import 'home_provider.dart';
import 'home_riverpod.dart';

/// generate template for home screen
void home(String project, String dir, String template) {
  switch (template) {
    case 'bloc':
      homeBloc(project, dir);
      break;
    case 'cubit':
      homeCubit(project, dir);
      break;
    case 'get':
    case 'getx':
      homeGetx(project, dir);
      break;
    case 'mobx':
      homeMobx(project, dir);
      break;
    case 'riverpod':
      homeRiverpod(project, dir);
      break;
    case 'provider':
    default:
      homeProvider(project, dir);
      break;
  }
}
