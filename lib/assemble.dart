import 'start.dart';

/// alias of `flutter assemble`
void assemble(List<String> args) {
  start('flutter', ['assemble', ...args]);
}
