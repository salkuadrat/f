import 'arguments.dart';
import 'shell.dart';

Future<void> run(List<String> args) async {
  String arg = arguments(args);
  await shell.run('flutter run $arg');
}

Future<void> runProfile(List<String> args) async {
  String arg = arguments(args);
  await shell.run('flutter run --profile $arg');
}

Future<void> runRelease(List<String> args) async {
  String arg = arguments(args);
  await shell.run('flutter run --release $arg');
}
