import 'shell.dart';

Future<void> doctor() async {
  await shell.run('flutter doctor');
}
