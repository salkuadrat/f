import 'shell.dart';

Future<void> clean() async {
  await shell.runExecutableArguments('flutter clean', []);
}
