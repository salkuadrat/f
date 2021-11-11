import 'arguments.dart';
import 'shell.dart';

Future<void> format(List<String> args) async {
  String arg = arguments(args);
  await shell.runExecutableArguments('flutter format $arg', []);
}
