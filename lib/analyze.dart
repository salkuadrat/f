import 'start.dart';

/// alias of `flutter analyze`
void analyze(List<String> args) {
  start('flutter', ['analyze', ...args]);
}
