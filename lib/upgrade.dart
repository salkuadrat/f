import 'shell.dart';

Future<void> upgrade() async {
  await shell.runExecutableArguments('flutter upgrade', []);
}
