import 'arguments.dart';
import 'shell.dart';

Future<void> attach(List<String> args) async {
  String arg = arguments(args);
  await shell.run('flutter attach $arg');
}