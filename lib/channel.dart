import 'arguments.dart';
import 'shell.dart';

Future<void> channel(List<String> args) async {
  String arg = arguments(args);
  await shell.runExecutableArguments('flutter channel $arg', []);
}
