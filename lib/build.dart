import 'start.dart';

/// alias of `flutter build`
void build(List<String> args) {
  start('flutter', ['build', ...args]);
}

/// alias of `flutter build --split-per-abi`
void buildSplitPerAbi(List<String> args) {
  start('flutter', ['build', '--split-per-abi', ...args]);
}
