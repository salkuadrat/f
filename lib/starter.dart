import 'dart:io';
import 'package:path/path.dart';

import 'templates/templates.dart' as t;

/// generate a Flutter starter project
Future<void> starter(List<String> args) async {
  List<String> params = args.toList();

  String org = '';
  String android = '';
  String ios = '';
  String name = '';
  String template = 'provider';

  List<String> fargs = [];

  if (params.contains('--p')) {
    int idx = params.indexOf('--p');
    name = params[idx + 1];
    fargs.add('--project-name');
    fargs.add(name);
    params.removeAt(idx);
    params.removeAt(idx);
  }

  if (params.contains('--org')) {
    int idx = params.indexOf('--org');
    org = params[idx + 1];
    fargs.add('--org');
    fargs.add(org);
    params.removeAt(idx);
    params.removeAt(idx);
  }

  if (params.contains('--a')) {
    int idx = params.indexOf('--a');
    android = params[idx + 1];
    fargs.add('--android-language');
    fargs.add(android);
    params.removeAt(idx);
    params.removeAt(idx);
  }

  if (params.contains('--i')) {
    int idx = params.indexOf('--i');
    ios = params[idx + 1];
    fargs.add('--ios-language');
    fargs.add(ios);
    params.removeAt(idx);
    params.removeAt(idx);
  }

  if (params.contains('--bloc')) {
    template = 'bloc';
    params.remove('--bloc');
  }

  if (params.contains('--cubit')) {
    template = 'cubit';
    params.remove('--cubit');
  }

  if (params.contains('--getx')) {
    template = 'getx';
    params.remove('--getx');
  }

  if (params.contains('--get')) {
    template = 'getx';
    params.remove('--get');
  }

  /* if (params.contains('--mobx')) {
    template = 'mobx';
    params.remove('--mobx');
  } */

  if (params.contains('--provider')) {
    template = 'provider';
    params.remove('--provider');
  }

  if (params.contains('--riverpod')) {
    template = 'riverpod';
    params.remove('--riverpod');
  }

  String project = params.first;
  fargs.add(project);

  Process process = await Process.start(
    'flutter',
    ['create', ...fargs],
    runInShell: true,
    mode: ProcessStartMode.inheritStdio,
  );

  process.exitCode.then((_) {
    _template(project, template, org);

    print('');
    print('Installing dependencies...');
    print('');

    final res = Process.runSync(
      'cd $project && flutter pub get',
      [],
      runInShell: true,
    );

    print(res.stdout);
    print('');
    print('All done!');
    print('Use this command to run your application:');
    print('');
    print('  \$ cd $project');
    print('  \$ f r');

    exit(0);
  });
}

/* void _install(String project, String package) {
  print('install $package');
  Process.runSync('cd $project && flutter pub add $package', [],
      runInShell: true);
} */

void _directory(String project, String path) {
  print('  $path');
  Directory('$project$path').createSync();
}

void _file(String project, String path) {
  print('  $path');
  File('$project$path').createSync();
}

void _template(String project, String template, String org) {
  print('');
  print('Creating assets...');

  _directory(project, '/assets');
  _directory(project, '/assets/fonts');
  _directory(project, '/assets/icons');
  _directory(project, '/assets/html');
  _directory(project, '/assets/images');
  _directory(project, '/assets/logo');

  _file(project, '/assets/logo/logo.png');
  File('$project/web/icons/icon-192.png').copySync(
    '$project/assets/logo/logo.png',
  );

  print('');
  print('Creating template ${absolute(project)}...');

  _file(project, '/lib/app.dart');

  t.test(project);
  t.manifest(project, org);
  t.gradle(project);
  t.pubspec(project, template);
  t.main_(project, template);
  t.app(project, template);

  _directory(project, '/lib/config');
  _file(project, '/lib/config/config.dart');
  _file(project, '/lib/config/assets.dart');
  _file(project, '/lib/config/colors.dart');
  _file(project, '/lib/config/fonts.dart');
  _file(project, '/lib/config/strings.dart');
  _file(project, '/lib/config/styles.dart');
  _file(project, '/lib/config/themes.dart');

  t.config(project);

  _directory(project, '/lib/data');
  _directory(project, '/lib/data/local');
  _directory(project, '/lib/data/network');

  _file(project, '/lib/data/network/api.dart');
  _file(project, '/lib/data/network/api_constant.dart');
  _file(project, '/lib/data/network/api_handler.dart');
  _file(project, '/lib/data/network/api_exception.dart');

  t.api(project);

  _directory(project, '/lib/models');
  _file(project, '/lib/models/user.dart');

  t.models(project);

  _directory(project, '/lib/modules');

  _auth(project, template);
  _home(project, template);
  _users(project, template);

  _directory(project, '/lib/routes');
  _file(project, '/lib/routes/routes.dart');

  t.routes(project, template);

  _directory(project, '/lib/screens');
  _file(project, '/lib/screens/home.dart');
  _file(project, '/lib/screens/login.dart');
  _file(project, '/lib/screens/splash.dart');
  _file(project, '/lib/screens/users.dart');

  t.screens(project, template);

  _directory(project, '/lib/utils');
  _file(project, '/lib/utils/navigation.dart');
  _file(project, '/lib/utils/prefs.dart');
  _file(project, '/lib/utils/snackbar.dart');
  _file(project, '/lib/utils/theme.dart');

  t.utils(project);

  _directory(project, '/lib/widgets');
  _file(project, '/lib/widgets/buttons.dart');
  _file(project, '/lib/widgets/cached_image.dart');
  _file(project, '/lib/widgets/error.dart');
  _file(project, '/lib/widgets/logo.dart');
  _file(project, '/lib/widgets/loading_more.dart');
  _file(project, '/lib/widgets/user_item.dart');

  t.widgets(project);
}

void _auth(String project, String template) {
  _directory(project, '/lib/modules/auth');
  _file(project, '/lib/modules/auth/auth.dart');

  switch (template) {
    case 'bloc':
      _file(project, '/lib/modules/auth/auth_bloc.dart');
      _file(project, '/lib/modules/auth/auth_event.dart');
      _file(project, '/lib/modules/auth/auth_state.dart');
      break;
    case 'cubit':
      _file(project, '/lib/modules/auth/auth_cubit.dart');
      _file(project, '/lib/modules/auth/auth_state.dart');
      break;
    case 'get':
    case 'getx':
      _file(project, '/lib/modules/auth/auth_controller.dart');
      _file(project, '/lib/modules/auth/auth_bindings.dart');
      break;
    case 'mobx':
      _file(project, '/lib/modules/auth/auth_store.dart');
      break;
    case 'riverpod':
      _file(project, '/lib/modules/auth/auth_notifier.dart');
      _file(project, '/lib/modules/auth/auth_provider.dart');
      _file(project, '/lib/modules/auth/auth_state.dart');
      break;
    case 'provider':
    default:
      _file(project, '/lib/modules/auth/auth_state.dart');
      break;
  }

  _file(project, '/lib/modules/auth/auth_service.dart');

  t.auth(project, template);
}

void _home(String project, String template) {
  _directory(project, '/lib/modules/home');
  _file(project, '/lib/modules/home/home.dart');

  switch (template) {
    case 'bloc':
      _file(project, '/lib/modules/home/home_bloc.dart');
      _file(project, '/lib/modules/home/home_event.dart');
      _file(project, '/lib/modules/home/home_state.dart');
      break;
    case 'cubit':
      _file(project, '/lib/modules/home/home_cubit.dart');
      _file(project, '/lib/modules/home/home_state.dart');
      break;
    case 'get':
    case 'getx':
      _file(project, '/lib/modules/home/home_controller.dart');
      _file(project, '/lib/modules/home/home_bindings.dart');
      break;
    case 'mobx':
      _file(project, '/lib/modules/home/home_store.dart');
      break;
    case 'riverpod':
      _file(project, '/lib/modules/home/home_notifier.dart');
      _file(project, '/lib/modules/home/home_provider.dart');
      _file(project, '/lib/modules/home/home_state.dart');
      break;
    case 'provider':
    default:
      _file(project, '/lib/modules/home/home_state.dart');
      break;
  }

  t.home(project, template);
}

void _users(String project, String template) {
  _directory(project, '/lib/modules/users');
  _file(project, '/lib/modules/users/users.dart');

  switch (template) {
    case 'bloc':
      _file(project, '/lib/modules/users/users_bloc.dart');
      _file(project, '/lib/modules/users/users_event.dart');
      _file(project, '/lib/modules/users/users_state.dart');
      break;
    case 'cubit':
      _file(project, '/lib/modules/users/users_cubit.dart');
      _file(project, '/lib/modules/users/users_state.dart');
      break;
    case 'get':
    case 'getx':
      _file(project, '/lib/modules/users/users_controller.dart');
      _file(project, '/lib/modules/users/users_bindings.dart');
      break;
    case 'mobx':
      _file(project, '/lib/modules/users/users_store.dart');
      break;
    case 'riverpod':
      _file(project, '/lib/modules/users/users_notifier.dart');
      _file(project, '/lib/modules/users/users_provider.dart');
      _file(project, '/lib/modules/users/users_state.dart');
      break;
    case 'provider':
    default:
      _file(project, '/lib/modules/users/users_state.dart');
      break;
  }

  _file(project, '/lib/modules/users/users_service.dart');

  t.users(project, template);
}
