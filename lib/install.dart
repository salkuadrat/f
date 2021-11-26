import 'start.dart';

/// alias of `flutter install`
void install(List<String> args) {
  start('flutter', ['install', ...args]);
}
