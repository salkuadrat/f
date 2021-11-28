import 'dart:io';

/// alias of `flutter create`
void create(List<String> args) async {
  List<String> params = args.toList();

  String org = '';
  String android = '';
  String ios = '';
  String name = '';

  List<String> fargs = [];

  if (params.contains('--p')) {
    int idx = params.indexOf('--p');
    name = params[idx + 1];
    fargs.add('--project-name');
    fargs.add(name);
    params.removeAt(idx);
    params.removeAt(idx);
  }

  if (params.contains('-p')) {
    int idx = params.indexOf('-p');
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

  if (params.contains('-o')) {
    int idx = params.indexOf('-o');
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

  if (params.contains('-a')) {
    int idx = params.indexOf('-a');
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

  if (params.contains('-i')) {
    int idx = params.indexOf('-i');
    ios = params[idx + 1];
    fargs.add('--ios-language');
    fargs.add(ios);
    params.removeAt(idx);
    params.removeAt(idx);
  }

  String project = params.first;
  params.removeAt(0);

  fargs.add(project);

  Process process = await Process.start(
    'flutter',
    ['create', ...fargs],
    runInShell: true,
    mode: ProcessStartMode.inheritStdio,
  );

  process.exitCode.then((_) {
    if (params.isNotEmpty) {
      for (String package in params) {
        _install(project, package);
      }
    }

    print('');
    print('All done!');
    print('Use this command to run your application:');
    print('');
    print('  \$ cd $project');
    print('  \$ f r');

    exit(0);
  });
}

void _install(String project, String package) {
  print('install $package');
  Process.runSync('cd $project && pub add $package', [], runInShell: true);
}
