import 'arguments.dart';
import 'shell.dart';

Future<void> test(List<String> args) async {
  String arg = arguments(args);
  await shell.runExecutableArguments('flutter test $arg', []);
}
