import 'arguments.dart';
import 'shell.dart';

Future<void> channel(List<String> args) async {
  String arg = arguments(args);
  await shell.run('flutter channel $arg');
}