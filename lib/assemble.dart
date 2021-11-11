import 'arguments.dart';
import 'shell.dart';

Future<void> assemble(List<String> args) async {
  String arg = arguments(args);
  await shell.runExecutableArguments('flutter assemble $arg', []);
}
