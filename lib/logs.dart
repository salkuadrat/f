import 'shell.dart';

Future<void> logs() async {
  await shell.run('flutter logs');
}
