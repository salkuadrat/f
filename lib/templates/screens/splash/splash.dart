import 'splash_bloc.dart';
import 'splash_cubit.dart';
import 'splash_getx.dart';
import 'splash_mobx.dart';
import 'splash_provider.dart';
import 'splash_riverpod.dart';

/// generate template for splash screen
void splash(String project, String dir, String template) {
  switch (template) {
    case 'bloc':
      splashBloc(project, dir);
      break;
    case 'cubit':
      splashCubit(project, dir);
      break;
    case 'get':
    case 'getx':
      splashGetx(project, dir);
      break;
    case 'mobx':
      splashMobx(project, dir);
      break;
    case 'riverpod':
      splashRiverpod(project, dir);
      break;
    case 'provider':
    default:
      splashProvider(project, dir);
      break;
  }
}
