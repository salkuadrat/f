import 'start.dart';

void build(List<String> args) {
  start('flutter', ['build', ...args]);
}

void buildSplitPerAbi(List<String> args) {
  start('flutter', ['build', '--split-per-abi', ...args]);
}
