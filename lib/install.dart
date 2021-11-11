import 'arguments.dart';
import 'shell.dart';

Future<void> install(List<String> args) async {
  String arg = arguments(args);
  await shell.run('flutter install $arg');
}
