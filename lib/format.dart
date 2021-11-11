import 'arguments.dart';
import 'shell.dart';

Future<void> format(List<String> args) async {
  String arg = arguments(args);
  await shell.run('flutter format $arg');
}
