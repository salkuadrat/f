import 'shell.dart';

Future<void> emulators() async {
  await shell.run('flutter emulators');
}