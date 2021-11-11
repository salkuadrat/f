import 'arguments.dart';
import 'shell.dart';

Future<void> build(List<String> args) async {
  String arg = arguments(args);
  await shell.run('flutter build $arg');
}

Future<void> buildSplitPerAbi(List<String> args) async {
  String arg = arguments(args);
  await shell.run('flutter build --split-per-abi $arg');
}