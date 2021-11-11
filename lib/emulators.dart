import 'shell.dart';

Future<void> emulators() async {
  await shell.runExecutableArguments('flutter emulators', []);
}
