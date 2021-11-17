import 'start.dart';

void run(List<String> args) {
  start('flutter', ['run', ...args]);
}

void runProfile(List<String> args) {
  start('flutter', ['run', '--profile', ...args]);
}

void runRelease(List<String> args) {
  start('flutter', ['run', '--release', ...args]);
}
