import 'start.dart';

/// alias of `flutter run`
void run(List<String> args) {
  start('flutter', ['run', ...args]);
}

/// alias of `flutter run --profile`
void runProfile(List<String> args) {
  start('flutter', ['run', '--profile', ...args]);
}

/// alias of `flutter run --release`
void runRelease(List<String> args) {
  start('flutter', ['run', '--release', ...args]);
}
