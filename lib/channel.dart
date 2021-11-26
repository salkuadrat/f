import 'start.dart';

/// alias of `flutter channel`
void channel(List<String> args) {
  start('flutter', ['channel', ...args]);
}
