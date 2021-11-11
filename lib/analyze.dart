import 'arguments.dart';
import 'shell.dart';

Future<void> analyze(List<String> args) async {
  String arg = arguments(args);
  await shell.run('flutter analyze $arg');
}