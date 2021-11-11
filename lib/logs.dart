import 'shell.dart';

Future<void> logs() async {
  await shell.runExecutableArguments('flutter logs', []);
}
