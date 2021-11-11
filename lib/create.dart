import 'shell.dart';

Future<void> create(List<String> args) async {
  List<String> params = args.toList();
  params.removeAt(0);

  String org = '';
  String android = '';
  String ios = '';
  String name = '';

  if (params.contains('--p')) {
    int idx = params.indexOf('--p');
    name = params[idx + 1];
    name = ' --project-name $name';
    params.removeAt(idx);
    params.removeAt(idx);
  }

  if (params.contains('--org')) {
    int idx = params.indexOf('--org');
    org = params[idx + 1];
    org = ' --org $org';
    params.removeAt(idx);
    params.removeAt(idx);
  }

  if (params.contains('--a')) {
    int idx = params.indexOf('--a');
    android = params[idx + 1];
    android = ' --android-language $android';
    params.removeAt(idx);
    params.removeAt(idx);
  }

  if (params.contains('--i')) {
    int idx = params.indexOf('--i');
    ios = params[idx + 1];
    ios = ' --ios-language $ios';
    params.removeAt(idx);
    params.removeAt(idx);
  }

  String project = params.first;
  String command = 'flutter create$name$org$android$ios $project';

  await shell.run(command);

  params.removeAt(0);

  shell = shell.pushd(project);

  if (params.isNotEmpty) {
    for (String dep in params) {
      await shell.run('flutter pub add $dep');
    }
  }

  print('');
  print('All done!');
  print('In order to run your application, type:');
  print('');
  print('  \$ cd $project');
  print('  \$ f r');
  print('');
}