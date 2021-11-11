import 'shell.dart';

Future<void> downgrade() async {
  await shell.runExecutableArguments('flutter downgrade', []);
}
