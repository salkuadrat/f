import 'start.dart';

/// alias of `flutter devices`
void devices(List<String> args) {
  start('flutter', ['devices', ...args]);
}
