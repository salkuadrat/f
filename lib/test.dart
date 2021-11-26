import 'start.dart';

/// alias of `flutter test`
void test(List<String> args) {
  start('flutter', ['test', ...args]);
}
