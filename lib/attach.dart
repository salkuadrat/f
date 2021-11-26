import 'start.dart';

/// alias of `flutter attach`
void attach(List<String> args) {
  start('flutter', ['attach', ...args]);
}
