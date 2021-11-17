import 'dart:io';

void create(List<String> args) {
  List<String> params = args.toList();

  String org = '';
  String android = '';
  String ios = '';
  String name = '';

  List<String> fcargs = [];

  if (params.contains('--p')) {
    int idx = params.indexOf('--p');
    name = params[idx + 1];
    fcargs.add('--project-name');
    fcargs.add(name);
    params.removeAt(idx);
    params.removeAt(idx);
  }

  if (params.contains('--org')) {
    int idx = params.indexOf('--org');
    org = params[idx + 1];
    fcargs.add('--org');
    fcargs.add(org);
    params.removeAt(idx);
    params.removeAt(idx);
  }

  if (params.contains('--a')) {
    int idx = params.indexOf('--a');
    android = params[idx + 1];
    fcargs.add('--android-language');
    fcargs.add(android);
    params.removeAt(idx);
    params.removeAt(idx);
  }

  if (params.contains('--i')) {
    int idx = params.indexOf('--i');
    ios = params[idx + 1];
    fcargs.add('--ios-language');
    fcargs.add(ios);
    params.removeAt(idx);
    params.removeAt(idx);
  }

  String project = params.first;
  fcargs.add(project);

  final res = Process.runSync('flutter', ['create', ...fcargs], runInShell: true);
  print(res.stdout);

  params.removeAt(0);

  if (params.isNotEmpty) {
    for (String dep in params) {
      print('Install dependency $dep...');
      String cmd = 'cd $project & flutter pub add $dep';
      Process.runSync(cmd, [], runInShell: true);
    }
  }

  print('');
  print('All done!');
  print('Use this command to run your application:');
  print('');
  print('  \$ cd $project');
  print('  \$ f r');
}
