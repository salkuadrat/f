import 'shell.dart';

Future<void> drive() async {
  await shell.runExecutableArguments('flutter drive', []);
}
