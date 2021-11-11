import 'shell.dart';

Future<void> drive() async {
  await shell.run('flutter drive');
}