import 'arguments.dart';
import 'shell.dart';

Future<void> devices(List<String> args) async {
  String arg = arguments(args);
  await shell.run('flutter devices $arg');
}