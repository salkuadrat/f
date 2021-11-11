import 'shell.dart';

Future<void> downgrade() async {
  await shell.run('flutter downgrade');
}