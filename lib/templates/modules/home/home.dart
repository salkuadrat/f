import 'home_bloc.dart';
import 'home_cubit.dart';
import 'home_getx.dart';
import 'home_mobx.dart';
import 'home_provider.dart';
import 'home_riverpod.dart';

/// generate template for module home
void home(String project, String template) {
  String dir = '$project/lib/modules/home';

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
