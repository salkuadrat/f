import 'shell.dart';

Future<void> doctor() async {
  await shell.runExecutableArguments('flutter doctor', []);
}
