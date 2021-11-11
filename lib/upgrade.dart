import 'shell.dart';

Future<void> upgrade() async {
  await shell.run('flutter upgrade');
}